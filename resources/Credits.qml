import QtQuick
import QtQuick.Controls

Page {
    title: "Credits"

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
            source: backMouseArea.containsMouse
                ? "qrc:/PokerApp/resources/images/back_arrow_hover_32.png" 
                : "qrc:/PokerApp/resources/images/back_arrow_32.png" 
            
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit 
            
            // REMOVED: anchors.horizontalCenter (Row handles position now)

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
            
            // Optional: Align the logo vertically with the arrow
            anchors.verticalCenter: parent.verticalCenter 
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 52

        Column {
            spacing: 16
        
            Text {
                text: "Hi, everyone!"
                color: "#FFFFFF"
                font.pixelSize: 42
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                text: "Many of you may be wondering why I decided to take on such a large project. The answer is simple: if I truly enjoy working on something, why would I limit myself to building only a small application? I wouldn't necessarily describe this game as massive, but I invested a significant amount of time in it because it was my first experience developing a desktop application in C++."
                width: 850 
                wrapMode: Text.WordWrap 
                horizontalAlignment: Text.AlignJustify
                font.pixelSize: 20
                color: "white"
            }

            Text {
                text: "I chose to use the Qt framework because, in my opinion, it most closely resembles C# WPF. I have always been curious about how to build professional-grade applications in C++, especially given its ability to support cross-platform development."
                width: 850
                wrapMode: Text.WordWrap 
                horizontalAlignment: Text.AlignJustify
                font.pixelSize: 20
                color: "white"
            }

            Text {
                text: "Expanding my C++ knowledge was an enjoyable challenge. While it isn't my favorite language, I don't dislike it either. Perhaps I simply need more time and experience to fully appreciate it."
                width: 850
                wrapMode: Text.WordWrap 
                horizontalAlignment: Text.AlignJustify
                font.pixelSize: 20
                color: "white"
            }

            Text {
                text: "My name is Bartosz Strączek. If you'd like to learn more,\nplease check out the links below:"
                wrapMode: Text.WordWrap 
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
                color: "white"
            }
        }

        Column {
            spacing: 26

            Image {
                source: "qrc:/PokerApp/resources/images/credits/github.png"
                width: 145
                height: 53
                fillMode: Image.PreserveAspectFit 

                scale: maGitHub.containsMouse ? 1.025 : 1.0
                Behavior on scale { NumberAnimation { duration: 50 } }

                MouseArea {
                    id: maGitHub
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Qt.openUrlExternally("https://github.com/rodofrodo")
                }
            }

            Image {
                source: "qrc:/PokerApp/resources/images/credits/buymeacoffee.png"
                width: 211
                height: 60
                fillMode: Image.PreserveAspectFit 

                scale: maBMAC.containsMouse ? 1.025 : 1.0
                Behavior on scale { NumberAnimation { duration: 50 } }

                MouseArea {
                    id: maBMAC
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Qt.openUrlExternally("https://buymeacoffee.com/nkbdev")
                }
            }

            Image {
                source: "qrc:/PokerApp/resources/images/credits/ko-fi.png"
                width: 284
                height: 44
                fillMode: Image.PreserveAspectFit 

                scale: maKoFi.containsMouse ? 1.025 : 1.0
                Behavior on scale { NumberAnimation { duration: 50 } }

                MouseArea {
                    id: maKoFi
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Qt.openUrlExternally("https://ko-fi.com/rodofrodo")
                }
            }
        }
    }
}