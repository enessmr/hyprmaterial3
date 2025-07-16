import app from "ags/gtk4/app"
import style from "../style.scss"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import Hyprland from "gi://AstalHyprland"

const hyprland = Hyprland.get_default()

for (const client of hyprland.get_clients()) {
  print(client.title)
}
class Bar {
  constructor() {
    print("I FUCKING INITALIZED")
  }
}

export default Bar;
