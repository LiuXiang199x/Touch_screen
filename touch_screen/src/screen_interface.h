#ifndef SCREEN_INTERFACE_H
#define SCREEN_INTERFACE_H

//ROS
#include "ros/ros.h"
#include "std_msgs/String.h"

//Qt
#include <QObject>
#include <QDebug>
#include <QList>

//QML
#include <QQmlComponent>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickView>
#include <QQmlContext>
#include <QQuickWindow>



#ifdef Q_OS_ANDROID
#else
  // #include <QtWebEngine/qtwebengineglobal.h> //Include the QtWebEngine library only for Desktop Devices

#endif

#include <QStyleHints>
#include <QScreen>

//Msgs
#include "touch_screen_msgs/ScreenButton.h"


#include <src/MultimediaProperties.h>
#include <src/MenuProperties.h>
#include <src/templateProperties.h>
#include "ros_publisher_thread.h"
#include "ros_client_thread.h"
#include <src/textproperties.h>


class ScreenInterface : public QObject
{
    Q_OBJECT

public:
    explicit ScreenInterface(ros::NodeHandle nh, QString multimedia_path, QString default_window_status);
    ~ScreenInterface();

public slots:
    //----------------------- <menu> -----------------------------
    void on_show_customized_menu_received(QString container,
                                            bool enable_input,
                                            int num_buttons,
                                            QString button_distribution,
                                            std::vector<touch_screen_msgs::ScreenButton> buttons_config);

    //----------------------- <screen control> -----------------------------
    void on_set_window_status_received(QString show_hide_display);


    //----------------------- <multimedia> -----------------------------
    void on_multimedia_request_received(QString container, QString type, QString multimedia_name, int msec);
    void on_multimedia_player_received(QString, QString type, QString multimedia_state);

   // void on_multimedia_set_position_received(int position); //##############

    //----------------------- <template> ----------------------------------
    void on_show_customized_template_received(QString num_template,std::vector<touch_screen_msgs::MultimediaContent> multimedia_config,std::vector<touch_screen_msgs::CustomizedMenu> menu_config, std::vector<touch_screen_msgs::CustomizedText> text_config);
    void on_multimedia_template_received(QString container, QString type, QString multimedia_name, int msec);       //### Cambiado 01/04/19
    void on_text_template_received(QString container, QString customized_text, int size_text, QString font_text);

    //----------------------- <text> -------------------------------------

    void on_show_customized_text_receiver(QString container, QString customized_text, int size_text, QString font_text);

    //----------------------- <check connection> -------------------------
    void on_error_connection_received(bool error_connection);



private:

    QQmlApplicationEngine engine;
    QQmlComponent component;
    QString current_image_name_, images_folder_, icons_folder_;



    ros::NodeHandle nh_;
    std::string buttons_data_[5];
    int current_num_buttons_;

    MultimediaProperties my_multimedia_properties;
    MenuProperties *my_menu_properties;
    RosPublisherThread* msg_publisher;
    RosClientThread* msg_client;
    RosClientThread* my_client_thread;
    TemplateProperties *my_template_properties;
    TextProperties my_text_properties;

};

#endif // SCREEN_INTERFACE_H
