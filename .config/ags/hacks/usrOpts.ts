import { readFile } from "ags/file"
import { parseJSONC } from './parseConfig';
const configDir = "/home/lfsuser/.config/ags";
function overrideConfigRecursive(
  userOverrides: Record<string, any>,
  configOptions: Record<string, any> = {}
): void {
  for (const [key, value] of Object.entries(userOverrides)) {
    const currentVal = configOptions[key];

    if (
      value !== null &&
      typeof value === 'object' &&
      !Array.isArray(value)
    ) {
      if (
        typeof currentVal !== 'object' ||
        currentVal === null ||
        Array.isArray(currentVal)
      ) {
        configOptions[key] = {};
      }
      overrideConfigRecursive(value, configOptions[key]);
    } else {
      configOptions[key] = value;
    }
  }
}

// Load default options from ~/.config/ags/modules/.configuration/default_options.jsonc
const defaultConfigFile = `${configDir}/.config/config.jsonc`;
const defaultConfigFileContents = readFile(defaultConfigFile);
const defaultConfigOptions = parseJSONC(defaultConfigFileContents);

// Clone the default config to avoid modifying the original
let configOptions = JSON.parse(JSON.stringify(defaultConfigOptions));

// Load user overrides
const userOverrideFile = `${configDir}/opts.jsonc`;
const userOverrideContents = readFile(userOverrideFile);
const userOverrides = parseJSONC(userOverrideContents);

// Override defaults with user's options
overrideConfigRecursive(userOverrides, configOptions);

globalThis['userOptionsDefaults'] = defaultConfigOptions;
globalThis['userOptions'] = configOptions;
export default configOptions;