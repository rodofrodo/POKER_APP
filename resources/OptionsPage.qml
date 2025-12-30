import QtQuick
import QtQuick.Controls

Page {
    title: "Options"

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
        spacing: 32
        width: 890

        Text {
            text: "Options"
            font.pixelSize: 36
            font.bold: true
            color: "#FFFFFF"
        }

        Column {
            width: parent.width
            spacing: 24

            Item {
                width: parent.width
                height: 30

                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Card design:"
                    font.pixelSize: 24
                    color: "#FFFFFF"
                }

                Text {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Preview"
                    font.pixelSize: 24
                    color: "#FFFFFF"
                    font.italic: true
                }
            }

            Item {
                width: parent.width
                height: 100

                Image {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    source: AppSettings.cardDeck === "modern" ? "qrc:/PokerApp/resources/images/opt_white_small_rect.svg" : ""
                    width: 209
                    height: 43
                    fillMode: Image.PreserveAspectFit 

                    Text {
                        anchors.centerIn: parent

                        text: "MODERN"
                        color: AppSettings.cardDeck === "modern" ? "#000000" : "#ffffff"
                        font.pixelSize: 20
                        font.bold: true
                    }

                    MouseArea {
                        id: modern_ma
                        anchors.fill: parent

                        hoverEnabled: true 
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            AppSettings.setCardDeck("modern")
                            AppSettings.setCardBack("back")
                            classicBackLabelColumn.visible = false
                        }
                    }
                }

                Row {
                    anchors.right: parent.right
                    spacing: 10

                    Image {
                        source: "qrc:/PokerApp/resources/images/cards/modern/back.png"
                        width: 75
                        height: 100
                        fillMode: Image.PreserveAspectFit 
                    }

                    Image {
                        source: "qrc:/PokerApp/resources/images/cards/modern/CLUBS_A.svg"
                        width: 75
                        height: 100
                        fillMode: Image.PreserveAspectFit 
                    }

                    Image {
                        source: "qrc:/PokerApp/resources/images/cards/modern/HEARTS_J.svg"
                        width: 75
                        height: 100
                        fillMode: Image.PreserveAspectFit 
                    }

                    Image {
                        source: "qrc:/PokerApp/resources/images/cards/modern/SPADES_8.svg"
                        width: 75
                        height: 100
                        fillMode: Image.PreserveAspectFit 
                    }
                }
            }

            Item {
                width: parent.width
                height: 100

                Image {
                    id: classicBtn
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    source: AppSettings.cardDeck === "classic" ? "qrc:/PokerApp/resources/images/opt_white_small_rect.svg" : ""
                    width: 209
                    height: 43
                    fillMode: Image.PreserveAspectFit 

                    Text {
                        anchors.centerIn: parent

                        text: "CLASSIC"
                        color: AppSettings.cardDeck === "classic" ? "#000000" : "#ffffff"
                        font.pixelSize: 20
                        font.bold: true
                    }

                    MouseArea {
                        id: classic_ma
                        anchors.fill: parent

                        hoverEnabled: true 
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            AppSettings.setCardDeck("classic")
                            AppSettings.setCardBack("back_red")
                            classicBackLabelColumn.visible = true
                        }
                    }
                }

                Column {
                    id: classicBackLabelColumn
                    spacing: 15
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: classicBtn.right
                    anchors.leftMargin: 30
                    visible: AppSettings.cardDeck === "classic"

                    Text {
                        text: "RED"
                        color: "#ffffff"
                        font.pixelSize: 20
                        font.italic: true
                        font.underline: AppSettings.cardBack === "back_red"

                        MouseArea {
                            anchors.fill: parent

                            hoverEnabled: true 
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                AppSettings.setCardBack("back_red")
                            }
                        }
                    }

                    Text {
                        text: "BLUE"
                        color: "#ffffff"
                        font.pixelSize: 20
                        font.italic: true
                        font.underline: AppSettings.cardBack === "back_blue"

                        MouseArea {
                            anchors.fill: parent

                            hoverEnabled: true 
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                AppSettings.setCardBack("back_blue")
                            }
                        }
                    }
                }

                Row {
                    anchors.right: parent.right
                    spacing: 10

                    Image {
                        source: "qrc:/PokerApp/resources/images/cards/classic/back_red.png"
                        width: 75
                        height: 100
                        fillMode: Image.PreserveAspectFit 
                    }

                    Image {
                        source: "qrc:/PokerApp/resources/images/cards/classic/back_blue.png"
                        width: 75
                        height: 100
                        fillMode: Image.PreserveAspectFit 
                    }

                    Image {
                        source: "qrc:/PokerApp/resources/images/cards/classic/CLUBS_A.svg"
                        width: 75
                        height: 100
                        fillMode: Image.PreserveAspectFit 
                    }

                    Image {
                        source: "qrc:/PokerApp/resources/images/cards/classic/HEARTS_J.svg"
                        width: 75
                        height: 100
                        fillMode: Image.PreserveAspectFit 

                        Image {
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset: -1
                            source: "qrc:/PokerApp/resources/images/cards/classic/HEARTS_J_img.png"
                            width: 48
                            height: 76
                            fillMode: Image.PreserveAspectFit 
                        }
                    }

                    Image {
                        source: "qrc:/PokerApp/resources/images/cards/classic/SPADES_8.svg"
                        width: 75
                        height: 100
                        fillMode: Image.PreserveAspectFit 
                    }
                }
            }
        }

        Column {
            width: parent.width
            spacing: 55

            Item {
                width: parent.width
                height: 30

                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Background:"
                    font.pixelSize: 24
                    color: "#FFFFFF"
                }

                Text {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Preview"
                    font.pixelSize: 24
                    color: "#FFFFFF"
                    font.italic: true
                }
            }

            Item {
                width: parent.width
                height: 43

                Image {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    source: AppSettings.bgImg === "macao" ? "qrc:/PokerApp/resources/images/opt_white_small_rect.svg" : ""
                    width: 209
                    height: 43
                    fillMode: Image.PreserveAspectFit 

                    Text {
                        anchors.centerIn: parent

                        text: "MACAO"
                        color: AppSettings.bgImg === "macao" ? "#000000" : "#ffffff"
                        font.pixelSize: 20
                        font.bold: true
                    }
                    
                    MouseArea {
                        anchors.fill: parent

                        hoverEnabled: true 
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            AppSettings.setBgImg("macao")
                            AppSettings.setColor("#FF007B")
                        }
                    }
                }

                Image {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    source: "qrc:/PokerApp/resources/images/board_colors/macao.svg"
                    width: 200
                    height: 24
                    fillMode: Image.PreserveAspectFit 
                }
            }

            Item {
                width: parent.width
                height: 43

                Image {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    source: AppSettings.bgImg === "lukewarm" ? "qrc:/PokerApp/resources/images/opt_white_small_rect.svg" : ""
                    width: 209
                    height: 43
                    fillMode: Image.PreserveAspectFit 

                    Text {
                        anchors.centerIn: parent

                        text: "LUKEWARM"
                        color: AppSettings.bgImg === "lukewarm" ? "#000000" : "#ffffff"
                        font.pixelSize: 20
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent

                        hoverEnabled: true 
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            AppSettings.setBgImg("lukewarm")
                            AppSettings.setColor("#FF7700")
                        }
                    }
                }

                Image {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    source: "qrc:/PokerApp/resources/images/board_colors/lukewarm.svg"
                    width: 200
                    height: 24
                    fillMode: Image.PreserveAspectFit 
                }
            }

            Item {
                width: parent.width
                height: 43

                Image {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    source: AppSettings.bgImg === "classic" ? "qrc:/PokerApp/resources/images/opt_white_small_rect.svg" : ""
                    width: 209
                    height: 43
                    fillMode: Image.PreserveAspectFit 

                    Text {
                        anchors.centerIn: parent

                        text: "CLASSIC"
                        color: AppSettings.bgImg === "classic" ? "#000000" : "#ffffff"
                        font.pixelSize: 20
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent

                        hoverEnabled: true 
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            AppSettings.setBgImg("classic")
                            AppSettings.setColor("#FFFFFF")
                        }
                    }
                }

                Image {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    source: "qrc:/PokerApp/resources/images/board_colors/classic.svg"
                    width: 200
                    height: 24
                    fillMode: Image.PreserveAspectFit 
                }
            }

            Item {
                width: parent.width
                height: 43

                Image {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter

                    source: AppSettings.bgImg === "wine" ? "qrc:/PokerApp/resources/images/opt_white_small_rect.svg" : ""
                    width: 209
                    height: 43
                    fillMode: Image.PreserveAspectFit 

                    Text {
                        anchors.centerIn: parent

                        text: "WINE"
                        color: AppSettings.bgImg === "wine" ? "#000000" : "#ffffff"
                        font.pixelSize: 20
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent

                        hoverEnabled: true 
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            AppSettings.setBgImg("wine")
                            AppSettings.setColor("#439BFF")
                        }
                    }
                }

                Image {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    source: "qrc:/PokerApp/resources/images/board_colors/wine.svg"
                    width: 200
                    height: 24
                    fillMode: Image.PreserveAspectFit 
                }
            }
        }
    }
}