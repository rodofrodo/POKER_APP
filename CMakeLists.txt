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

if(MSVC)
    add_compile_options(/utf-8)
endif()

# 1. Define the executable target FIRST.
qt_add_executable(POKER_APP 
    main.cpp
    backend.h
    backend.cpp
    general/globals.h
    general/globals.cpp
    classes/GameCard.h
    classes/GameCard.cpp
    SettingsManager.h
    SettingsManager.cpp
    engine/margin_calc.h
    # --- ADD THIS LINE ---
    resources.rc
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
        resources/Credits.qml
        resources/FadeImage.qml
        resources/FlipCard.qml
        resources/GamePage.qml
        resources/LobbyPage.qml
        resources/OptionsPage.qml
        resources/SignUpPage.qml
        # Normal images
        resources/images/back_arrow_32.png
        resources/images/back_arrow_hover_32.png
        resources/images/black_person_32.png
        resources/images/bind.svg
        resources/images/board_classic.svg
        resources/images/gray_rect.png
        resources/images/main_menu_logo.svg
        resources/images/person_40.png
        resources/images/side_logo.svg
        resources/images/small_gray_rect.png
        resources/images/small_white_rect.png
        resources/images/white_polygon_up_16.svg
        resources/images/white_polygon_down_16.svg
        resources/images/white_rect.png
        resources/images/white_small_button_rect.svg
        # Player action images
        resources/images/players/acts_rect.svg
        resources/images/players/all_in_rect.svg
        resources/images/players/bb_rect.svg
        resources/images/players/dealer_rect.svg
        resources/images/players/default_rect.svg
        resources/images/players/sb_rect.svg
        resources/images/players/winner_rect.svg
        # Cards small
        resources/images/cards/small/back.png
        # -- TWO --
        resources/images/cards/small/CLUBS_2.svg
        resources/images/cards/small/DIAMONDS_2.svg
        resources/images/cards/small/HEARTS_2.svg
        resources/images/cards/small/SPADES_2.svg
        # -- THREE --
        resources/images/cards/small/CLUBS_3.svg
        resources/images/cards/small/DIAMONDS_3.svg
        resources/images/cards/small/HEARTS_3.svg
        resources/images/cards/small/SPADES_3.svg
        # -- FOUR --
        resources/images/cards/small/CLUBS_4.svg
        resources/images/cards/small/DIAMONDS_4.svg
        resources/images/cards/small/HEARTS_4.svg
        resources/images/cards/small/SPADES_4.svg
        # -- FIVE --
        resources/images/cards/small/CLUBS_5.svg
        resources/images/cards/small/DIAMONDS_5.svg
        resources/images/cards/small/HEARTS_5.svg
        resources/images/cards/small/SPADES_5.svg
        # -- SIX --
        resources/images/cards/small/CLUBS_6.svg
        resources/images/cards/small/DIAMONDS_6.svg
        resources/images/cards/small/HEARTS_6.svg
        resources/images/cards/small/SPADES_6.svg
        # -- SEVEN --
        resources/images/cards/small/CLUBS_7.svg
        resources/images/cards/small/DIAMONDS_7.svg
        resources/images/cards/small/HEARTS_7.svg
        resources/images/cards/small/SPADES_7.svg
        # -- EIGHT --
        resources/images/cards/small/CLUBS_8.svg
        resources/images/cards/small/DIAMONDS_8.svg
        resources/images/cards/small/HEARTS_8.svg
        resources/images/cards/small/SPADES_8.svg
        # -- NINE --
        resources/images/cards/small/CLUBS_9.svg
        resources/images/cards/small/DIAMONDS_9.svg
        resources/images/cards/small/HEARTS_9.svg
        resources/images/cards/small/SPADES_9.svg
        # -- TEN --
        resources/images/cards/small/CLUBS_10.svg
        resources/images/cards/small/DIAMONDS_10.svg
        resources/images/cards/small/HEARTS_10.svg
        resources/images/cards/small/SPADES_10.svg
        # -- JACK --
        resources/images/cards/small/CLUBS_J.svg
        resources/images/cards/small/DIAMONDS_J.svg
        resources/images/cards/small/HEARTS_J.svg
        resources/images/cards/small/SPADES_J.svg
        # -- QUEEN --
        resources/images/cards/small/CLUBS_Q.svg
        resources/images/cards/small/DIAMONDS_Q.svg
        resources/images/cards/small/HEARTS_Q.svg
        resources/images/cards/small/SPADES_Q.svg
        # -- KING --
        resources/images/cards/small/CLUBS_K.svg
        resources/images/cards/small/DIAMONDS_K.svg
        resources/images/cards/small/HEARTS_K.svg
        resources/images/cards/small/SPADES_K.svg
        # -- ACE --
        resources/images/cards/small/CLUBS_A.svg
        resources/images/cards/small/DIAMONDS_A.svg
        resources/images/cards/small/HEARTS_A.svg
        resources/images/cards/small/SPADES_A.svg
        # Cards big modern
        resources/images/cards/back.png # fallback
        resources/images/cards/modern/back.png
        # -- TWO --
        resources/images/cards/modern/CLUBS_2.svg
        resources/images/cards/modern/DIAMONDS_2.svg
        resources/images/cards/modern/HEARTS_2.svg
        resources/images/cards/modern/SPADES_2.svg
        # -- THREE --
        resources/images/cards/modern/CLUBS_3.svg
        resources/images/cards/modern/DIAMONDS_3.svg
        resources/images/cards/modern/HEARTS_3.svg
        resources/images/cards/modern/SPADES_3.svg
        # -- FOUR --
        resources/images/cards/modern/CLUBS_4.svg
        resources/images/cards/modern/DIAMONDS_4.svg
        resources/images/cards/modern/HEARTS_4.svg
        resources/images/cards/modern/SPADES_4.svg
        # -- FIVE --
        resources/images/cards/modern/CLUBS_5.svg
        resources/images/cards/modern/DIAMONDS_5.svg
        resources/images/cards/modern/HEARTS_5.svg
        resources/images/cards/modern/SPADES_5.svg
        # -- SIX --
        resources/images/cards/modern/CLUBS_6.svg
        resources/images/cards/modern/DIAMONDS_6.svg
        resources/images/cards/modern/HEARTS_6.svg
        resources/images/cards/modern/SPADES_6.svg
        # -- SEVEN --
        resources/images/cards/modern/CLUBS_7.svg
        resources/images/cards/modern/DIAMONDS_7.svg
        resources/images/cards/modern/HEARTS_7.svg
        resources/images/cards/modern/SPADES_7.svg
        # -- EIGHT --
        resources/images/cards/modern/CLUBS_8.svg
        resources/images/cards/modern/DIAMONDS_8.svg
        resources/images/cards/modern/HEARTS_8.svg
        resources/images/cards/modern/SPADES_8.svg
        # -- NINE --
        resources/images/cards/modern/CLUBS_9.svg
        resources/images/cards/modern/DIAMONDS_9.svg
        resources/images/cards/modern/HEARTS_9.svg
        resources/images/cards/modern/SPADES_9.svg
        # -- TEN --
        resources/images/cards/modern/CLUBS_10.svg
        resources/images/cards/modern/DIAMONDS_10.svg
        resources/images/cards/modern/HEARTS_10.svg
        resources/images/cards/modern/SPADES_10.svg
        # -- JACK --
        resources/images/cards/modern/CLUBS_J.svg
        resources/images/cards/modern/DIAMONDS_J.svg
        resources/images/cards/modern/HEARTS_J.svg
        resources/images/cards/modern/SPADES_J.svg
        # -- QUEEN --
        resources/images/cards/modern/CLUBS_Q.svg
        resources/images/cards/modern/DIAMONDS_Q.svg
        resources/images/cards/modern/HEARTS_Q.svg
        resources/images/cards/modern/SPADES_Q.svg
        # -- KING --
        resources/images/cards/modern/CLUBS_K.svg
        resources/images/cards/modern/DIAMONDS_K.svg
        resources/images/cards/modern/HEARTS_K.svg
        resources/images/cards/modern/SPADES_K.svg
        # -- ACE --
        resources/images/cards/modern/CLUBS_A.svg
        resources/images/cards/modern/DIAMONDS_A.svg
        resources/images/cards/modern/HEARTS_A.svg
        resources/images/cards/modern/SPADES_A.svg
        # Cards big classic
        resources/images/cards/classic/back_red.png
        resources/images/cards/classic/back_blue.png
        # Figures
        resources/images/cards/classic/CLUBS_J_img.png
        resources/images/cards/classic/CLUBS_Q_img.png
        resources/images/cards/classic/CLUBS_K_img.png
        resources/images/cards/classic/DIAMONDS_J_img.png
        resources/images/cards/classic/DIAMONDS_Q_img.png
        resources/images/cards/classic/DIAMONDS_K_img.png
        resources/images/cards/classic/HEARTS_J_img.png
        resources/images/cards/classic/HEARTS_Q_img.png
        resources/images/cards/classic/HEARTS_K_img.png
        resources/images/cards/classic/SPADES_J_img.png
        resources/images/cards/classic/SPADES_Q_img.png
        resources/images/cards/classic/SPADES_K_img.png
        # -- TWO --
        resources/images/cards/classic/CLUBS_2.svg
        resources/images/cards/classic/DIAMONDS_2.svg
        resources/images/cards/classic/HEARTS_2.svg
        resources/images/cards/classic/SPADES_2.svg
        # -- THREE --
        resources/images/cards/classic/CLUBS_3.svg
        resources/images/cards/classic/DIAMONDS_3.svg
        resources/images/cards/classic/HEARTS_3.svg
        resources/images/cards/classic/SPADES_3.svg
        # -- FOUR --
        resources/images/cards/classic/CLUBS_4.svg
        resources/images/cards/classic/DIAMONDS_4.svg
        resources/images/cards/classic/HEARTS_4.svg
        resources/images/cards/classic/SPADES_4.svg
        # -- FIVE --
        resources/images/cards/classic/CLUBS_5.svg
        resources/images/cards/classic/DIAMONDS_5.svg
        resources/images/cards/classic/HEARTS_5.svg
        resources/images/cards/classic/SPADES_5.svg
        # -- SIX --
        resources/images/cards/classic/CLUBS_6.svg
        resources/images/cards/classic/DIAMONDS_6.svg
        resources/images/cards/classic/HEARTS_6.svg
        resources/images/cards/classic/SPADES_6.svg
        # -- SEVEN --
        resources/images/cards/classic/CLUBS_7.svg
        resources/images/cards/classic/DIAMONDS_7.svg
        resources/images/cards/classic/HEARTS_7.svg
        resources/images/cards/classic/SPADES_7.svg
        # -- EIGHT --
        resources/images/cards/classic/CLUBS_8.svg
        resources/images/cards/classic/DIAMONDS_8.svg
        resources/images/cards/classic/HEARTS_8.svg
        resources/images/cards/classic/SPADES_8.svg
        # -- NINE --
        resources/images/cards/classic/CLUBS_9.svg
        resources/images/cards/classic/DIAMONDS_9.svg
        resources/images/cards/classic/HEARTS_9.svg
        resources/images/cards/classic/SPADES_9.svg
        # -- TEN --
        resources/images/cards/classic/CLUBS_10.svg
        resources/images/cards/classic/DIAMONDS_10.svg
        resources/images/cards/classic/HEARTS_10.svg
        resources/images/cards/classic/SPADES_10.svg
        # -- JACK --
        resources/images/cards/classic/CLUBS_J.svg
        resources/images/cards/classic/DIAMONDS_J.svg
        resources/images/cards/classic/HEARTS_J.svg
        resources/images/cards/classic/SPADES_J.svg
        # -- QUEEN --
        resources/images/cards/classic/CLUBS_Q.svg
        resources/images/cards/classic/DIAMONDS_Q.svg
        resources/images/cards/classic//HEARTS_Q.svg
        resources/images/cards/classic/SPADES_Q.svg
        # -- KING --
        resources/images/cards/classic/CLUBS_K.svg
        resources/images/cards/classic/DIAMONDS_K.svg
        resources/images/cards/classic/HEARTS_K.svg
        resources/images/cards/classic/SPADES_K.svg
        # -- ACE --
        resources/images/cards/classic/CLUBS_A.svg
        resources/images/cards/classic/DIAMONDS_A.svg
        resources/images/cards/classic/HEARTS_A.svg
        resources/images/cards/classic/SPADES_A.svg
        # Fonts
        fonts/georgia.ttf
        fonts/georgiab.ttf
        fonts/georgiai.ttf
        fonts/georgiaz.ttf
        # Boards
        resources/images/boards/board_lukewarm.svg
        resources/images/boards/board_macao.svg
        resources/images/boards/board_wine.svg
)

# 3. Link libraries (using the known target name).
target_link_libraries(POKER_APP PRIVATE 
    Qt6::Quick
    Qt6::Network
)