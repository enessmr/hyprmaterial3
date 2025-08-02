import Gio from "gi://Gio";
import GLib from "gi://GLib";
import configOptions from "../hacks/usrOpts";

const { langCode, Extra_logs } = configOptions.i18n;

const translations: Record<string, Record<string, string>> = {};

let currentLanguage = langCode || getLanguageCode();

function getLanguageCode(): string {
    let langEnv = GLib.getenv('LANG') || GLib.getenv('LANGUAGE') || 'Default.';
    let langCode = langEnv.split('.')[0];
    return langCode;
}

function loadLanguageAsync(lang: string): Promise<void> {
    return new Promise((resolve) => {
        if (translations[lang]) {
            // Already loaded
            resolve();
            return;
        }

        let filePath = `~/.config/ags/i18n/locales/${lang}.json`;
        filePath = filePath.replace(/^~/, GLib.get_home_dir());
        let file = Gio.File.new_for_path(filePath);

        file.load_contents_async(null, (source, result) => {
            try {
                let [success, contents] = source.load_contents_finish(result);
                if (success) {
                    let decoder = new TextDecoder('utf-8');
                    let jsonString = decoder.decode(contents);
                    translations[lang] = JSON.parse(jsonString);
                } else if (Extra_logs || lang === "Default") {
                    console.warn(`Failed to load language file for ${lang}, success=false`);
                }
            } catch (error) {
                if (Extra_logs || lang === "Default")
                    console.warn(`Failed to load language file, language code: ${lang}:\n`, error);
            }
            resolve();
        });
    });
}

async function init(): Promise<void> {
    await loadLanguageAsync(currentLanguage);
    if (Extra_logs)
        console.log(getString("Initialization complete!") || "Initialization complete!");
    await loadLanguageAsync("Default");
}

function getString(key: string): string {
    if (key && !translations[currentLanguage]?.[key] && Extra_logs) {
        const notFoundMsg = translations[currentLanguage]?.["Not found"] || "Not found";
        console.warn(`${notFoundMsg}:::${key}`);
    }
    return translations[currentLanguage]?.[key] || translations['Default']?.[key] || key;
}

export { getString, init };
