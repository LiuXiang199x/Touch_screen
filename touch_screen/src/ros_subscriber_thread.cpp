#include "ros_subscriber_thread.h"

RosSubscriberThread::RosSubscriberThread(ros::NodeHandle nh, QObject *parent) :
    QThread(parent){

    //----------------------- <screen control> -----------------------------
    set_window_status_sub_ = nh.subscribe("set_window_status", 1,
                                          &RosSubscriberThread::setWindowStatusCallback, this);

    //----------------------- <menu> -----------------------------
    show_customized_menu_sub_ = nh.subscribe("show_customized_menu", 1,
                                      &RosSubscriberThread::showCustomizedMenuCallback, this);

    //----------------------- <multimedia> -----------------------------

    multimedia_request_sub_ = nh.subscribe("multimedia_request", 1,
                                   &RosSubscriberThread::multimediaRequestCallback, this);

    multimedia_player_sub_ = nh.subscribe("multimedia_player", 1,
                                   &RosSubscriberThread::multimediaPlayerCallback, this);
/*
    multimedia_set_position_sub_ = nh.subscribe("multimedia_set_position", 1,
                                   &RosSubscriberThread::multimediaPositionCallback, this);     //#############
*/

    //------------------ <template> --------------------------

    show_customized_template_sub_ = nh.subscribe("show_customized_template", 1,
                                                 &RosSubscriberThread::showCustomizedTemplateCallback, this);

    //---------------------<texto>--------------------------------

    show_customized_text_sub_ = nh.subscribe("show_customized_text", 1,
                                            &RosSubscriberThread::showCustomizedTextCallback, this);
}

void RosSubscriberThread::run(){
    ros::spin();
}

///////////////////////////////////////////////////////////////////////////////
/// CALLBACKS
///////////////////////////////////////////////////////////////////////////////

//----------------------- <window state> -----------------------------
void RosSubscriberThread::setWindowStatusCallback(const std_msgs::String::ConstPtr& msg){
    ROS_DEBUG("Received msg to make the chest screen: [%s]\n", msg->data.c_str());
    QString show_hide = QString::fromUtf8(msg->data.c_str());
    emit set_window_status(show_hide);
}

//----------------------- <menu> -----------------------------
void RosSubscriberThread::showCustomizedMenuCallback(const touch_screen_msgs::CustomizedMenu::ConstPtr& msg){
    ROS_DEBUG("Received msg to enable/disable\n");
    QString container = QString::fromUtf8(msg->container.c_str());
    QString button_distribution = QString::fromUtf8(msg->button_distribution.c_str());
    emit show_customized_menu(container, msg->enable_input, msg->number_buttons, button_distribution, msg->buttons_config);
}


//----------------------- <multimedia> ---------------------------------------------

void RosSubscriberThread::multimediaRequestCallback(const touch_screen_msgs::MultimediaContent::ConstPtr &msg){
    ROS_DEBUG("Received msg to start a multimedia content of type: [%s]\n", msg->type.c_str());
    QString type = QString::fromUtf8(msg->type.c_str());
    QString url = QString::fromUtf8(msg->url.c_str());
    QString container = QString::fromUtf8(msg->container.c_str());
    emit multimedia_request_sig(container,type, url, msg->msec);
}

void RosSubscriberThread::multimediaPlayerCallback(const touch_screen_msgs::MultimediaState::ConstPtr &msg){
    ROS_DEBUG("Received msg to play a mutimedia content of type: [%s]\n", msg->type.c_str());
    QString type = QString::fromUtf8(msg->type.c_str());
    QString state = QString::fromUtf8(msg->state.c_str());
    QString container = QString::fromUtf8(msg->container.c_str());
    emit multimedia_player_sig(container, type, state);

}
/*
void RosSubscriberThread::multimediaPositionCallback(const std_msgs::Int64::ConstPtr &msg){      //#############

    emit multimedia_set_position_sig(msg->data);

}*/

//------------------- <template> -----------------------------------------------------

void RosSubscriberThread::showCustomizedTemplateCallback(const touch_screen_msgs::CustomizedTemplate::ConstPtr &msg){
    QString num_template = QString::fromUtf8(msg->num_template.c_str());
    emit show_customized_template(num_template, msg->multimedia_config, msg->menu_config, msg->text_config);
}

// ------------------ <text> ---------------------------------------------------------

void RosSubscriberThread::showCustomizedTextCallback(const touch_screen_msgs::CustomizedText::ConstPtr &msg){
    QString customized_text = QString::fromUtf8(msg->customized_text.c_str());
    QString font_text = QString::fromUtf8(msg->font_text.c_str());
    QString container = QString::fromUtf8(msg->container.c_str());
    emit show_customized_text(container,customized_text, msg->size_text, font_text);
}





