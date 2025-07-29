import app from "ags/gtk4/app";
import style from "./style.scss";
import Bar from "./widget-tsx/Bar";
import { parseApps } from "./hacks/parseApps";

app.start({
  css: style,
  main() {
    // Create bars per monitor (you probably do this already)
    app.get_monitors().forEach(monitor => new Bar(monitor));
    print("Loaded apps:", JSON.stringify(parseApps, null, 2));
  },
});