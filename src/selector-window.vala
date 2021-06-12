public class AreaSelector.Window : Gtk.Window {

    public Window (Gtk.Application app) {
        Object (application: app);
        fullscreen ();
        add_css_class ("transparent");
    }

    static construct {
    }
}
