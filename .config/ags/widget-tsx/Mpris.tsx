import app from "ags/gtk4/app"
import Astal from "gi://Astal?version=4.0"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import Pango from "gi://Pango"
import AstalMpris from "gi://AstalMpris"
import AstalApps from "gi://AstalApps"
import { For, createBinding } from "ags"

function Mpris() {
  const mpris = AstalMpris.get_default()
  const apps = new AstalApps.Apps()
  const players = createBinding(mpris, "players")

  return (
    <box
      spacing={4}
      orientation={Gtk.Orientation.VERTICAL}
      name="mprisbox"
      valign={Gtk.Align.START}
      halign={Gtk.Align.START}
      hexpand={false}
    >
      <For each={players}>
        {(player) => (
          <box
            spacing={4}
            valign={Gtk.Align.START}
            hexpand={false}
          >
            <box 
              overflow={Gtk.Overflow.HIDDEN} 
              css="border-radius: 8px;"
              heightRequest={64}
              widthRequest={64}
            >
              <image
                heightRequest={64}
                widthRequest={64}
                file={createBinding(player, "coverArt")}
                name="image"
              />
            </box>
            <box
              valign={Gtk.Align.CENTER}
              orientation={Gtk.Orientation.VERTICAL}
              hexpand={true}
              halign={Gtk.Align.FILL}
              css="min-width: 120px; max-width: 160px;"
            >
              <label 
                xalign={0} 
                label={createBinding(player, "title")} 
                name="roboto"
                ellipsize={Pango.EllipsizeMode.END}
                lines={1}
              />
              <label 
                xalign={0} 
                label={createBinding(player, "artist")} 
                name="roboto"
                ellipsize={Pango.EllipsizeMode.END}
                lines={1}
              />
            </box>
            <box
              halign={Gtk.Align.END}
              valign={Gtk.Align.CENTER}
              spacing={4}
              hexpand={false}
            >
              <button
                name="pbbtns"
                widthRequest={44}
                heightRequest={40}
                valign={Gtk.Align.CENTER}
                halign={Gtk.Align.CENTER}
                onClicked={() => player.previous()}
                visible={createBinding(player, "canGoPrevious")}
              >
                <image iconName="media-seek-backward-symbolic" />
              </button>
              <button
                name="pbbtns"
                widthRequest={44}
                heightRequest={40}
                valign={Gtk.Align.CENTER}
                halign={Gtk.Align.CENTER}
                onClicked={() => player.play_pause()}
                visible={createBinding(player, "canControl")}
              >
                <box
                    css="margin-left: 10px;"
                >
                    <image
                        iconName="media-playback-start-symbolic"
                        visible={createBinding(
                            player,
                            "playbackStatus",
                        )((s) => s !== AstalMpris.PlaybackStatus.PLAYING)}
                    />
                    <image
                        iconName="media-playback-pause-symbolic"
                        visible={createBinding(
                            player,
                            "playbackStatus",
                        )((s) => s === AstalMpris.PlaybackStatus.PLAYING)}
                    />
                </box>
              </button>
              <button
                name="pbbtns"
                widthRequest={44}
                heightRequest={40}
                valign={Gtk.Align.CENTER}
                halign={Gtk.Align.CENTER}
                onClicked={() => player.next()}
                visible={createBinding(player, "canGoNext")}
              >
                <image iconName="media-seek-forward-symbolic" />
              </button>
            </box>
          </box>
        )}
      </For>
    </box>
  )
}

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP } = Astal.WindowAnchor

  return (
    <window
      name="mpris"
      gdkmonitor={gdkmonitor}
      anchor={TOP}
      application={app}
      layer={Astal.Layer.OVERLAY}
      halign={Gtk.Align.START}
      hexpand={false}
    >
      <Mpris />
    </window>
  )
}