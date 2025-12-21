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
                text: "Version 1.0 — 2026"
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
}
