// PaletteButton.qml - THE BUTTON THAT STARTS IT ALL
import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    text: "Select Wallpaper"

    onClicked: {
        // Create the selector dynamically - but BETTER
        var comp = Qt.createComponent("WallpaperSelector.qml")
        if(comp.status === Component.Ready){
            var selector = comp.createObject(parent.parent) // parent.parent for better positioning
            selector.anchors.fill = parent.parent
            selector.wallpaperChanged.connect(function(path){
                console.log("Palette got wallpaper:", path)
                // here you can update palette or call Hyprland script
                selector.destroy() // clean up after selection
            })
        } else {
            console.log("Component creation failed:", comp.errorString())
        }
    }
}