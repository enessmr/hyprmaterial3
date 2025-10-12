import qs.common
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
pragma Singleton
pragma ComponentBehavior: Bound

/**
 * A nice wrapper for default Pipewire audio sink and source.
 */
Singleton {
    id: root

    property bool ready: Pipewire.defaultAudioSink?.ready ?? false
    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource
    readonly property real hardMaxValue: 2.00 // People keep joking about setting volume to 5172% so...
    
    // SATANIC MAX VOLUME DETECTION 🔥
    property real maxVolume: {
        if (!sink?.audio) return hardMaxValue
        // USE THE ACTUAL PIPEWIRE MAX VOLUME IF AVAILABLE, OTHERWUSE USE HARD MAX
        return sink.audio.hasOwnProperty("maxVolume") ? sink.audio.maxVolume : hardMaxValue
    }
    
    // TRUE PERCENTAGE CALCULATION BASED ON REAL MAX
    function getTruePercentage(volume) {
        return (volume / maxVolume) * 100
    }

    signal sinkProtectionTriggered(string reason);

    PwObjectTracker {
        objects: [sink, source]
    }

    Connections { // Protection against sudden volume changes
        target: sink?.audio ?? null
        property bool lastReady: false
        property real lastVolume: 0
        function onVolumeChanged() {
            if (!Config.options.audio.protection.enable) return;
            if (!lastReady) {
                lastVolume = sink.audio.volume;
                lastReady = true;
                return;
            }
            const newVolume = sink.audio.volume;
            const maxAllowedIncrease = Config.options.audio.protection.maxAllowedIncrease / 100; 
            const maxAllowed = Config.options.audio.protection.maxAllowed / 100;

            if (newVolume - lastVolume > maxAllowedIncrease) {
                sink.audio.volume = lastVolume;
                root.sinkProtectionTriggered("Illegal increment");
            } else if (newVolume > maxAllowed  || newVolume > root.hardMaxValue) {
                root.sinkProtectionTriggered("Exceeded max allowed");
                sink.audio.volume = Math.min(lastVolume, maxAllowed);
            }
            if (sink.ready && (isNaN(sink.audio.volume) || sink.audio.volume === undefined || sink.audio.volume === null)) {
                sink.audio.volume = 0;
            }
            console.log("Ok fix:", sink.audio.volume);
            lastVolume = sink.audio.volume;
        }
    }
    
    // SATANIC LOGGING TO SEE ACTUAL MAX VOLUMES
    onSinkChanged: {
        if (sink?.audio) {
            console.log("🔥 SATANIC AUDIO DETECTED - Max volume:", root.maxVolume, 
                       "Pipewire max:", sink.audio.maxVolume, 
                       "Hard max:", root.hardMaxValue)
        }
    }
}