import QtQuick
import QtQuick.Controls

Page {
    title: "Connect"
    objectName: "ConnectPage"

    background: Rectangle {
        color: "#000000"
    }

    Row {
        id: headerRow
        
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 42
        anchors.leftMargin: 25
        
        spacing: 28

        // --- ITEM 1: Back Arrow ---
        Image {
            source: backMouseArea.containsMouse
                ? "qrc:/PokerApp/resources/images/back_arrow_hover_32.png" 
                : "qrc:/PokerApp/resources/images/back_arrow_32.png" 
            
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit 
            
            MouseArea {
                id: backMouseArea
                anchors.fill: parent
                hoverEnabled: true 
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    stackView.pop()
                }
            }
        }

        // --- ITEM 2: Side Logo ---
        Image {
            source: "qrc:/PokerApp/resources/images/side_logo.svg" 
            
            width: 263
            height: 37
            fillMode: Image.PreserveAspectFit 
            
            anchors.verticalCenter: parent.verticalCenter 
        }
    }

    Column {
        id: topColumn
        anchors.centerIn: parent
        spacing: 40

        // text
        Column {
            id: textColumn
            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Connect to Server")
                font.pixelSize: 32
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                color: "#ffffff"
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr(
                          "To play, you must connect to a dedicated LAN server.")
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
            }
        }

        // input
        Column {
            id: inputColumn
            spacing: 20

            Image {
                width: 572
                height: 48
                source: "qrc:/PokerApp/resources/images/gray_rect.png"
                fillMode: Image.PreserveAspectFit

                TextField {
                    id: ipInput
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: 20
                    color: "#ffffff"
                    placeholderText: "IP address"
                    background: null
                    placeholderTextColor: "#888888"
                    padding: 0
                    font.pixelSize: 20
                }
            }

            Image {
                width: 572
                height: 48
                source: "qrc:/PokerApp/resources/images/gray_rect.png"
                fillMode: Image.PreserveAspectFit

                TextField {
                    id: portInput
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: 20
                    color: "#ffffff"
                    placeholderText: "Port"
                    background: null
                    placeholderTextColor: "#888888"
                    font.pixelSize: 20
                }
            }
        }

        // button
        Column {
            id: connectColumn
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 223
                height: 47
                source: "qrc:/PokerApp/resources/images/small_white_rect.png"
                fillMode: Image.PreserveAspectFit

                Text {
                    anchors.centerIn: parent
                    text: "Connect"
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
                        backend.connectToServer(ipInput.text, portInput.text)
                    }
                }
            }
        }
        
        Label {
            // Bind to the C++ property
            text: backend.statusMessage 
            color: "white"
            width: parent.width
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
        }
    }

    Connections {
        target: backend

        function onConnectedToServer() {
            stackView.push("SignUpPage.qml")
        }
    }
}