#include "ros_server_thread.h"

RosServerThread::RosServerThread(ros::NodeHandle nh, QObject *parent):
    QThread(parent){

    check_connection_server_ = nh.advertiseService("check_connection_service", &RosServerThread::check_connection_callback, this);


    ROS_INFO_STREAM("Servidor registrado en touch_screen");

}

void RosServerThread::run(){
    ros::spin();
}


