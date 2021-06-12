/* main.vala
 *
 * Copyright 2021 SeaDve
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

int main (string[] argv) {

    var app = new Gtk.Application ("com.github.seadve.AreaSelector",
                                   GLib.ApplicationFlags.FLAGS_NONE);


    app.activate.connect (() => {
        var css_provider = new Gtk.CssProvider ();
        Gtk.StyleContext.add_provider_for_display (
            (!) Gdk.Display.get_default (),
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );

        unowned var css_data = (uint8[]) ".transparent { background: rgba(0, 0, 0, 0.3); }";  // Return opacity to 0.004
        css_provider.load_from_data (css_data);

        var window = new AreaSelector.Window (app);
        window.present ();
    });
    return app.run (argv);
}
