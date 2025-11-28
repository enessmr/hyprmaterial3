// 💚 ✨ HyprYoshi3 ✨ 🦕
pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    // internal helper for spawning processes
    function _run(args, callback, stdinData) {
        const proc = procComponent.createObject(root, {
            command: args,
            _callback: callback || (() => {}),
            _stdinData: stdinData || ""
        });
        proc.running = true;
    }

    Component {
        id: procComponent
        Process {
            property var _callback
            property string _stdinData
            property string _stdout: ""
            property string _stderr: ""

            onStarted: {
                if (_stdinData) {
                    write(_stdinData);
                    closeStdin();
                }
            }
            stdout: SplitParser {
                onRead: data => _stdout += data + "\n"
            }
            stderr: SplitParser {
                onRead: data => _stderr += data + "\n"
            }
            onExited: (code) => {
                _callback({
                    exitCode: code,
                    stdout: _stdout.trim(),
                    stderr: _stderr.trim()
                });
                destroy();
            }
        }
    }

    /**
     * Trims the File protocol off the input string
     */
    function trimFileProtocol(str) {
        if (typeof str !== "string") return "";
        return str.startsWith("file://") ? str.slice(7) : str;
    }

    /**
     * Extracts the file name from a file path
     */
    function fileNameForPath(str) {
        if (typeof str !== "string") return "";
        const trimmed = trimFileProtocol(str);
        return trimmed.split(/[\\/]/).pop() || "";
    }

    /**
     * Removes the file extension from a file path or name
     */
    function trimFileExt(str) {
        if (typeof str !== "string") return "";
        const trimmed = trimFileProtocol(str);
        const lastDot = trimmed.lastIndexOf(".");
        if (lastDot > -1 && lastDot > trimmed.lastIndexOf("/")) {
            return trimmed.slice(0, lastDot);
        }
        return trimmed;
    }

    /**
     * Checks if a file or directory exists
     * @param {string} path
     * @param {function} callback - (exists: bool)
     */
    function exists(path, callback) {
        if (typeof path !== "string" || path === "") {
            if (callback) callback(false);
            return;
        }
        _run(["test", "-e", trimFileProtocol(path)], (res) => {
            if (callback) callback(res.exitCode === 0);
        });
    }

    /**
     * Checks if path is a file
     */
    function isFile(path, callback) {
        if (typeof path !== "string" || path === "") {
            if (callback) callback(false);
            return;
        }
        _run(["test", "-f", trimFileProtocol(path)], (res) => {
            if (callback) callback(res.exitCode === 0);
        });
    }

    /**
     * Checks if path is a directory
     */
    function isDir(path, callback) {
        if (typeof path !== "string" || path === "") {
            if (callback) callback(false);
            return;
        }
        _run(["test", "-d", trimFileProtocol(path)], (res) => {
            if (callback) callback(res.exitCode === 0);
        });
    }

    /**
     * Reads content from a file
     * @param {function} callback - (content: string)
     */
    function read(path, callback) {
        if (typeof path !== "string" || path === "") {
            if (callback) callback("");
            return;
        }
        _run(["cat", trimFileProtocol(path)], (res) => {
            if (callback) callback(res.exitCode === 0 ? res.stdout : "");
        });
    }

    /**
     * Writes content to a file (creates parent dirs)
     * @param {function} callback - (success: bool)
     */
    function write(path, content, callback) {
        if (typeof path !== "string" || path === "") {
            if (callback) callback(false);
            return;
        }
        const trimmed = trimFileProtocol(path);
        const dir = trimmed.substring(0, trimmed.lastIndexOf("/"));
        
        // mkdir first, then write
        _run(["mkdir", "-p", dir], () => {
            const escaped = String(content).replace(/'/g, "'\\''");
            _run(["bash", "-c", `printf '%s' '${escaped}' > "${trimmed}"`], (res) => {
                if (callback) callback(res.exitCode === 0);
            });
        });
    }

    /**
     * Appends content to a file
     */
    function append(path, content, callback) {
        if (typeof path !== "string" || path === "") {
            if (callback) callback(false);
            return;
        }
        const trimmed = trimFileProtocol(path);
        const escaped = String(content).replace(/'/g, "'\\''");
        _run(["bash", "-c", `printf '%s' '${escaped}' >> "${trimmed}"`], (res) => {
            if (callback) callback(res.exitCode === 0);
        });
    }

    /**
     * Deletes a file or directory
     * @param {bool} recursive - true for directories
     */
    function remove(path, recursive, callback) {
        if (typeof path !== "string" || path === "") {
            if (callback) callback(false);
            return;
        }
        const args = recursive ? ["rm", "-rf"] : ["rm", "-f"];
        args.push(trimFileProtocol(path));
        _run(args, (res) => {
            if (callback) callback(res.exitCode === 0);
        });
    }

    /**
     * Creates a directory (and parents)
     */
    function mkdir(path, callback) {
        if (typeof path !== "string" || path === "") {
            if (callback) callback(false);
            return;
        }
        _run(["mkdir", "-p", trimFileProtocol(path)], (res) => {
            if (callback) callback(res.exitCode === 0);
        });
    }
}