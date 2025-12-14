cmake_minimum_required(VERSION 3.16)

# --- Mandatory for Qt6 C++ integration ---
set(CMAKE_AUTOMOC ON) 
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(POKER_APP LANGUAGES CXX) # Target name POKER_APP is defined here
# ... other CMAKE set() commands

# Find Qt6 Packages
find_package(Qt6 REQUIRED COMPONENTS Quick Network)

# 1. Define the executable target FIRST.
qt_add_executable(POKER_APP 
    main.cpp
    backend.h
    backend.cpp
    general/globals.h
    general/globals.cpp
    classes/GameCard.h
    classes/GameCard.cpp
)

# 2. Then, reference the target when creating the QML module.
qt_add_qml_module(POKER_APP # <-- This target reference is now known
    URI PokerApp
    VERSION 1.0
    QML_FILES
        # QML files
        resources/main.qml
        resources/MainMenu.qml
        resources/ConnectPage.qml
        resources/GamePage.qml
        resources/LobbyPage.qml
        resources/OptionsPage.qml
        resources/SignUpPage.qml
        # Normal images
        resources/images/back_arrow_32.png
        resources/images/back_arrow_hover_32.png
        resources/images/black_person_32.png
        resources/images/board_classic.svg
        resources/images/gray_rect.png
        resources/images/main_menu_logo.svg
        resources/images/person_40.png
        resources/images/side_logo.svg
        resources/images/small_gray_rect.png
        resources/images/small_white_rect.png
        resources/images/white_rect.png
        # Cards
        resources/images/cards/back.png
        # -- TWO --
        resources/images/cards/CLUBS_2.svg
        resources/images/cards/DIAMONDS_2.svg
        resources/images/cards/HEARTS_2.svg
        resources/images/cards/SPADES_2.svg
        # -- THREE --
        resources/images/cards/CLUBS_3.svg
        resources/images/cards/DIAMONDS_3.svg
        resources/images/cards/HEARTS_3.svg
        resources/images/cards/SPADES_3.svg
        # -- FOUR --
        resources/images/cards/CLUBS_4.svg
        resources/images/cards/DIAMONDS_4.svg
        resources/images/cards/HEARTS_4.svg
        resources/images/cards/SPADES_4.svg
        # -- FIVE --
        resources/images/cards/CLUBS_5.svg
        resources/images/cards/DIAMONDS_5.svg
        resources/images/cards/HEARTS_5.svg
        resources/images/cards/SPADES_5.svg
        # -- SIX --
        resources/images/cards/CLUBS_6.svg
        resources/images/cards/DIAMONDS_6.svg
        resources/images/cards/HEARTS_6.svg
        resources/images/cards/SPADES_6.svg
        # -- SEVEN --
        resources/images/cards/CLUBS_7.svg
        resources/images/cards/DIAMONDS_7.svg
        resources/images/cards/HEARTS_7.svg
        resources/images/cards/SPADES_7.svg
        # -- EIGHT --
        resources/images/cards/CLUBS_8.svg
        resources/images/cards/DIAMONDS_8.svg
        resources/images/cards/HEARTS_8.svg
        resources/images/cards/SPADES_8.svg
        # -- NINE --
        resources/images/cards/CLUBS_9.svg
        resources/images/cards/DIAMONDS_9.svg
        resources/images/cards/HEARTS_9.svg
        resources/images/cards/SPADES_9.svg
        # -- TEN --
        resources/images/cards/CLUBS_10.svg
        resources/images/cards/DIAMONDS_10.svg
        resources/images/cards/HEARTS_10.svg
        resources/images/cards/SPADES_10.svg
        # -- JACK --
        resources/images/cards/CLUBS_J.svg
        resources/images/cards/DIAMONDS_J.svg
        resources/images/cards/HEARTS_J.svg
        resources/images/cards/SPADES_J.svg
        # -- QUEEN --
        resources/images/cards/CLUBS_Q.svg
        resources/images/cards/DIAMONDS_Q.svg
        resources/images/cards/HEARTS_Q.svg
        resources/images/cards/SPADES_Q.svg
        # -- KING --
        resources/images/cards/CLUBS_K.svg
        resources/images/cards/DIAMONDS_K.svg
        resources/images/cards/HEARTS_K.svg
        resources/images/cards/SPADES_K.svg
        # -- ACE --
        resources/images/cards/CLUBS_A.svg
        resources/images/cards/DIAMONDS_A.svg
        resources/images/cards/HEARTS_A.svg
        resources/images/cards/SPADES_A.svg
        # Fonts
        fonts/georgia.ttf
        fonts/georgiab.ttf
        fonts/georgiai.ttf
        fonts/georgiaz.ttf
)

# 3. Link libraries (using the known target name).
target_link_libraries(POKER_APP PRIVATE 
    Qt6::Quick
    Qt6::Network
)