import { init as i18n_init, getString } from './i18n/i18n'
import { parseApps } from "./hacks/parseApps";

i18n_init()
globalThis['getString'] = getString

export async function doEverythingAsVarAsync() {
  await i18n_init();
  globalThis['getString'] = getString;
}

export function doEverythingAsVar() {}

export function doOptionalAsVar() {
    print("Loaded apps:", JSON.stringify(parseApps, null, 2));
}

export default { doEverythingAsVar }