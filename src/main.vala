// SPDX-FileCopyrightText: Copyright 2021 SeaDve
// SPDX-License-Identifier: GPL-3.0-or-later

int main (string[] argv) {

    var app = new Gtk.Application ("io.github.seadve.AreaSelector",
                                   GLib.ApplicationFlags.FLAGS_NONE);

    app.activate.connect (() => {
        var window = new AreaSelector.Window (app);
        window.captured.connect ((x, y, w, h, scr_w, scr_h) => {
            stdout.printf ("%d %d %d %d %d %d", x, y, w, h, scr_w, scr_h);
            window.close ();
        });

        window.cancelled.connect (() => {
            window.close ();
        });

        window.present ();
    });
    return app.run (argv);
}
