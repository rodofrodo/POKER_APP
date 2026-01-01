import QtQuick
import QtQuick.Controls

Page {
    title: "LobbyPage"

    property int itemWidth: 250
    property int itemSpacing: 50
    property int maxColumns: 3  // "3 on top"

    background: Rectangle {
        color: "#000000"
    }

    // 1. Use a Row to put items next to each other
    Row {
        id: headerRow
        
        // 2. Position the entire Row on the Left + Top Margin
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 42   // Adjust this for more/less top space
        anchors.leftMargin: 25  // Adjust this for more/less left space
        
        // 3. Add spacing between the arrow and the logo
        spacing: 28

        // --- ITEM 1: Back Arrow ---
        Image {
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit 
        }

        // --- ITEM 2: Side Logo ---
        Image {
            source: "qrc:/PokerApp/resources/images/side_logo.svg" 
            
            width: 263
            height: 37
            fillMode: Image.PreserveAspectFit 
            
            // Optional: Align the logo vertically with the arrow
            anchors.verticalCenter: parent.verticalCenter 
        }
    }

    Row {
        id: accountRow
        
        // 2. Position the entire Row on the Left + Top Margin
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 42   // Adjust this for more/less top space
        anchors.rightMargin: 85  // Adjust this for more/less left space
        
        // 3. Add spacing between the arrow and the logo
        spacing: 15

        Column {

            Text {
                anchors.right: parent.right
                text: qsTr(backend.clientName)
                font.pixelSize: 20
                horizontalAlignment: Text.AlignRight
                color: "#ffffff"
                font.bold: true
            }

            Text {
                anchors.right: parent.right
                text: "$1000"
                font.pixelSize: 16
                horizontalAlignment: Text.AlignRight
                color: "#ffffff"
            }
        }

        Image {
            source: "qrc:/PokerApp/resources/images/person_40.png" 
            
            width: 42
            height: 42
            fillMode: Image.PreserveAspectFit 
            
            // Optional: Align the logo vertically with the arrow
            anchors.verticalCenter: parent.verticalCenter 
        }
    }

    Column {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 175
        spacing: 40

        Row {
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Connected to lobby — ")
                font.pixelSize: 24
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr(backend.ipAddress + ":" + backend.port)
                font.pixelSize: 24
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
                font.bold: true
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            Image {
                source: "qrc:/PokerApp/resources/images/black_person_32.png" 
                width: 24
                height: 24
                fillMode: Image.PreserveAspectFit 
                anchors.verticalCenter: parent.verticalCenter 
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr(backend.lobbySize + "/10")
                font.pixelSize: 24
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
            }
        }
    }

    Image {
        source: "qrc:/PokerApp/resources/images/small_gray_rect.png" 
        
        width: 275
        height: 35
        fillMode: Image.PreserveAspectFit 
        
        // Optional: Align the logo vertically with the arrow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 55

        Text {
            anchors.centerIn: parent
            text: "Waiting for the host to start the game"
            font.italic: true
            color: "#ffffff"
            font.pixelSize: 14
        }
    }

    Flow {
        id: playerGrid
        anchors.centerIn: parent
        spacing: itemSpacing

        width: {
            var count = backend.playerList.length
            var columns = 0

            if (count === 4) {
                columns = 2 // SPECIAL RULE: 4 players -> 2 columns (2x2 grid)
            } else {
                // STANDARD RULE: Grow up to 3, then wrap
                columns = Math.min(count, 3) 
            }

            // Calculate total width based on the chosen number of columns
            return (columns * itemWidth) + ((columns - 1) * itemSpacing)
        }
        
        Repeater {
            // This connects to the C++ list we will create below
            model: backend.playerList 

            Rectangle {
                // A. Give the item a size so Flow knows how to arrange it
                width: 250 
                height: 65
            
                // B. Visual styling (looks like a player tag)
                color: "black"

                // C. NOW you can use anchors to center the text INSIDE this rectangle
                Text {
                    anchors.centerIn: parent 
                    text: modelData 
                    color: "white"
                    font.bold: true
                    font.pixelSize: 24
                }
            }
        }
    }

    Connections {
        target: backend

        function onGameReady() {
            stackView.push("GamePage.qml")
        }
    }
}
