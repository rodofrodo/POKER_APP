import QtQuick
import QtQuick.Controls

Page {
    title: "GamePage"

    Shortcut {
        sequence: "1"
        onActivated: {
            backend._match_bet();
        }
    }

    Shortcut {
        sequence: "2"
        onActivated: {
            console.log("bet/raised")
        }
    }

    Shortcut {
        sequence: "3"
        onActivated: {
            backend._fold();
        }
    }

    background: Image {
        source: "qrc:/PokerApp/resources/images/board_classic.svg"
    }

    FontLoader {
        id: georgiaFont
        source: "qrc:/PokerApp/fonts/georgia.ttf" 
    }

    FontLoader {
        id: georgiaBoldFont
        source: "qrc:/PokerApp/fonts/georgiab.ttf" 
    }

    FontLoader {
        id: georgiaItalicFont
        source: "qrc:/PokerApp/fonts/georgiai.ttf" 
    }

    FontLoader {
        id: georgiaBoldItalicFont
        source: "qrc:/PokerApp/fonts/georgiaz.ttf" 
    }

    Column {
        id: playerColumn
        spacing: 5
        anchors.top: parent.top
        anchors.left: parent.left

        Repeater {
            model: backend.lobbySize
            
            Row {
                spacing: 5

                Text {
                    font.pixelSize: 18
                    text: (backend.uiTrigger, backend.getPlayerName(index))
                }

                Text {
                    font.pixelSize: 18
                    text: (backend.uiTrigger, backend.getBettingState(index))
                }

                Text {
                    font.pixelSize: 18
                    text: (backend.uiTrigger, backend.getBalance(index))
                }

                Text {
                    font.pixelSize: 18
                    text: (backend.uiTrigger, backend.getLoans(index))
                }

                Text {
                    font.pixelSize: 18
                    text: (backend.uiTrigger, backend.getCurrentBet(index))
                }
   
                Text {
                    font.pixelSize: 18
                    text: (backend.uiTrigger, backend.getActingPlayer(index))
                }
            }
        }
    }

    Text {
        font.pixelSize: 18
        text: backend.winners
        anchors.top: playerColumn.bottom
        anchors.left: parent.left
    }

    Column {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.bottomMargin: 15
        anchors.leftMargin: 15
        spacing: 3

        Text {
            text: qsTr("Currently connected to:")
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            color: "#ffffff"
        }

        Text {
            text: qsTr(backend.ipAddress + ":" + backend.port)
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            color: "#ffffff"
            font.bold: true
        }
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 200

        Row {
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: qsTr("Pot: ")
                font.pixelSize: 48
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
            }

            Text {
                id: potText
                text: "$0"
                font.pixelSize: 48
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
                font.bold: true
            }
        }

        Row {
            id: callAmountRow
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false

            Text {
                text: "Call amount: "
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
            }

            Text {
                id: callAmountText
                text: "$0"
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                color: "#ffffff"
                font.bold: true
            }
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 375
        spacing: 25
        id: communityCards

        Image {
            id: flop1Img
            source: "qrc:/PokerApp/resources/images/cards/back.png" 
            width: 135
            height: 178
            fillMode: Image.PreserveAspectFit 
        }

        Image {
            id: flop2Img
            source: "qrc:/PokerApp/resources/images/cards/back.png" 
            width: 135
            height: 178
            fillMode: Image.PreserveAspectFit 
        }

        Image {
            id: flop3Img
            source: "qrc:/PokerApp/resources/images/cards/back.png" 
            width: 135
            height: 178
            fillMode: Image.PreserveAspectFit 
        }

        Image {
            id: turnImg
            source: "qrc:/PokerApp/resources/images/cards/back.png" 
            width: 135
            height: 178
            fillMode: Image.PreserveAspectFit 
        }

        Image {
            id: riverImg
            source: "qrc:/PokerApp/resources/images/cards/back.png" 
            width: 135
            height: 178
            fillMode: Image.PreserveAspectFit 
        }
    }

    Text {
        id: bettingRoundText

        anchors.horizontalCenter: communityCards.horizontalCenter
        anchors.top: communityCards.bottom
        anchors.topMargin: 100

        text: "DEALING CARDS"
        font.family: georgiaBoldItalicFont.name
        font.pixelSize: 32
        font.letterSpacing: 10
        font.bold: true
        font.italic: true
        horizontalAlignment: Text.AlignHCenter
        color: "#00E3FF"
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        spacing: 25

        Image {
            id: leftCard
            width: 135
            height: 178
            fillMode: Image.PreserveAspectFit 

            property string fallbackSource: "qrc:/PokerApp/resources/images/cards/back.png"

            // 2. Detect when an error occurs
            onStatusChanged: {
                if (status === Image.Error) {
                    console.log("Card not found, loading fallback.")
                    source = fallbackSource
                }
            }
        }

        Image {
            id: rightCard
            width: 135
            height: 178
            fillMode: Image.PreserveAspectFit 

            property string fallbackSource: "qrc:/PokerApp/resources/images/cards/back.png"

            // 2. Detect when an error occurs
            onStatusChanged: {
                if (status === Image.Error) {
                    console.log("Card not found, loading fallback.")
                    source = fallbackSource
                }
            }
        }
    }

    Column {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 60
        anchors.rightMargin: 40 // This will work now!
        spacing: 10
        id: optionsColumn

        // --- BUTTON 1 ---
        Item {
            // Container determines size based on the Row content
            width: row1.width 
            height: 32

            Row {
                id: row1
                spacing: 10
            
                Image {
                    source: "qrc:/PokerApp/resources/images/bind.svg"
                    width: 32; height: 32
                    Text { 
                        text: "1"; font.bold: true; anchors.centerIn: parent 
                        font.pixelSize: 20
                    }
                }
                Text {
                    text: backend.betOpts[0]
                    color: "white"; font.pixelSize: 20
                    anchors.verticalCenter: parent.verticalCenter
                    font.underline: btn1ma.containsMouse
                }
            }

            // MouseArea sits ON TOP of the Row, filling the Container
            MouseArea {
                id: btn1ma
                hoverEnabled: true
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: backend._match_bet()
            }
        }

        // --- BUTTON 2 ---
        Item {
            width: row2.width
            height: 32

            Row {
                id: row2
                spacing: 10

                Image {
                    source: "qrc:/PokerApp/resources/images/bind.svg"
                    width: 32; height: 32
                    Text { 
                        text: "2"; font.bold: true; anchors.centerIn: parent 
                        font.pixelSize: 20
                    }
                }
                Text {
                    text: backend.betOpts[1]
                    color: "white"; font.pixelSize: 20
                    anchors.verticalCenter: parent.verticalCenter
                    font.underline: btn2ma.containsMouse
                }
            }

            MouseArea {
                id: btn2ma
                hoverEnabled: true
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    backend._change_bet_open();
                    optionsColumn.visible = false
                    raiseRow.visible = true
                }
            }
        }

        // --- BUTTON 3 ---
        Item {
            width: row3.width
            height: 32

            Row {
                id: row3
                spacing: 10

                Image {
                    source: "qrc:/PokerApp/resources/images/bind.svg"
                    width: 32; height: 32
                    Text { 
                        text: "3"; font.bold: true; anchors.centerIn: parent 
                        font.pixelSize: 20
                    }
                }
                Text {
                    text: backend.betOpts[2]
                    color: "white"; font.pixelSize: 20
                    anchors.verticalCenter: parent.verticalCenter
                    font.underline: btn3ma.containsMouse
                }
            }

            MouseArea {
                id: btn3ma
                hoverEnabled: true
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: backend._fold()
            }
        }
    }

    Row {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 60
        anchors.rightMargin: 50 // This will work now!
        spacing: 50
        id: raiseRow
        visible: false

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5

            Image {
                source: "qrc:/PokerApp/resources/images/white_polygon_up_16.svg"
                width: 16; height: 16
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: backend.increaseBet()
                }
            }

            Text {
                text: backend.raiseVal; font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter 
                font.pixelSize: 32
                color: "#ffffff"
            }

            Image {
                source: "qrc:/PokerApp/resources/images/white_polygon_down_16.svg"
                width: 16; height: 16
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: backend.decreaseBet()
                }
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20

            Image {
                source: "qrc:/PokerApp/resources/images/white_small_button_rect.svg"
                width: 93; height: 25
                Text { 
                    text: "CONFIRM"; font.bold: true; anchors.centerIn: parent 
                    font.pixelSize: 16
                    color: raiseConfirm_ma.containsMouse ? "#909090" : "#000000"
                }

                MouseArea {
                    id: raiseConfirm_ma
                    hoverEnabled: true
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        optionsColumn.visible = false
                        raiseRow.visible = false
                        backend._change_bet_confirm();
                    }
                }
            }

            Image {
                source: "qrc:/PokerApp/resources/images/white_small_button_rect.svg"
                width: 93; height: 25
                Text { 
                    text: "CANCEL"; font.bold: true; anchors.centerIn: parent 
                    font.pixelSize: 16
                    color: raiseCancel_ma.containsMouse ? "#909090" : "#000000"
                }
        
                MouseArea {
                    id: raiseCancel_ma
                    hoverEnabled: true
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        optionsColumn.visible = true
                        raiseRow.visible = false
                    }
                }
            }
        }
    }

    Connections {
        target: backend

        function onUpdatedGamePage() {
            if (backend.leftCard && backend.leftCard !== "")
                leftCard.source = "qrc:/PokerApp/resources/images/cards/" + backend.leftCard + ".svg"
            else
                leftCard.source = "qrc:/PokerApp/resources/images/cards/back.png"

            if (backend.rightCard && backend.rightCard !== "")
                rightCard.source = "qrc:/PokerApp/resources/images/cards/" + backend.rightCard + ".svg"
            else
                rightCard.source = "qrc:/PokerApp/resources/images/cards/back.png"

            bettingRoundText.text = backend.bettingRound
            potText.text = backend.potVal

            if (backend.bettingRound == "DEALING CARDS") {
                leftCard.source = "qrc:/PokerApp/resources/images/cards/back.png"
                rightCard.source = "qrc:/PokerApp/resources/images/cards/back.png"
            } else if (backend.bettingRound === "FLOP") {
                flop1Img.source = "qrc:/PokerApp/resources/images/cards/" + backend.comCards[0] + ".svg"
                flop2Img.source = "qrc:/PokerApp/resources/images/cards/" + backend.comCards[1] + ".svg"
                flop3Img.source = "qrc:/PokerApp/resources/images/cards/" + backend.comCards[2] + ".svg"
            } else if (backend.bettingRound === "TURN") {
                turnImg.source = "qrc:/PokerApp/resources/images/cards/" + backend.comCards[3] + ".svg"
            } else if (backend.bettingRound === "RIVER") {
                riverImg.source = "qrc:/PokerApp/resources/images/cards/" + backend.comCards[4] + ".svg"
            }

            if (backend.betOpts[0] === "-")
                optionsColumn.visible = false
            else
                optionsColumn.visible = true            

            if (backend.topbetVal === "NONE")
                callAmountRow.visible = false
            else {
                callAmountRow.visible = true
                callAmountText.text = backend.topbetVal
            }
        }
    }
}
