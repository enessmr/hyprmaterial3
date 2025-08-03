import app from "ags/gtk4/app";
import style from "./style.scss";
import NotificationPopups from "./widget-tsx/NotifyPopups"
import Bar from "./widget-tsx/Bar";
import { init as i18n_init, getString } from './i18n/i18n'
import { parseApps } from "./hacks/parseApps";

i18n_init()
globalThis['getString'] = getString

app.start({
  css: style,
  main() {
    NotificationPopups()
    app.get_monitors().forEach(monitor => new Bar(monitor));
    print("Loaded apps:", JSON.stringify(parseApps, null, 2));
  },
});