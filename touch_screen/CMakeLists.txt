cmake_minimum_required(VERSION 2.8.11)
project(touch_screen)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS roscpp roslib std_msgs geometry_msgs touch_screen_msgs)

catkin_package(
  CATKIN_DEPENDS roscpp std_msgs roslib geometry_msgs
  DEPENDS touch_screen_msgs
)

## System dependencies are found with CMake's conventions
# find_package(Boost REQUIRED COMPONENTS system)

#set(CMAKE_AUTOMOC ON)
#set(CMAKE_AUTORCC ON)
#set(CMAKE_INCLUDE_CURRENT_DIR ON)
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)
# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)

find_package(Qt5Core)
find_package(Qt5Gui)
find_package(Qt5Qml)
find_package(Qt5WebEngine)



find_package(Qt5Quick)
find_package(Qt5WebEngineCore)
find_package(Qt5Network)
find_package(Qt5Widgets)
find_package(Qt5Multimedia)
find_package(Qt5MultimediaWidgets)
find_package(Qt5Concurrent)
find_package(Qt5WebKit)
find_package(Qt5WebKitWidgets)


qt5_add_resources(QT_RESOURCES_CPP resources/qml.qrc)
qt5_wrap_cpp(QT_MOC_HPP src/screen_interface.h src/MultimediaProperties.h src/ros_subscriber_thread.h src/ros_publisher_thread.h src/templateProperties.h src/textproperties.h src/ros_client_thread.h src/ros_server_thread.h)

include_directories(src ${catkin_INCLUDE_DIRS})
include_directories(${Qt5Widgets_INCLUDE_DIRS})

#add_executable(screen_interface src/screen_interface_main.cpp
#                                    src/screen_interface.cpp src/ros_subscriber_thread.cpp src/ros_publisher_thread.cpp src/ros_client_thread.cpp src/ros_server_thread.cpp
#                                    ${QT_RESOURCES_CPP}
#                                    ${QT_MOC_HPP})

#target_link_libraries(screen_interface
#                            ${QT_LIBRARIES}
#                            ${catkin_LIBRARIES}
#                            Qt5::Core Qt5::Gui Qt5::Qml Qt5::Quick
#                            Qt5::WebEngine Qt5::WebEngineCore Qt5::Network
#                            Qt5::Multimedia Qt5::MultimediaWidgets Qt5::Widgets Qt5::Concurrent)

#install(TARGETS screen_interface
#  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
#)

################

#SET(PROJECT_RESOURCES
#    ../resources/qml.qrc
#)
#qt5_add_resources(PROJECT_RESOURCES_CXX ${PROJECT_RESOURCES})


################################################
## Declare ROS messages, services and actions ##
################################################

## To declare and build messages, services or actions from within this
## package, follow these steps:
## * Let MSG_DEP_SET be the set of packages whose message types you use in
##   your messages/services/actions (e.g. std_msgs, actionlib_msgs, ...).
## * In the file package.xml:
##   * add a build_depend and a run_depend tag for each package in MSG_DEP_SET
##   * If MSG_DEP_SET isn't empty the following dependencies might have been
##     pulled in transitively but can be declared for certainty nonetheless:
##     * add a build_depend tag for "message_generation"
##     * add a run_depend tag for "message_runtime"
## * In this file (CMakeLists.txt):
##   * add "message_generation" and every package in MSG_DEP_SET to
##     find_package(catkin REQUIRED COMPONENTS ...)
##   * add "message_runtime" and every package in MSG_DEP_SET to
##     catkin_package(CATKIN_DEPENDS ...)
##   * uncomment the add_*_files sections below as needed
##     and list every .msg/.srv/.action file to be processed
##   * uncomment the generate_messages entry below
##   * add every package in MSG_DEP_SET to generate_messages(DEPENDENCIES ...)


###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if you package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
  INCLUDE_DIRS src
  CATKIN_DEPENDS roscpp std_msgs roslib geometry_msgs
  DEPENDS touch_screen_msgs
)

###########
## Build ##
###########

# INCLUDE(${QT_USE_FILE})

## Specify additional locations of header files
## Your package locations should be listed before other locations
# include_directories(include)
include_directories(
  include
  src
  ${catkin_INCLUDE_DIRS}
  ${CMAKE_CURRENT_BINARY_DIR} #for qt generated file
)

message(STATUS "CMAKE_CURRENT_BINARY_DIR: ${CMAKE_CURRENT_BINARY_DIR}" )


add_library(screen_interface_lib
                                src/screen_interface.h src/screen_interface.cpp src/MultimediaProperties.h src/MenuProperties.h src/MenuButton.h src/templateProperties.h src/textproperties.h)
target_link_libraries(screen_interface_lib
                                                Qt5::Core
                                                Qt5::Gui
                                                Qt5::Qml
                                                Qt5::WebEngine
#                                    						Qt5::WebKit
                                                Qt5::WebEngineCore
                                                Qt5::Network
#                                                Qt5::Multimedia
#                                                Qt5::MultimediaWidgets
#                                                Qt5::Widgets
#                                                Qt5::Concurrent
                                                ${catkin_LIBRARIES})

add_library(ros_subscriber_thread_lib
                                src/ros_subscriber_thread.h src/ros_subscriber_thread.cpp)
target_link_libraries(ros_subscriber_thread_lib
                                                Qt5::Core
#                                                Qt5::Gui
#                                                Qt5::Qml
#                                                Qt5::Quick
#                                                Qt5::WebEngine
#                                                Qt5::WebEngineCore
#                                                Qt5::Network
#                                                Qt5::Multimedia
#                                                Qt5::MultimediaWidgets
#                                                Qt5::Widgets
#                                                Qt5::Concurrent
                                                ${catkin_LIBRARIES})

add_library(ros_publisher_thread_lib
                                src/ros_publisher_thread.h src/ros_publisher_thread.cpp)
target_link_libraries(ros_publisher_thread_lib
                                                Qt5::Core
#                                                Qt5::Gui
#                                                Qt5::Qml
#                                                Qt5::Quick
#                                                Qt5::WebEngine
#                                                Qt5::WebEngineCore
#                                                Qt5::Network
#                                                Qt5::Multimedia
#                                                Qt5::MultimediaWidgets
#                                                Qt5::Widgets
#                                                Qt5::Concurrent
                                                ${catkin_LIBRARIES})

add_library(ros_client_thread_lib
                                src/ros_client_thread.h src/ros_client_thread.cpp)
target_link_libraries(ros_client_thread_lib
                                                Qt5::Core
                                                Qt5::Gui
                                                Qt5::Qml
#                                                Qt5::Quick
                                                Qt5::WebEngine
                                                Qt5::WebEngineCore
                                                Qt5::Network
#                                                Qt5::Multimedia
#                                                Qt5::MultimediaWidgets
#                                                Qt5::Widgets
#                                                Qt5::Concurrent
                                                ${catkin_LIBRARIES})

add_library(ros_server_thread_lib
                                src/ros_server_thread.h src/ros_server_thread.cpp)
target_link_libraries(ros_server_thread_lib
                                                Qt5::Core
#                                                Qt5::Gui
#                                                Qt5::Qml
#                                                Qt5::Quick
#                                                Qt5::WebEngine
#                                                Qt5::WebEngineCore
#                                                Qt5::Network
#                                                Qt5::Multimedia
#                                                Qt5::MultimediaWidgets
#                                                Qt5::Widgets
#                                                Qt5::Concurrent
                                                ${catkin_LIBRARIES})

# #QT interface
add_executable(screen_interface
               src/screen_interface_main.cpp ${QT_RESOURCES_CPP})

target_link_libraries(screen_interface
                                                screen_interface_lib
                                                ros_server_thread_lib
                                                ros_subscriber_thread_lib
                                                ros_publisher_thread_lib
                                                ros_client_thread_lib
                                                ${catkin_LIBRARIES})

