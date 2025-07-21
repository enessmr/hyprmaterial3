import app from "ags/gtk4/app"
import GLib from "gi://GLib"
import Astal from "gi://Astal?version=4.0"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import AstalBattery from "gi://AstalBattery"
import AstalNetwork from "gi://AstalNetwork"
import { For, With, createBinding } from "ags"
import { createPoll } from "ags/time"
import { execAsync } from "ags/process"

const adwaitaToMaterial: Record<string, string> = {
  // System
  "system-shutdown": "power_settings_new",
  "system-reboot": "restart_alt",
  "dialog-error": "error",
  "dialog-warning": "warning",
  "dialog-information": "info",

  // Media
  "media-playback-start": "play_arrow",
  "media-playback-pause": "pause",
  "media-playback-stop": "stop",
  "media-skip-forward": "skip_next",
  "media-skip-backward": "skip_previous",
  "audio-volume-muted": "volume_off",
  "audio-volume-low": "volume_down",
  "audio-volume-high": "volume_up",

  // Network
  "network-wireless-signal-excellent": "wifi",
  "network-wired": "lan",
  "network-offline": "wifi_off",

  // Power / Battery
  "battery-full": "battery_full",
  "battery-good": "battery_5_bar",
  "battery-medium": "battery_4_bar",
  "battery-low": "battery_2_bar",
  "battery-empty": "battery_alert",
  "battery-caution": "battery_unknown",
  "battery-missing-symbolic": "battery_unknown",

  // Devices
  "computer": "devices",
  "smartphone": "smartphone",
  "input-keyboard": "keyboard",
  "input-mouse": "mouse",
  "video-display": "monitor",
  "camera-photo": "photo_camera",
  "camera-video": "videocam",

  // Folders
  "folder": "folder",
  "folder-download": "folder",
  "folder-documents": "folder",
  "folder-pictures": "folder",
  "user-home": "home",
  "user-trash": "delete",

  // Apps
  "utilities-terminal": "terminal",
  "internet-web-browser": "language",
  "emblem-default": "check_circle",
};

export function convertAdwaitaIcon(adwaita: string): string {
  return adwaitaToMaterial[adwaita] ?? "help"; // fallback icon
}

function Wireless() {
  const network = AstalNetwork.get_default()
  const wifi = createBinding(network, "wifi")
  const lan = createBinding(network, "wired")

  const sorted = (arr: Array<AstalNetwork.AccessPoint>) => {
    return arr.filter((ap) => !!ap.ssid).sort((a, b) => b.strength - a.strength)
  }

  async function connect(ap: AstalNetwork.AccessPoint) {
    // connecting to ap is not yet supported
    // https://github.com/Aylur/astal/pull/13
    try {
      await execAsync(`nmcli d wifi connect ${ap.bssid}`)
    } catch (error) {
      // you can implement a popup asking for password here
      console.error(error)
    }
  }

  return (
    <box>
      <With value={wifi}>
        {(wifi) =>
          wifi && (
            <box>
              <label
                name="material-symbols"
                label="wifi"
              />
              <label
                name="roboto"
                label="Not implemented yet% on signal strength"
              />
            </box>
          )
        }
      </With>
      <With value={lan}>
        {(lan) =>
          lan && (
            <label
              name="material-symbols-unfilled-lan"
              label="lan"
            />
          )
        }
      </With>
    </box>
  )
}

function Battery() {
  const battery = AstalBattery.get_default();

  const percent = createBinding(
    battery,
    "percentage",
  )((p) => `${Math.floor(p * 100)}%`);

  const icon = createBinding(battery, "icon-name");
  const material = createBinding(battery, "icon-name")(convertAdwaitaIcon);

  return (
    <box>
      <label
        name="battery-icon"
        label={material}
      />
      <label
        name="roboto"
        label={percent}
      />
    </box>
  );
}


function Clock({ format = "%H:%M" }) {
  const time = createPoll("", 1000, () => {
    return GLib.DateTime.new_now_local().format(format)!
  })

  return (
    <label label={time} name="clock" />
  )
}

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return (
    <window
      visible
      name="bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox>
        <box $type="start">
          <Clock />
        </box>
        <box $type="end">
          <Wireless />
          <Battery />
        </box>
      </centerbox>
    </window>
  )
}