import app from "ags/gtk4/app"
import GLib from "gi://GLib"
import Astal from "gi://Astal?version=4.0"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import AstalBattery from "gi://AstalBattery"
import AstalPowerProfiles from "gi://AstalPowerProfiles"
import AstalNetwork from "gi://AstalNetwork"
import { For, With, createBinding } from "ags"
import { createPoll } from "ags/time"
import { execAsync } from "ags/process"

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
  const battery = AstalBattery.get_default()

  const percent = createBinding(
    battery,
    "percentage",
  )((p) => `${Math.floor(p * 100)}%`)

  return (
    <box>
      {/*<image iconName={createBinding(battery, "iconName")} name="battery" />
      <label label={percent} name="icon" />*/}
      <label name="battery-icon" label="battery_android_question" />
      <label label="Not implemented yet%" name="battery-percent" />
    </box>
  )
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