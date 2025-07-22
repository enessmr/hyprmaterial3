import Gtk from 'gi://Gtk?version=4.0'; // Needed to create windows
import app from "ags/gtk4/app";
import style from "./style.scss";
import Bar from "./widget-tsx/Bar";
import Gdk from 'gi://Gdk?version=4.0'; // Needed for monitor information
import { parseApps } from "./hacks/parseApps";
import Astal from 'gi://Astal?version=4.0'; // Needed for Astal functionalities
import { subprocess, exec, execAsync, createSubprocess } from "ags/process"

app.start({
  css: style,
  main() {
    // Create bars per monitor (you probably do this already)
    app.get_monitors().forEach(monitor => new Bar(monitor));
    execAsync("matugen image ~/Pictures/.Wallpapers/wallpaper.jpg")
    print("Loaded apps:", JSON.stringify(parseApps, null, 2));
  },
});