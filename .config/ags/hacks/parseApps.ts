import GLib from 'gi://GLib?version=2.0';

const configPath = GLib.build_filenamev([
  GLib.get_home_dir(),
  '.config',
  'ags',
  '.config',
  'apps.json',
]);

let appsJsonStr: string;
try {
  const [ok, contents] = GLib.file_get_contents(configPath);
  if (!ok) throw new Error(`Failed to read file: ${configPath}`);
  appsJsonStr = imports.byteArray.toString(contents);
} catch (e) {
  logError(e, 'Could not load apps.json');
  appsJsonStr = '{}';
}

let appsRaw: unknown;
try {
  appsRaw = JSON.parse(appsJsonStr);
  console.log('Parsed apps.json successfully');
} catch (e) {
  logError(e, 'Failed to parse apps.json');
  appsRaw = {};
}

const parseApps = appsRaw as Record<string, string>;

export { parseApps };