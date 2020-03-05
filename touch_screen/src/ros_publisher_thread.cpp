
#include "ros_publisher_thread.h"
#include <QDebug>

RosPublisherThread::RosPublisherThread(ros::NodeHandle nh, QObject *parent){

    _multimedia_status_pub_ = nh.advertise<touch_screen_msgs::MultimediaState>("multimedia_status", 1);
    _window_status_pub_ = nh.advertise<std_msgs::String>("window_status", 1);
    _screen_touched_pub_ = nh.advertise<std_msgs::Bool>("screen_touched", 1);
    _inicializado_pub_=nh.advertise<std_msgs::Bool>("recibi_touch_screen", 1);
    _multimedia_minute_pub_ = nh.advertise<std_msgs::Int64>("multimedia_position", 1);         //#########
    _multimedia_detailed_state_pub_ = nh.advertise<std_msgs::String>("multimedia_detailed_state", 1);   //#########
    _screen_touched_pub_ = nh.advertise<touch_screen_msgs::TouchPosition>("screen_touched", 1); //#######

}

void RosPublisherThread::on_audio_played(){

    multimediaPublisher("audio", "play");

}

void RosPublisherThread::on_audio_paused(){

    multimediaPublisher("audio", "pause");

}

void RosPublisherThread::on_audio_stopped(){

    multimediaPublisher("audio", "stop");

}

void RosPublisherThread::on_video_played(){

    multimediaPublisher("video", "play");

}

void RosPublisherThread::on_video_paused(){

    multimediaPublisher("video", "pause");

}

void RosPublisherThread::on_video_stopped(){

    multimediaPublisher("video", "stop");

}


void RosPublisherThread::on_image_loaded(){        //########

    multimediaPublisher("image", "play");

}

void RosPublisherThread::on_video_end(){        //########

    multimediaPublisher("video", "end");

}

void RosPublisherThread::on_audio_end(){        //########

    multimediaPublisher("audio", "end");

}


void RosPublisherThread::on_video_detailed_status(){    //########

    on_multimedia_detailed_state("holaaaaaaaaaa");

}


void RosPublisherThread::multimediaPublisher(std::string type, std::string state){

    touch_screen_msgs::MultimediaState new_state;

    new_state.type = type;
    new_state.state = state;

    _multimedia_status_pub_.publish(new_state);

}

void RosPublisherThread::on_window_status_changed(QString new_status){

    std_msgs::String msg;
    msg.data = new_status.toUtf8().constData();

    _window_status_pub_.publish(msg);

}

void RosPublisherThread::on_screen_touched(){

    std_msgs::Bool msg;
    msg.data = true;

    _screen_touched_pub_.publish(msg);

}

void RosPublisherThread::on_inicializado(){

    std_msgs::Bool msg;
    msg.data = true;
    qDebug()<< "lanzamos mensaje de inicializacion";
    _inicializado_pub_.publish(msg);

}

void RosPublisherThread::on_multimedia_minute(int data){ //#############
    std_msgs::Int64 min;
    min.data = data;
    _multimedia_minute_pub_.publish(min);

}




void RosPublisherThread::on_multimedia_detailed_state(QString state){  //############

    std_msgs::String msg;
    std::string msg_aux;
    msg_aux = state.toUtf8().constData();

    if (msg_aux == "1"){
        msg.data = "NoMedia";
    }
    else if (msg_aux == "2"){
        msg.data = "Loading";
    }
    else if (msg_aux == "3"){
        msg.data = "Buffering";
    }
    else if (msg_aux == "4"){
        msg.data = "Stalled";
    }
    else if (msg_aux == "5"){
        msg.data = "Buffered";
    }
    else if (msg_aux == "6"){
        msg.data = "EndOfMedia";
    }
    else if (msg_aux == "7"){
        msg.data = "InvalidMedia";
    }
    else if (msg_aux == "8"){
        msg.data = "UnknownStatus";
    }

    _multimedia_detailed_state_pub_.publish(msg);

    /*
    std_msgs::String state_aux;
    state_aux.data = state;
    _multimedia_state2_pub_.publish(state_aux);*/

    /*
    std_msgs::Int64 prueba;
    prueba.data = state;
    _multimedia_state2_pub_.publish(prueba);*/
}

