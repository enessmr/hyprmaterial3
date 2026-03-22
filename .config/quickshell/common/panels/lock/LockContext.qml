// 💚 ✨ HyprYoshi3 ✨ 🦕
import qs
import qs.common
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pam

Scope {
    id: root

    enum ActionEnum { Unlock, Poweroff, Reboot }

    signal shouldReFocus()
    signal unlocked(targetAction: var)
    signal failed()

    // Logger for debugging
    Process {
        id: logger
        function log(msg) {
            Quickshell.execDetached(["bash", "-c", 
                `echo "$(date '+%H:%M:%S') - ${msg}" >> /tmp/lockscreen_debug.log`
            ]);
        }
    }

    property string currentText: ""
    property bool unlockInProgress: false
    property bool showFailure: false
    property bool fingerprintsConfigured: false
    property var targetAction: LockContext.ActionEnum.Unlock
    property bool alsoInhibitIdle: false

    function resetTargetAction() {
        root.targetAction = LockContext.ActionEnum.Unlock;
    }

    function clearText() {
        root.currentText = "";
    }

    function resetClearTimer() {
        passwordClearTimer.restart();
    }

    function reset() {
        root.resetTargetAction();
        root.clearText();
        root.unlockInProgress = false;
        stopFingerPam();
    }

    Timer {
        id: passwordClearTimer
        interval: 10000
        onTriggered: {
            root.reset();
        }
    }

    onCurrentTextChanged: {
        if (currentText.length > 0) {
            showFailure = false;
            GlobalStates.screenUnlockFailed = false;
        }
        GlobalStates.screenLockContainsCharacters = currentText.length > 0;
        passwordClearTimer.restart();
        logger.log(`currentText changed, length: ${currentText.length}`);
    }

    function tryUnlock(alsoInhibitIdle = false) {
        logger.log(`tryUnlock called, password length: ${root.currentText.length}`);
        
        // CRITICAL FIX: Safety check for empty password
        if (root.currentText.length === 0) {
            logger.log("BLOCKED: Empty password attempt");
            return;
        }
        
        root.alsoInhibitIdle = alsoInhibitIdle;
        root.unlockInProgress = true;
        
        // CRITICAL FIX: Add timeout failsafe
        unlockTimeoutTimer.restart();
        
        pam.start();
    }

    // CRITICAL FIX: Failsafe timeout to prevent permanent softlock
    Timer {
        id: unlockTimeoutTimer
        interval: 5000 // 5 second timeout
        onTriggered: {
            if (root.unlockInProgress) {
                logger.log("TIMEOUT: PAM took too long, resetting");
                pam.abort();
                root.unlockInProgress = false;
                root.showFailure = true;
                GlobalStates.screenUnlockFailed = true;
            }
        }
    }

    function tryFingerUnlock() {
        if (root.fingerprintsConfigured) {
            fingerPam.start();
        }
    }

    function stopFingerPam() {
        if (fingerPam.active) {
            fingerPam.abort();
        }
    }

    Process {
        id: fingerprintCheckProc
        running: true
        command: ["bash", "-c", "fprintd-list $(whoami) 2>/dev/null || echo 'no fingerprints'"]

        stdout: StdioCollector {
            id: fingerprintOutputCollector
            onStreamFinished: {
                root.fingerprintsConfigured = fingerprintOutputCollector.text.includes("Fingerprints for user");
                logger.log(`Fingerprints configured: ${root.fingerprintsConfigured}`);
            }
        }

        onExited: (exitCode, exitStatus) => {
            if (exitCode !== 0) {
                root.fingerprintsConfigured = false;
                logger.log("fprintd-list failed, no fingerprints");
            }
        }
    }

    PamContext {
        id: pam
        configDirectory: "pam"
        config: "lock.conf"
        
        Component.onCompleted: {
            logger.log("PAM Context initialized with config: pam/lock.conf");
        }

        onPamMessage: {
            logger.log(`PAM MESSAGE: "${this.message}" | responseRequired: ${this.responseRequired}`);
            if (this.responseRequired) {
                logger.log(`Responding with password (length: ${root.currentText.length})`);
                this.respond(root.currentText);
            }
        }

        onCompleted: result => {
            // CRITICAL FIX: Stop timeout timer
            unlockTimeoutTimer.stop();
            
            logger.log(`PAM COMPLETED: ${result} (Success=${PamResult.Success}, Error=${PamResult.Error})`);
            
            if (result == PamResult.Success) {
                logger.log("Authentication SUCCESS!");
                
                // CRITICAL FIX: Wrap in try-catch to prevent signal handler crashes
                try {
                    root.unlocked(root.targetAction);
                    stopFingerPam();
                } catch (e) {
                    logger.log(`ERROR in unlocked signal handler: ${e}`);
                    // Fallback: force unlock anyway
                    GlobalStates.screenLocked = false;
                    root.reset();
                }
            } else {
                logger.log("Authentication FAILED!");
                root.clearText();
                root.unlockInProgress = false;
                GlobalStates.screenUnlockFailed = true;
                root.showFailure = true;
            }
        }
        
        // CRITICAL FIX: Handle PAM errors/aborts
        onError: error => {
            unlockTimeoutTimer.stop();
            logger.log(`PAM ERROR: ${error}`);
            root.unlockInProgress = false;
            root.showFailure = true;
            GlobalStates.screenUnlockFailed = true;
        }
    }

    PamContext {
        id: fingerPam
        configDirectory: "pam"
        config: "fprintd.conf"

        onCompleted: result => {
            if (result == PamResult.Success) {
                // CRITICAL FIX: Same try-catch protection
                try {
                    root.unlocked(root.targetAction);
                    stopFingerPam();
                } catch (e) {
                    logger.log(`ERROR in fingerprint unlocked handler: ${e}`);
                    GlobalStates.screenLocked = false;
                    root.reset();
                }
            } else if (result == PamResult.Error) {
                tryFingerUnlock()
            }
        }
    }
}