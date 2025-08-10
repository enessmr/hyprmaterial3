import app from "ags/gtk4/app"
import Astal from "gi://Astal?version=4.0"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
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
      hexpand={false}
      vexpand={false}
      widthRequest={250}
      valign={Gtk.Align.START}
    >
      <For each={players}>
        {(player) => (
          <box
            spacing={4}
            widthRequest={250}
            hexpand={false}
            vexpand={false}
            valign={Gtk.Align.START}
          >
            <box overflow={Gtk.Overflow.HIDDEN} css="border-radius: 8px;">
              <image
                pixelSize={64}
                file={createBinding(player, "coverArt")}
                name="image"
              />
            </box>
            <box
              valign={Gtk.Align.CENTER}
              orientation={Gtk.Orientation.VERTICAL}
              hexpand={false}
              vexpand={false}
            >
              <label xalign={0} label={createBinding(player, "title")} name="roboto" />
              <label xalign={0} label={createBinding(player, "artist")} name="roboto" />
            </box>
            <box
              hexpand={false}
              vexpand={false}
              halign={Gtk.Align.END}
              valign={Gtk.Align.CENTER}
              spacing={4}
            >
              <button
                name="pbbtns"
                widthRequest={44}
                heightRequest={40}
                hexpand={false}
                vexpand={false}
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
                hexpand={false}
                vexpand={false}
                valign={Gtk.Align.CENTER}
                halign={Gtk.Align.CENTER}
                onClicked={() => player.play_pause()}
                visible={createBinding(player, "canControl")}
              >
                <box
                    css="
                        margin-left: 10px;
                        /*           ⬆⬆ PERFECTLY MAKE IT IN THE CENTER AWAHAHAHAHA */
                    "
                >
                    <image
                        iconName="media-playback-start-symbolic"
                        visible={createBinding(
                            player,
                            "playbackStatus",
                        )((s) => s === AstalMpris.PlaybackStatus.PLAYING)}
                    />
                    <image
                        iconName="media-playback-pause-symbolic"
                        visible={createBinding(
                            player,
                            "playbackStatus",
                        )((s) => s !== AstalMpris.PlaybackStatus.PLAYING)}
                    />
                </box>
              </button>
              <button
                name="pbbtns"
                widthRequest={44}
                heightRequest={40}
                hexpand={false}
                vexpand={false}
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
    >
      <Mpris />
    </window>
  )
}
