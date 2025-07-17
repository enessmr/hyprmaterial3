import { createBinding, For, With } from "ags";
import Gtk from "gi://Gtk";
import { execAsync } from "ags/process";
import Gdk from "gi://Gdk";
import Astal from "gi://Astal4";

function createButton(label: string, command: string) {
  return (
    <button
      onClicked={() => execAsync(command.split(" "))}
      css="padding: 0.5rem 1rem; border-radius: 1rem; background-color: rgba(255,255,255,0.1); margin: 4px;"
    >
      {label}
    </button>
  );
}

export default function ButtonsOnDesktop(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT } = Astal.WindowAnchor;

  return (
    <window
      visible
      name="buttons-on-desktop"
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      gdkmonitor={gdkmonitor}
      anchor={TOP | LEFT}
      css="padding: 1rem; width: 200px;"
    >
      <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
        {createButton("󰍉 Launcher", "rofi -show drun")}
        {createButton(" Files", "thunar")}
        {createButton(" Terminal", "alacritty")}
      </box>
    </window>
  );
}
