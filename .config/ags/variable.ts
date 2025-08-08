import { init as i18n_init, getString } from './i18n/i18n'
import { parseApps } from "./hacks/parseApps";
import { execAsync } from "ags/process";

i18n_init()
globalThis['getString'] = getString

export async function doEverythingAsVarAsync() {
  await i18n_init();
  globalThis['getString'] = getString;
}

export function doEverythingAsVar() {
  execAsync(`if [ ! -e ~/.local/share/hyprmaterial3/firstBoot.txt ]; then \
  notify-send "Welcome!" && \
  touch ~/.local/share/hyprmaterial3/firstBoot.txt; \
fi`);
}

export function doOptionalAsVar() {
    print("Loaded apps:", JSON.stringify(parseApps, null, 2));
}

export default { doEverythingAsVar }