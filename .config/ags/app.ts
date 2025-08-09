import app from "ags/gtk4/app";
import style from "./style.scss";
import NotificationPopups from "./widget-tsx/NotifyPopups";
import Applauncher from "./widget-tsx/Applauncher";
import Mpris from "./widget-tsx/Mpris";
import Bar from "./widget-tsx/Bar";
import { doOptionalAsVar, doEverythingAsVarAsync } from "./variable";
import Var from "./variable";
import GLib from "gi://GLib";
import Gtk from "gi://Gtk?version=4.0";

let applauncher: Gtk.Window

app.start({
  css: style,
  requestHandler(request, res) {
    const [, argv] = GLib.shell_parse_argv(request)
    if (!argv) return res("argv parse error")

    switch (argv[0]) {
      case "toggle":
        applauncher.visible = !applauncher.visible
        return res("ok")
      default:
        return res("unknown command")
    }
  },
  main() {
    NotificationPopups()
    applauncher = Applauncher() as Gtk.Window
    app.add_window(applauncher)
    applauncher.hide()
    app.get_monitors().forEach(monitor => new Bar(monitor));
    app.get_monitors().forEach(monitor => new Mpris(monitor));
    app.get_monitors().forEach(monitor => new applauncher(monitor));
    doEverythingAsVarAsync()
    doOptionalAsVar()
  },
});