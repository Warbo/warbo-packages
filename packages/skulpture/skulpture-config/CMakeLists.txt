cmake_minimum_required(VERSION 3.16)
project(kstyle-skulpture-config)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 REQUIRED COMPONENTS Core Widgets)

set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

add_executable(kstyle-skulpture-config main.cpp)
target_link_libraries(kstyle-skulpture-config Qt5::Core Qt5::Widgets)

install(TARGETS kstyle-skulpture-config DESTINATION bin)
