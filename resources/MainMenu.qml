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
        
        Image {
            // UPDATED SOURCE PATH
            source: "qrc:/PokerApp/resources/images/main_menu_logo.png" 
    
            width: 356
            height: 177
            fillMode: Image.PreserveAspectFit 
            anchors.horizontalCenter: parent.horizontalCenter
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