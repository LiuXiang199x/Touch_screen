#include "ros_client_thread.h"


RosClientThread::RosClientThread(ros::NodeHandle nh, QObject *parent){
    _check_connection_client_ = nh.serviceClient<touch_screen_msgs::check_connection>("check_connection_service");
    ROS_INFO_STREAM("Cliente registrado en touch_screen");

}

void RosClientThread::on_client_request(){

    touch_screen_msgs::check_connection srv;
    srv.request.set_connection = true;

    if(_check_connection_client_.call(srv)){
        ROS_INFO_STREAM("Call service");
    }else{
        emit(error_connection_sig(true));
    }

}


