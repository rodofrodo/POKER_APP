import QtQuick

Item {
    id: root
    // Default sizes, can be overridden when used
    width: 280
    height: 73

    // --- Public Properties ---
    property string source: ""
    property int fillMode: Image.PreserveAspectFit
    property int duration: 300 // How fast the fade is (ms)

    // --- Internal Logic ---
    // We use an internal state item to track which image is currently active.
    // state "A": imgA is showing, imgB is hidden waiting for next source.
    // state "B": imgB is showing, imgA is hidden waiting for next source.
    state: "A"

    // When the public 'source' property changes, load it into the
    // *hidden* image, then trigger the state change to fade it in.
    onSourceChanged: {
        if (state == "A") {
            imgB.source = root.source
            root.state = "B"
        } else {
            imgA.source = root.source
            root.state = "A"
        }
    }

    // --- The two stacked images ---
    Image {
        id: imgA
        anchors.fill: parent
        fillMode: root.fillMode
        source: root.source
    }

    Image {
        id: imgB
        anchors.fill: parent
        fillMode: root.fillMode
        opacity: 0 // Start hidden
    }

    // --- States and Transitions ---
    states: [
        State {
            name: "A"
            PropertyChanges { target: imgA; opacity: 1.0 }
            PropertyChanges { target: imgB; opacity: 0.0 }
        },
        State {
            name: "B"
            PropertyChanges { target: imgB; opacity: 1.0 }
            PropertyChanges { target: imgA; opacity: 0.0 }
        }
    ]

    transitions: Transition {
        // Runing these animations in parallel for a smooth crossfade
        ParallelAnimation {
            NumberAnimation {
                // Animating whoever is becoming visible
                targets: [imgA, imgB]
                properties: "opacity"
                duration: root.duration
                easing.type: Easing.InOutQuad
            }
        }
    }
}