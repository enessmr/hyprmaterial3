import GLib from 'gi://GLib?version=2.0';
const ByteArray = imports.byteArray;

export function parseJSONC(jsoncString: string) {
    let result = "";
    let inString = false;
    let inSingleQuote = false;
    let inMultiLineComment = false;
    let inSingleLineComment = false;

    for (let i = 0; i < jsoncString.length; i++) {
        let char = jsoncString[i];
        let nextChar = jsoncString[i + 1];

        if (!inSingleLineComment && !inMultiLineComment) {
            if (char === '"' && !inSingleQuote) {
                inString = !inString;
            } else if (char === "'" && !inString) {
                inSingleQuote = !inSingleQuote;
            }
        }

        if (!inString && !inSingleQuote && !inMultiLineComment && char === '/' && nextChar === '/') {
            inSingleLineComment = true;
            i++;
            continue;
        }

        if (!inString && !inSingleQuote && !inSingleLineComment && char === '/' && nextChar === '*') {
            inMultiLineComment = true;
            i++;
            continue;
        }

        if (inSingleLineComment && (char === '\n' || char === '\r')) {
            inSingleLineComment = false;
        }

        if (inMultiLineComment && char === '*' && nextChar === '/') {
            inMultiLineComment = false;
            i++;
            continue;
        }

        if (!inSingleLineComment && !inMultiLineComment) {
            result += char;
        }
    }

    result = result.replace(/,\s*([\]}])/g, '$1');
    return JSON.parse(result);
}

const configPath = GLib.build_filenamev([
    GLib.get_home_dir(),
    '.config',
    'ags',
    '.config',
    'config.jsonc',
]);

let configRaw: unknown;
try {
    const [ok, contents] = GLib.file_get_contents(configPath);
    if (!ok) throw new Error(`Failed to read file: ${configPath}`);

    const jsonc = ByteArray.toString(contents);
    configRaw = parseJSONC(jsonc);
    print('Parsed config.jsonc successfully');
} catch (e) {
    logError(e, 'Failed to parse config.jsonc');
    configRaw = {};
}

const config = configRaw as {
    i18n?: {
        locale?: string;
    };
};

export { config };
