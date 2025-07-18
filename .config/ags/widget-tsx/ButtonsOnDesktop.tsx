import Gtk from "gi://Gtk";
import Gdk from "gi://Gdk";
import Astal from "gi://Astal?version=4.0";
import GLib from "gi://GLib?version=2.0";
import Cairo from "gi://cairo";

interface AppConfig {
  qqsCommand: string;
  launcherCommand: string;
}

const DEFAULT_CONFIG_PATH = ".config/ags/.config/apps.json";

// Load JSON configuration with error handling
function loadConfig(): AppConfig {
  const path = GLib.build_filenamev([
    GLib.get_home_dir(),
    ...DEFAULT_CONFIG_PATH.split("/")
  ]);

  try {
    const [ok, contents] = GLib.file_get_contents(path);
    if (!ok) {
      throw new Error(`Failed to read config from ${path}`);
    }
    const config = JSON.parse(imports.byteArray.toString(contents));
    
    // Validate and set defaults for missing properties
    return {
      qqsCommand: config.qqsCommand || "ags toggle qqs",
      launcherCommand: config.launcherCommand || "rofi -show drun"
    };
  } catch (error) {
    console.error("Error loading config:", error);
    return {
      qqsCommand: "ags toggle qqs",
      launcherCommand: "rofi -show drun"
    };
  }
}

// Create the Android 5 app drawer button
function createAppDrawerButton(
  size: number = 60,
  onClick: () => void
) {
  const drawingArea = new Gtk.DrawingArea({
    widthRequest: size,
    heightRequest: size,
  });

  // Cleanup on destroy to prevent GTK assertion errors
  drawingArea.connect("destroy", () => {
    drawingArea.set_draw_func(null);
  });

  const clickGesture = new Gtk.GestureClick();
  clickGesture.connect("pressed", onClick);
  drawingArea.add_controller(clickGesture);

  drawingArea.set_draw_func((_, cr, width, height) => {
    const centerX = width / 2;
    const centerY = height / 2;
    const smallRadius = size * 0.08;
    const largeRadius = size * 0.25;
    const gridSpacing = size * 0.15;
    
    cr.setSourceRGB(1, 1, 1);
    cr.setLineWidth(2);
    
    const positions = [
      [-gridSpacing, -gridSpacing],
      [gridSpacing, -gridSpacing],
      [-gridSpacing, 0],
      [gridSpacing, 0],
      [-gridSpacing, gridSpacing],
      [gridSpacing, gridSpacing]
    ];
    
    positions.forEach(([x, y]) => {
      cr.arc(centerX + x, centerY + y, smallRadius, 0, 2 * Math.PI);
      cr.fill();
    });
    
    cr.arc(centerX, centerY, largeRadius, 0, 2 * Math.PI);
    cr.stroke();
  });

  return drawingArea;
}

// Create QQS button (simple filled circle)
function createQQSButton(
  size: number = 60,
  onClick: () => void
) {
  const drawingArea = new Gtk.DrawingArea({
    widthRequest: size,
    heightRequest: size,
  });

  // Cleanup on destroy to prevent GTK assertion errors
  drawingArea.connect("destroy", () => {
    drawingArea.set_draw_func(null);
  });

  const clickGesture = new Gtk.GestureClick();
  clickGesture.connect("pressed", onClick);
  drawingArea.add_controller(clickGesture);

  drawingArea.set_draw_func((_, cr, width, height) => {
    const centerX = width / 2;
    const centerY = height / 2;
    const radius = size * 0.4;
    
    cr.setSourceRGB(1, 1, 1);
    cr.arc(centerX, centerY, radius, 0, 2 * Math.PI);
    cr.fill();
  });

  return drawingArea;
}

function createTopWindow(
  gdkmonitor: Gdk.Monitor,
  command: string
) {
  return (
    <window
      visible={true}
      name="qqs-button"
      exclusivity={Astal.Exclusivity.IGNORE}
      gdkmonitor={gdkmonitor}
      anchor={Astal.WindowAnchor.TOP}
      layer={Astal.Layer.BACKGROUND}
      css="background-color: transparent;"
    >
      {createQQSButton(60, () => {
        Utils.exec(command);
      })}
    </window>
  );
}

function createBottomWindow(
  gdkmonitor: Gdk.Monitor,
  command: string
) {
  return (
    <window
      visible={true}
      name="launcher-button"
      exclusivity={Astal.Exclusivity.IGNORE}
      gdkmonitor={gdkmonitor}
      anchor={Astal.WindowAnchor.BOTTOM}
      layer={Astal.Layer.BACKGROUND}
      css="background-color: transparent;"
    >
      {createAppDrawerButton(60, () => {
        Utils.exec(command);
      })}
    </window>
  );
}

export default function ButtonsOnDesktop(gdkmonitor: Gdk.Monitor) {
  // Load configuration
  const config = loadConfig();
  
  return (
    <box>
      {createTopWindow(gdkmonitor, config.qqsCommand)}
      {createBottomWindow(gdkmonitor, config.launcherCommand)}
    </box>
  );
}