// SPDX-FileCopyrightText: Copyright 2021 SeaDve
// SPDX-License-Identifier: GPL-3.0-or-later

[GtkTemplate (ui = "/io/github/seadve/AreaSelector/selector-window.ui")]
public class AreaSelector.Window : Gtk.Window {
    public signal void captured (int x, int y, int w, int h, int scr_w, int scr_h);
    public signal void cancelled ();

    private bool dragging { get; set; }
    private Point start_point { get; set; }
    private Point end_point { get; set; }

    [GtkChild]
    private unowned Gtk.DrawingArea drawing_area;

    public Window (Gtk.Application app) {
        Object (application: app);
    }

    construct {
        this.fullscreen ();
        this.drawing_area.set_cursor_from_name ("crosshair");
    }

    struct Point {
        public double x;
        public double y;
    }

    struct Rectangle {
        public double x;
        public double y;
        public double w;
        public double h;
    }

    [GtkCallback]
    private void on_pressed_notify (int n_press, double x, double y) {
        this.dragging = true;
        this.start_point = { x, y };
    }

    [GtkCallback]
    private void on_released_notify (int n_press, double x, double y) {
        this.dragging = false;
        this.end_point = { x, y };

        var rectangle = this.get_geometry (this.start_point, this.end_point);
        var screen_width = this.get_size (Gtk.Orientation.HORIZONTAL);
        var screen_height = this.get_size (Gtk.Orientation.VERTICAL);

        this.captured ((int) rectangle.x, (int) rectangle.y,
                       (int) rectangle.w, (int) rectangle.h,
                       screen_width, screen_height);
    }

    [GtkCallback]
    private void on_motion_notify (double x, double y) {
        if (!dragging) {
            return;
        };

        var w = x - this.start_point.x;
        var h = y - this.start_point.y;

        this.drawing_area.set_draw_func ((da, ctx, da_w, da_h) => {
            ctx.rectangle (start_point.x, start_point.y, w, h);
            ctx.set_source_rgba (0.1, 0.45, 0.8, 0.3);
            ctx.fill ();

            ctx.rectangle (start_point.x, start_point.y, w, h);
            ctx.set_source_rgb (0.1, 0.45, 0.8);
            ctx.set_line_width (1);
            ctx.stroke ();
        });
    }

    [GtkCallback]
    private bool on_key_pressed_notify (uint keyval, uint keycode) {
        if (keyval == 65307) {
            this.cancelled ();
        };
        return true;
    }

    private Rectangle get_geometry (Point p1, Point p2) {
        var min_x = p1.x > p2.x ? p2.x : p1.x;
        var min_y = p1.y > p2.y ? p2.y : p1.y;

        var w = (p1.x - p2.x).abs ();
        var h = (p1.y - p2.y).abs ();

        if (w == 0 && h == 0) {
            w = min_x;
            h = min_y;
            min_x = 0;
            min_y = 0;
        };

        return { min_x, min_y, w, h };
    }
}
