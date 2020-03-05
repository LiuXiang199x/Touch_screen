#~ set(qt_srcs
      #~ screen_interface.cpp
      #~ ros_subscriber_thread.cpp)
#~ set(qt_hdrs
      #~ screen_interface.h
      #~ ros_subscriber_thread.h)
#~ 
#~ qt5_automoc(${qt_srcs})
#~ QT5_WRAP_CPP(qt_moc_srcs ${qt_hdrs})


add_library(screen_interface_lib
				screen_interface.h screen_interface.cpp MultimediaProperties.h)
target_link_libraries(screen_interface_lib
                                                Qt5::Core Qt5::Gui Qt5::Qml Qt5::Quick
						Qt5::WebEngine Qt5::WebEngineCore Qt5::Network
						Qt5::Multimedia Qt5::MultimediaWidgets Qt5::Widgets Qt5::Concurrent
                                                ${PROJECT_RErhhSOURCES_CXX} ${catkin_LIBRARIES})

add_library(ros_subscriber_thread_lib
				ros_subscriber_thread.h ros_subscriber_thread.cpp)
target_link_libraries(ros_subscriber_thread_lib
						Qt5::Core Qt5::Gui Qt5::Qml Qt5::Quick 
						Qt5::WebEngine Qt5::WebEngineCore Qt5::Network
						Qt5::Multimedia Qt5::MultimediaWidgets Qt5::Widgets Qt5::Concurrent
					    ${catkin_LIBRARIES})

add_library(ros_publisher_thread_lib
				ros_publisher_thread.h ros_publisher_thread.cpp)				
target_link_libraries(ros_publisher_thread_lib
						Qt5::Core Qt5::Gui Qt5::Qml Qt5::Quick 
						Qt5::WebEngine Qt5::WebEngineCore Qt5::Network
						Qt5::Multimedia Qt5::MultimediaWidgets Qt5::Widgets Qt5::Concurrent
						${catkin_LIBRARIES})

# #QT interface
add_executable(screen_interface
               screen_interface_main.cpp ../resources/qml.qrc)
                                  
target_link_libraries(screen_interface 
							screen_interface_lib
							ros_subscriber_thread_lib
							ros_publisher_thread_lib
							${catkin_LIBRARIES})

