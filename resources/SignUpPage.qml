import QtQuick
import QtQuick.Controls

Page {
    title: "SignUp"

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

    Column {
        anchors.centerIn: parent
        spacing: 40

        Column {
            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Enter your nickname")
                font.pixelSize: 32
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                color: "#ffffff"
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr(
                          "We need to know who to congratulate when you win big!")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
            }
        }

        Column {
            id: inputColumn
            spacing: 20

            Image {
                width: 572
                height: 48
                source: "qrc:/PokerApp/resources/images/gray_rect.png"
                fillMode: Image.PreserveAspectFit

                TextField {
                    id: nickInput
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: 20
                    color: "#ffffff"
                    placeholderText: "Your nickname"
                    background: null
                    placeholderTextColor: "#888888"
                    font.pixelSize: 20
                }
            }
        }

        Column {
            id: connectColumn
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 40

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 223
                height: 47
                source: "qrc:/PokerApp/resources/images/small_white_rect.png"
                fillMode: Image.PreserveAspectFit

                Text {
                    anchors.centerIn: parent
                    text: "Sign up"
                    color: connect_area.containsMouse ? "red" : "black"
                    font.pixelSize: 24
                    font.bold: true
                }

                MouseArea {
                    id: connect_area
                    anchors.fill: parent

                    hoverEnabled: true 
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        var cleanNick = nickInput.text.trim()
                        if (cleanNick.length === 0) {
                            console.log("Nickname cannot be empty.")
                            return
                        }
                        backend.sendMessage_public("name&" + cleanNick + "\n")
                        backend.updateName(cleanNick)
                    }
                }
            }
        }

        Label {
            text: backend.nameProblem
            color: "#ffffff"
            width: parent.width
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
        }
    }
    
    Connections {
        target: backend

        function onLobbyReady() {
            stackView.push("LobbyPage.qml")
        }
    }
}
