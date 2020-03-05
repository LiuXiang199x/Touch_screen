#ifndef ROS_SUBSCRIBER_THREAD_H
#define ROS_SUBSCRIBER_THREAD_H

#include <QThread>
#include <QDebug>
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/Bool.h"
#include "touch_screen_msgs/ScreenButton.h"
#include "touch_screen_msgs/CustomizedMenu.h"

#include "touch_screen_msgs/MultimediaContent.h"
#include "touch_screen_msgs/MultimediaState.h"

#include "touch_screen_msgs/CustomizedTemplate.h"

#include "touch_screen_msgs/CustomizedText.h"

#include "std_msgs/Int64.h" //###########



class RosSubscriberThread : public QThread{
    Q_OBJECT

public:
    explicit RosSubscriberThread(ros::NodeHandle nh, QObject *parent = 0);

signals:
    void set_window_status(QString show_hide);
    void show_customized_menu(QString container, bool enable_input, int number_buttons, QString button_distribution, std::vector<touch_screen_msgs::ScreenButton> buttons_config);
    void multimedia_request_sig(QString container, QString type, QString url, int msec); //#########
    void multimedia_player_sig(QString container, QString type, QString state);
    void show_customized_template(QString num_template, std::vector<touch_screen_msgs::MultimediaContent> multimedia_config, std::vector<touch_screen_msgs::CustomizedMenu> menu_config, std::vector<touch_screen_msgs::CustomizedText> text_config);
    void show_customized_text(QString container, QString customized_text, int size_text, QString font_text);

    /*void multimedia_set_position_sig(int position); //######## */

protected:
    virtual void run ();

private:
    ros::Subscriber set_window_status_sub_, show_customized_menu_sub_, show_customized_template_sub_, show_customized_text_sub_;

    //----------------------- <screen control> -----------------------------
    void setWindowStatusCallback(const std_msgs::String::ConstPtr& msg);

    //----------------------- <menu> -----------------------------
    void showCustomizedMenuCallback(const touch_screen_msgs::CustomizedMenu::ConstPtr& msg);

    //----------------------- <multimedia (image + audio + video + web)> -----------------------------
    ros::Subscriber multimedia_request_sub_, multimedia_player_sub_;
    //ros::Subscriber multimedia_request_sub_, multimedia_player_sub_, multimedia_set_position_sub_;  //###########*/
    void multimediaRequestCallback(const touch_screen_msgs::MultimediaContent::ConstPtr& msg);
    void multimediaPlayerCallback(const touch_screen_msgs::MultimediaState::ConstPtr& msg);

    /*void multimediaPositionCallback(const std_msgs::Int64::ConstPtr& msg); //###########*/


    //-------------------- <template> -------------------------------
    void showCustomizedTemplateCallback(const touch_screen_msgs::CustomizedTemplate::ConstPtr& msg);

    //------------------------- <text> -----------------------------
    void showCustomizedTextCallback(const touch_screen_msgs::CustomizedText::ConstPtr& msg);

};
#endif // ROS_SUBSCRIBER_THREAD_H
