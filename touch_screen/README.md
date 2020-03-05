# touch_screen #
------
ROS package for the touch_screen of the Social Robot Group.

## OVERVIEW ##
------
*touch_screen* is a package that lets the user to interact with the tablet. The user can configure what elements are displayed on the tablet (images, audios, videos, menus...) and in what distribution they are displayed using templates. *touch_screen* will also send the answers that the user enters when interacting with the interface.
## HARDWARE REQUERIMENTS ##
------
**To compile Android application**: Ubuntu 14.04 64 bits with ROS Indigo.

**To run Desktop application**: Ubuntu 14.04 (32/64 bits) with ROS Indigo.

**To run Android application**: Device with at least Android 5.1.

## INSTALLATION AND CONFIGURATION ##
------
### Installig Qt in Ubuntu 14.04 64 bits ###
1. Download and configure Qt+android.
    1. Execute script install_qt_x64.bash (Download Qt5.6.2 + android and install).
2. Execute scriptt install_android_environment.bash.
    1. Download android sdk 5.1 (API 22).
3. Open Qtcreator-Tools-Options-Android.
4. Add path JDK, SDK, NDK and ant.

### Compile Android apk ###
1. Compile *touch_screen_msgs* project with catkin_make.
2. Open qtcreator with terminal (Qt5.6.2/Tools/QtCreator/bin).
3. Built project for Android armeabi-v7a.
4. Open *wifi-file-transfer* in tablet.
5. Open *wifi-file-transfer* url in network browser.
6. Upload apk file and install it.
7. Upload *ros_config.xml* file in tablet. This file is in the resources folder of the package.

### Installig Qt in Ubuntu 14.04 32 bits ###

1. Execute script install_qt_x86.bash.

**With Ubuntu 14.04 32bits you can only compile the desktop application**


## RUN ##
------
### Run Desktop application ###
1. Compile project with catkin_make
2. Launch `roslaunch touch_screen touch_screen.launch robot:=alz window_state:=window` to test it works correctly

### Run Android application ###
1. Configure network conexion in PC with static IP:
    ```    
    Adress: 192.168.1.3X
   
    Netmask: 255.255.255.0
    
    Gateway: 192.168.1.1
    
    DNS Server: 8.8.8.8, 163.117.131.31
    ```

2. Add in .bashrc (*ROS_HOSTNAME* = ip PC, *ROS_IP*= ip tablet) in PC:
    ```
    export ROS_HOSTNAME=192.168.1.3X
    
    export ROS_IP=192.168.1.8X
   
    export ROS_MASTER_URI=http://192.168.1.3X:11311/
    ```

3. Modify *ros_config.xml* file (in tablet sdcard). Add correct ROS_HOSTNAME, ROS_IP and namespace. **This parameters must match those entered in the .bashrc file.**

4. Launch roscore. If the communication between the PC and the tablet works correctly in the interface, the logo of the roboticslab should appear.

## ROS API ##
------
### Nodes ###
#### screen_ui ####

`screen_ui` listens the touch_screen topics and publishes the outputs to the application. This is used to update the appearance of the interface and send the response messages of the application both by the user and the states of the interface.

##### Published Topics #####

`screen_touched`(*touch_screen_msgs/TouchPosition*): topic for send the coordinates when the screen is touched

`menu_response`(*std_msgs/String*): topic for send the message when the button is touched

`multimedia_status`(*touch_screen_msgs/MultimediaState*): topic for send the multimedia status

`window_status`(*std_msgs/String*): topic for send the window status

##### Subscribed Topics #####

`set_window_status`(*std_msgs/String*): topic for set window status

`multimedia_request`(*touch_screen_msgs/MultimediaContent*): topic for show multimedia content

`multimedia_player`(*touch_screen_msgs/MultimediaState*): topic for multimedia player control

`show_customized_menu`(*touch_screen_msgs/CustomizedMenu*): topic for show customized input menu

`show_customized_template`(*touch_screen_msgs/CustomizedTemplate*): topic for show customized template

`show_customized_text`(*touch_screen_msgs/CustomizedText*): topic for show customized text

#### Services ####
`check_connection_service`(*touch_screen_msgs/CheckConnection*): service to check the connection between the robot and the tablet once every second

## LICENSE ##
------
The license of the packages is custom LASR-UC3M (Licencia Académica Social Robotics Lab - UC3M), an open, non-commercial license which enables you to download, modify and distribute the code as long as you distribute the sources.  

## ACKNOWLEDGEMENTS ##
------
![RoboticsLab](http://ieee.uc3m.es/images/thumb/b/b6/Roboticslab_text_new.jpg/128px-Roboticslab_text_new.jpg)
![UC3M](http://ieee.uc3m.es/images/thumb/6/6b/Logo_uc3m_letras.png/256px-Logo_uc3m_letras.png)
