import QtQuick
import QtQuick.Controls

Page {
    title: "Main Menu"

    background: Rectangle {
        color: "#000000"
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter 
        anchors.centerIn: parent
        spacing: 200
        
        Column {
            anchors.horizontalCenter: parent.horizontalCenter 
            spacing: 24

            Image {
                // UPDATED SOURCE PATH
                source: "qrc:/PokerApp/resources/images/main_menu_logo.svg" 
    
                width: 356
                height: 177
                fillMode: Image.PreserveAspectFit 
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Version 1.0.1 HOTFIX — January 2026"
                color: "white"
                font.pixelSize: 14
                opacity: 0.5
                font.bold: credits_ma.containsMouse
                anchors.horizontalCenter: parent.horizontalCenter
        
                MouseArea {
                    id: credits_ma
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
            
                    // Nice hover effect
                    onEntered: parent.opacity = 1.0
                    onExited: parent.opacity = 0.5

                    onClicked: {
                        stackView.push("Credits.qml")
                    }
                }
            }
        }

        Column {
            anchors.horizontalCenter: parent.horizontalCenter 
            spacing: 24

            Text {
                id: connectionStatusText
                anchors.horizontalCenter: parent.horizontalCenter
                color: "red"
                font.pixelSize: 16
            }

            Image {
                // UPDATED SOURCE PATH
                source: "qrc:/PokerApp/resources/images/white_rect.png" 
    
                width: 302
                height: 47
                fillMode: Image.PreserveAspectFit 
                anchors.horizontalCenter: parent.horizontalCenter    

                Text {
                    anchors.centerIn: parent
                    text: "Play"
                    color: play_area.containsMouse ? "red" : "black"
                    font.pixelSize: 24
                    font.bold: true
                }

                MouseArea {
                    id: play_area
                    anchors.fill: parent

                    hoverEnabled: true 
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        stackView.push("ConnectPage.qml")
                    }
                }
            }

            Image {
                // UPDATED SOURCE PATH
                source: "qrc:/PokerApp/resources/images/white_rect.png" 
    
                width: 302
                height: 47
                fillMode: Image.PreserveAspectFit 
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    anchors.centerIn: parent
                    text: "Options"
                    color: options_area.containsMouse ? "red" : "black"
                    font.pixelSize: 24
                    font.bold: true
                }

                MouseArea {
                    id: options_area
                    anchors.fill: parent

                    hoverEnabled: true 
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        stackView.push("OptionsPage.qml")
                    }
                }
            }

            Image {
                // UPDATED SOURCE PATH
                source: "qrc:/PokerApp/resources/images/white_rect.png" 
    
                width: 302
                height: 47
                fillMode: Image.PreserveAspectFit 
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    anchors.centerIn: parent
                    text: "Exit"
                    color: exit_area.containsMouse ? "red" : "black"
                    font.pixelSize: 24
                    font.bold: true
                }

                MouseArea {
                    id: exit_area
                    anchors.fill: parent

                    hoverEnabled: true 
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        Qt.quit()
                    }
                }
            }
        }
    }

    // LISTENER FOR THE SIGNAL
    Connections {
        target: backend

        function onConnectionError(message) {
            if (!stackView.currentItem) return;

            // ONLY pop if we are NOT already on the ConnectPage
            if (stackView.currentItem.objectName !== "ConnectPage") {
                console.log("Error occurred. Returning to Connect Page.")
                stackView.pop(null) // Clears stack and goes back to root (ConnectPage)
            } else {
                console.log("Error occurred, but already on Connect Page.")
            }
            connectionStatusText.text = "Error: " + message
        }
    }
}
