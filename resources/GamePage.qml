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
            backend._change_bet_open();
            optionsColumn.visible = false
            raiseRow.visible = true
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
        spacing: 15
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10

        Repeater {
            model: backend.lobbySize
            
            Image {
                source: (backend.uiTrigger, backend.getBackground(index))
                opacity: (backend.uiTrigger, backend.getOpacity(index))
                width: 280
                height: 73
                fillMode: Image.PreserveAspectFit

                Column {
                    //spacing: 3
                    anchors.left: parent.left
                    anchors.leftMargin: 25 
                    anchors.verticalCenter: parent.verticalCenter

                    Row {
                        spacing: 8

                        Text {
                            text: (backend.uiTrigger, backend.getPlayerName(index))
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignLeft
                            color: (backend.uiTrigger, backend.getTextColor(index))
                            font.bold: true
                        }

                        Text {
                            text: (backend.uiTrigger, backend.getLoans(index))
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignLeft
                            color: "#0077FF"
                            font.bold: true
                        }
                    }

                    Text {
                        text: (backend.uiTrigger, backend.getBalance(index))
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        color: (backend.uiTrigger, backend.getTextColor(index))
                    }
                }

                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: 25
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    Text {
                        id: betValText
                        text: (backend.uiTrigger, backend.getCurrentBet(index))
                        font.pixelSize: 24
                        horizontalAlignment: Text.AlignHCenter
                        visible: text !== "None" && backend.bettingRound !== "SHOWDOWN"
                        color: (backend.uiTrigger, backend.getPriceTextColor(index))
                        font.bold: true
                    }

                    Image {
                        visible: backend.bettingRound === "SHOWDOWN" && (backend.uiTrigger, backend.getLeftCard(index)) !== "back.png"
                        source: "qrc:/PokerApp/resources/images/cards/small/" + (backend.uiTrigger, backend.getLeftCard(index))
                        width: 28
                        height: 46
                        fillMode: Image.PreserveAspectFit 
                    }

                    Image {
                        visible: backend.bettingRound === "SHOWDOWN" && (backend.uiTrigger, backend.getRightCard(index)) !== "back.png"
                        source: "qrc:/PokerApp/resources/images/cards/small/" + (backend.uiTrigger, backend.getRightCard(index))
                        width: 28
                        height: 46
                        fillMode: Image.PreserveAspectFit 
                    }
                }
            }
        }
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

            Image {
                id: innerFlop1Img
                anchors.centerIn: parent
                width: 86
                height: 134
                fillMode: Image.PreserveAspectFit 
            }
        }

        Image {
            id: flop2Img
            source: "qrc:/PokerApp/resources/images/cards/back.png" 
            width: 135
            height: 178
            fillMode: Image.PreserveAspectFit 

            Image {
                id: innerFlop2Img
                anchors.centerIn: parent
                width: 86
                height: 134
                fillMode: Image.PreserveAspectFit 
            }
        }

        Image {
            id: flop3Img
            source: "qrc:/PokerApp/resources/images/cards/back.png" 
            width: 135
            height: 178
            fillMode: Image.PreserveAspectFit 

            Image {
                id: innerFlop3Img
                anchors.centerIn: parent
                width: 86
                height: 134
                fillMode: Image.PreserveAspectFit 
            }
        }

        Image {
            id: turnImg
            source: "qrc:/PokerApp/resources/images/cards/back.png" 
            width: 135
            height: 178
            fillMode: Image.PreserveAspectFit 

            Image {
                id: innerTurnImg
                anchors.centerIn: parent
                width: 86
                height: 134
                fillMode: Image.PreserveAspectFit 
            }
        }

        Image {
            id: riverImg
            source: "qrc:/PokerApp/resources/images/cards/back.png" 
            width: 135
            height: 178
            fillMode: Image.PreserveAspectFit 

            Image {
                id: innerRiverImg
                anchors.centerIn: parent
                width: 86
                height: 134
                fillMode: Image.PreserveAspectFit 
            }
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

    Text {
        id: yourTurnText

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 320

        visible: backend.isActingPlayer
        text: "Your turn!"
        font.pixelSize: 24
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        color: "#FF007B"
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

            Image {
                id: innerLeftCard
                anchors.centerIn: parent
                width: 86
                height: 134
                fillMode: Image.PreserveAspectFit 
            }

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

            Image {
                id: innerRightCard
                anchors.centerIn: parent
                width: 86
                height: 134
                fillMode: Image.PreserveAspectFit 
            }

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
                    if (backend.betOpts[1] !== "-") {
                        backend._change_bet_open();
                        optionsColumn.visible = false
                        raiseRow.visible = true
                    }
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
                opacity: backend.raiseUpOpacity

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: backend.increaseBet()
                }
            }

            Text {
                text: backend.raiseUpText
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter 
                font.pixelSize: 32
                color: "#ffffff"
            }

            Image {
                source: "qrc:/PokerApp/resources/images/white_polygon_down_16.svg"
                width: 16; height: 16
                anchors.horizontalCenter: parent.horizontalCenter
                opacity: backend.raiseDownOpacity

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
            if (backend.leftCard && backend.leftCard !== "") {
                leftCard.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.leftCard + ".svg"
                innerLeftCard.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.leftCard + "_img.png"
            }
            else
                leftCard.source = "qrc:/PokerApp/resources/images/cards/back.png"

            if (backend.rightCard && backend.rightCard !== "") {
                rightCard.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.rightCard + ".svg"
                innerRightCard.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.rightCard + "_img.png"
            }
            else
                rightCard.source = "qrc:/PokerApp/resources/images/cards/back.png"

            bettingRoundText.text = backend.bettingRound
            potText.text = backend.potVal

            if (backend.bettingRound == "DEALING CARDS") {
                leftCard.source = "qrc:/PokerApp/resources/images/cards/back.png"
                rightCard.source = "qrc:/PokerApp/resources/images/cards/back.png"
            } else if (backend.bettingRound === "FLOP") {
                flop1Img.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.comCards[0] + ".svg"
                flop2Img.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.comCards[1] + ".svg"
                flop3Img.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.comCards[2] + ".svg"
                innerFlop1Img.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.comCards[0] + "_img.png"
                innerFlop2Img.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.comCards[1] + "_img.png"
                innerFlop3Img.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.comCards[2] + "_img.png"
            } else if (backend.bettingRound === "TURN") {
                turnImg.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.comCards[3] + ".svg"
                innerTurnImg.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.comCards[3] + "_img.png"
            } else if (backend.bettingRound === "RIVER") {
                riverImg.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.comCards[4] + ".svg"
                innerRiverImg.source = "qrc:/PokerApp/resources/images/cards/" + AppSettings.cardDeck + "/" + backend.comCards[4] + "_img.png"
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
