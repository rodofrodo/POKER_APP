import QtQuick
import QtQuick.Controls

Window {
    width: 1600
    height: 900
    visible: true
    title: "POKER C++ edition"
    visibility: Window.FullScreen
    //visibility: Window.Maximized

    // StackView manages navigation between pages (push/pop)
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "MainMenu.qml"
    }
}