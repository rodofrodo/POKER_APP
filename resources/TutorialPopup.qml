import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: root
    
    // Signal when the user finishes the tutorial
    signal finished()

    anchors.fill: parent
    // High Z-index ensures it sits on top of everything
    z: 999 
    visible: false // Hidden by default
    opacity: 0
    scale: 1.05

    // A dark semi-transparent overlay to darken the blurred background
    Rectangle {
        anchors.fill: parent
        //color: "#0d1017" // 50% transparent black
        color: "#000010"
    }
    
    // Consume mouse clicks so they don't hit the game behind the popup
    MouseArea { anchors.fill: parent; hoverEnabled: true; acceptedButtons: Qt.AllButtons }


    // 2. THE CENTERED DIALOG BOX
    Rectangle {
        id: dialogBox
        width: 1600
        height: 900
        anchors.centerIn: parent
        //color: "#0d1017" // Light gray background for the box
        color: "#000010"
        clip: true // Ensure images don't bleed out of rounded corners

        // Internal State
        property int currentIndex: 0
        // Replace these paths with your actual image resource paths
        readonly property var tutorialImages: [
            "qrc:/PokerApp/resources/images/tutorial/tut1.png",
            "qrc:/PokerApp/resources/images/tutorial/tut2.png",
            "qrc:/PokerApp/resources/images/tutorial/tut3.png",
            "qrc:/PokerApp/resources/images/tutorial/tut4.png",
            "qrc:/PokerApp/resources/images/tutorial/tut5.png",
            "qrc:/PokerApp/resources/images/tutorial/tut6.png",
            "qrc:/PokerApp/resources/images/tutorial/tut7.png",
            "qrc:/PokerApp/resources/images/tutorial/tut8.png",
            "qrc:/PokerApp/resources/images/tutorial/tut9.png",
            "qrc:/PokerApp/resources/images/tutorial/tut10.png",
            "qrc:/PokerApp/resources/images/tutorial/tut11.png",
            "qrc:/PokerApp/resources/images/tutorial/tut12.png",
            "qrc:/PokerApp/resources/images/tutorial/tut13.png",
            "qrc:/PokerApp/resources/images/tutorial/tut14.png",
            "qrc:/PokerApp/resources/images/tutorial/tut15.png",
            "qrc:/PokerApp/resources/images/tutorial/tut16.png",
            "qrc:/PokerApp/resources/images/tutorial/tut17.png"
        ]

        // THE GALLERY IMAGE
        Image {
            id: galleryImage
            anchors.centerIn: parent
            // Leave space for arrows and text
            width: 1064
            height: 715
            fillMode: Image.PreserveAspectFit
            source: dialogBox.tutorialImages[dialogBox.currentIndex]
            
            // Smooth fade animation when changing images
            Behavior on source {
                SequentialAnimation {
                    NumberAnimation { target: galleryImage; property: "opacity"; to: 0; duration: 150 }
                    PropertyAction { target: galleryImage; property: "source" }
                    NumberAnimation { target: galleryImage; property: "opacity"; to: 1; duration: 250 }
                }
            }
        }

        // PAGE INDICATOR TEXT (e.g., "1 / 17")
        Text {
            anchors.bottom: galleryImage.top
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            text: (dialogBox.currentIndex + 1) + " / " + dialogBox.tutorialImages.length
            font.pixelSize: 18
            font.bold: true
            color: "#fff"
        }

        // --- CONTROLS ---

        // Left Arrow button
        Button {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 20
            text: "<"
            font.pixelSize: 30
            // Hide if on the first image
            visible: dialogBox.currentIndex > 0
            onClicked: dialogBox.currentIndex--
        }

        // Right Arrow / Finish button
        Button {
            id: nextBtn
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 20
            font.pixelSize: 30
            
            // Change text and behavior on the last slide
            text: dialogBox.currentIndex === dialogBox.tutorialImages.length - 1 ? "Finish" : ">"
            
            onClicked: {
                if (dialogBox.currentIndex < dialogBox.tutorialImages.length - 1) {
                    // Normal next behavior
                    dialogBox.currentIndex++
                } else {
                    // Finish behavior
                    root.close()
                    root.finished()
                }
            }
        }
    }

    // Helper function to show/reset the popup
    function open() {
        dialogBox.currentIndex = 0
        root.visible = true
        openAnim.start()
    }

    function close() {
        closeAnim.start()
    }

    ParallelAnimation {
        id: openAnim
        NumberAnimation { target: root; property: "opacity"; to: 1.0; duration: 400; easing.type: Easing.OutQuad }
        NumberAnimation { target: root; property: "scale"; to: 1.0; duration: 400; easing.type: Easing.OutBack }
    }

    // Exit Animation: Fade out and scale up a bit (dissolve effect)
    SequentialAnimation {
        id: closeAnim
        ParallelAnimation {
            NumberAnimation { target: root; property: "opacity"; to: 0.0; duration: 400; easing.type: Easing.InQuad }
            NumberAnimation { target: root; property: "scale"; to: 1.05; duration: 400; easing.type: Easing.InQuad }
        }
        // CRITICAL: Once animation is done, turn off visibility so mouse clicks pass through
        ScriptAction { script: root.visible = false }
    }
}
