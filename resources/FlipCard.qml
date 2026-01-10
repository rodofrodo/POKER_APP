import QtQuick

Item {
    id: root
    width: 135 // Default size, can be overridden
    height: 178

    // --- Public Properties ---
    property string frontSource: ""
    property string frontInnerSource: ""
    property string backSource: "qrc:/PokerApp/resources/images/cards/back.png" // Set your default back path here
    
    // This is the switch you toggle to trigger the animation
    // false = showing back, true = showing front
    property bool shown: false

    // The container that actually spins
    Item {
        id: cardContainer
        anchors.fill: parent

        transform: Rotation {
            id: cardRotation
            origin.x: cardContainer.width / 2
            origin.y: cardContainer.height / 2
            axis.y: 1 // Rotate around vertical axis
            axis.x: 0
            axis.z: 0
            angle: 0 // Starts at 0 (showing back)
        }

        // The BACK Image (Initially visible)
        Image {
            id: backImg
            anchors.fill: parent
            source: root.backSource
            fillMode: Image.PreserveAspectFit
            visible: true 
        }

        // The FRONT Image (Initially hidden)
        Image {
            id: frontImg
            anchors.fill: parent
            source: root.frontSource
            fillMode: Image.PreserveAspectFit
            visible: false
            // mirror is super important
            mirror: true 

            Image {
                id: innerFrontImg
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -1
                source: root.frontInnerSource
                width: 86
                height: 134
                fillMode: Image.PreserveAspectFit 
                mirror: true
            }
        }
    }

    // --- Animations ---
    states: State {
        name: "shownState"
        when: root.shown

        PropertyChanges { target: cardRotation; angle: 180 }
    }

    transitions: [
        // Transition from Back -> Front (Flip to reveal)
        Transition {
            from: ""; to: "shownState"
            SequentialAnimation {
                // Rotating first half (0 to 90 degrees) - showing BACK
                NumberAnimation { target: cardRotation; property: "angle"; to: 90; duration: 250; easing.type: Easing.InCubic }
                
                // Swapping visibility at the 90-degree mark
                PropertyAction { target: backImg; property: "visible"; value: false }
                PropertyAction { target: frontImg; property: "visible"; value: true }

                // Rotating second half (90 to 180 degrees) - showing FRONT
                NumberAnimation { target: cardRotation; property: "angle"; to: 180; duration: 250; easing.type: Easing.OutCubic }
            }
        },
        // Transition from Front -> Back
        Transition {
            from: "shownState"; to: ""
            SequentialAnimation {
                // Rotating back to 90 - showing FRONT
                NumberAnimation { target: cardRotation; property: "angle"; to: 90; duration: 250; easing.type: Easing.InCubic }

                // Swapping visibility back
                PropertyAction { target: frontImg; property: "visible"; value: false }
                PropertyAction { target: backImg; property: "visible"; value: true }

                // Rotating rest of the way to 0 - showing BACK
                NumberAnimation { target: cardRotation; property: "angle"; to: 0; duration: 250; easing.type: Easing.OutCubic }
            }
        }
    ]
}