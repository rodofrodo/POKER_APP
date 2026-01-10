import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 1600
    height: 900
    title: "POKER C++ edition"
    visible: true
    visibility: Window.FullScreen

    Component.onCompleted: {
        // Check if the "settingsManager" (exposed from C++) says we've seen it
        if (!AppSettings.hasSeenTutorial) {
            tutorialOverlay.open()
        }
    }

    // StackView manages navigation between pages (push/pop)
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "MainMenu.qml"
    }

    // --- TUTORIAL OVERLAY (Sits on top) ---
    TutorialPopup {
        id: tutorialOverlay

        onFinished: {
            AppSettings.setHasSeenTutorial(true)
        }
    }
}