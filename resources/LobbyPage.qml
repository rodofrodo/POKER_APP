import QtQuick
import QtQuick.Controls

Page {
    title: "LobbyPage"

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
            source: "qrc:/PokerApp/resources/images/side_logo.png" 
            
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
        anchors.rightMargin: 25  // Adjust this for more/less left space
        
        // 3. Add spacing between the arrow and the logo
        spacing: 28

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr(backend.clientName)
            font.pixelSize: 32
            horizontalAlignment: Text.AlignHCenter
            color: "#ffffff"
        }

        Image {
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit 
        }
    }

    Row {
        anchors.centerIn: parent

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Connected to lobby — ")
            font.pixelSize: 32
            horizontalAlignment: Text.AlignHCenter
            color: "#ffffff"
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr(backend.ipAddress + ":" + backend.port)
            font.pixelSize: 32
            horizontalAlignment: Text.AlignHCenter
            color: "#ffffff"
            font.bold: true
        }
    }
}
