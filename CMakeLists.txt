cmake_minimum_required(VERSION 3.16)

# --- Mandatory for Qt6 C++ integration ---
set(CMAKE_AUTOMOC ON) 
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

project(POKER_APP LANGUAGES CXX) # Target name POKER_APP is defined here
# ... other CMAKE set() commands

# Find Qt6 Packages
find_package(Qt6 REQUIRED COMPONENTS Quick Network)

# 1. Define the executable target FIRST.
qt_add_executable(POKER_APP 
    main.cpp
    backend.h
    backend.cpp
)

# 2. Then, reference the target when creating the QML module.
qt_add_qml_module(POKER_APP # <-- This target reference is now known
    URI PokerApp
    VERSION 1.0
    QML_FILES
        resources/main.qml
        resources/MainMenu.qml
        resources/ConnectPage.qml
        resources/OptionsPage.qml
        resources/images/back_arrow_32.png
        resources/images/gray_rect.png
        resources/images/main_menu_logo.png
        resources/images/side_logo.png
        resources/images/small_white_rect.png
        resources/images/white_rect.png
)

# 3. Link libraries (using the known target name).
target_link_libraries(POKER_APP PRIVATE 
    Qt6::Quick
    Qt6::Network
)