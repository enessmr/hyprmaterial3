import app from "ags/gtk4/app";
import style from "./style.scss";
import NotificationPopups from "./widget-tsx/NotifyPopups"
import Bar from "./widget-tsx/Bar";
import { doOptionalAsVar, doEverythingAsVarAsync } from "./variable";
import Var from "./variable";

app.start({
  css: style,
  main() {
    NotificationPopups()
    app.get_monitors().forEach(monitor => new Bar(monitor));
    doEverythingAsVarAsync()
    doOptionalAsVar()
  },
});