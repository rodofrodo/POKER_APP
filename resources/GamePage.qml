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
            console.log("folded")
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

    Row {
        anchors.horizontalCenter: communityCards.horizontalCenter
        anchors.bottom: communityCards.top
        anchors.bottomMargin: 120

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
        anchors.bottomMargin: 15
        anchors.rightMargin: 15
        spacing: 10

        Text {
            text: "Check/Call"
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            color: "#ffffff"

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor // Changes mouse to a "Hand" icon
                onClicked: {
                    backend._match_bet();
                }
            }
        }

        Text {
            text: "Bet/Raise"
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            color: "#ffffff"
        }

        Text {
            text: "Fold"
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            color: "#ffffff"
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
        }
    }
}
