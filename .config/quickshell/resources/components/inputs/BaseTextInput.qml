// 💚 ✨ HyprYoshi3 ✨ 🦕

import QtQuick 2.15
import "../../colors.js" as Palette
import qs.common

// Common TextInput defaults for all input components
TextInput {
  id: base
  // Selection styling and behavior
  selectionColor: Qt.darker(Appearance.m3colors.m3primary, 1.8)
  selectByMouse: true
  // Drag to select characters by default; double-click still selects word
  mouseSelectionMode: TextInput.SelectCharacters
}


