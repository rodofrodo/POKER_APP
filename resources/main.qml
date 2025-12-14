import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 1600
    height: 900
    title: "POKER C++ edition"
    visible: true
    //visibility: Window.FullScreen
    //visibility: Window.Maximized

    // --- F11 FULLSCREEN TOGGLE ---
    Shortcut {
        sequence: "F11"
        onActivated: {
            if (root.visibility === Window.FullScreen)
                root.visibility = Window.Windowed
            else
                root.visibility = Window.FullScreen
        }
    }

    // StackView manages navigation between pages (push/pop)
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "MainMenu.qml"
    }
}