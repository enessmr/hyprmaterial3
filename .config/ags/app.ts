import Gtk from 'gi://Gtk'; // Needed to create windows
import app from "ags/gtk4/app";
import style from "./style.scss";
import Bar from "./widget-tsx/Bar";
import ButtonsOnDesktop from "./widget-tsx/ButtonsOnDesktop";

app.start({
  css: style,
  main() {
    // Create bars per monitor (you probably do this already)
    app.get_monitors().forEach(monitor => new Bar(monitor));

    // Create a floating window per monitor to hold your buttons
    app.get_monitors().forEach(monitor => {
      const win = new Gtk.Window({
        name: "button-window",
        visible: true,
        // Position & size for your buttons window on this monitor
        width_request: 200,
        height_request: 200,
        // You can position with monitor geometry if you want exact placement
      });

      const buttons = new ButtonsOnDesktop();
      win.set_child(buttons);
    });
  },
});
