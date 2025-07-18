import Gtk from 'gi://Gtk?version=4.0'; // Needed to create windows
import app from "ags/gtk4/app";
import style from "./style.scss";
import Bar from "./widget-tsx/Bar";
import ButtonsOnDesktop from "./widget-tsx/ButtonsOnDesktop";
import Gdk from 'gi://Gdk?version=4.0'; // Needed for monitor information
import { parseApps } from "./hacks/parseApps";

app.start({
  css: style,
  main() {
    // Create bars per monitor (you probably do this already)
    app.get_monitors().forEach(monitor => new Bar(monitor));
    app.get_monitors().forEach(monitor => new ButtonsOnDesktop(monitor));
    print("Loaded apps:", JSON.stringify(parseApps, null, 2));
  },
});
