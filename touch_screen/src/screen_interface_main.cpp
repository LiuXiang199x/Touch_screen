//Qt
#include <QGuiApplication>
#include <QObject>
#include <QPalette>
#include <QProcessEnvironment>
#include <QSettings>
#include <QList>
#include <tinyxml.h>
#include "MenuButton.h"
#include "MenuProperties.h"

//ROS
#include "ros/package.h"

//Screen
#include "screen_interface.h"
#include "ros_subscriber_thread.h"
#include "ros_server_thread.h"
#include "templateProperties.h"
#include "ros_client_thread.h"

#define XML_PATH "/sdcard/"
#define XML_FILE "ros_config.xml"
#define concat(first, second) first second

////////////////////////////////////////////////////////////////////////////////
///MAIN
////////////////////////////////////////////////////////////////////////////////

int main(int argc, char **argv){

   #ifdef Q_OS_ANDROID //Init arguments for Android Devices
        int android_argc = 4;
        std::string ros_master_uri("__master:=");
        std::string ros_ip("__ip:=");
        std::string ros_ns("__ns:=");

        TiXmlDocument doc( concat(XML_PATH, XML_FILE) );
        if(doc.LoadFile()){
            TiXmlElement* root = doc.FirstChildElement();

            for(TiXmlElement* elem = root->FirstChildElement(); elem != NULL; elem = elem->NextSiblingElement()){
                ros_master_uri.append(elem->Attribute("ros_master_uri"));
                ros_ip.append(elem->Attribute("ros_ip"));
                ros_ns.append(elem->Attribute("ros_ns"));
            }




        }else{
            QGuiApplication app(argc, argv);
            QQmlApplicationEngine engine(QUrl(QStringLiteral("qrc:/error.qml")));
            return app.exec();
        }

        char * andr_header = (char*) "nothing_important";

        char * android_argv[] = {andr_header , (char*)ros_master_uri.c_str(), (char*)ros_ip.c_str(), (char*)ros_ns.c_str()}; //Master IP & Android Device IP & robot namespace

        ros::init(android_argc, android_argv, "screen_ui");

        ros::NodeHandle nh_public;
        ros::NodeHandle nh_private("~");

        std::string multimedia_path = "file:///sdcard/multimedia/"; //ANDROID path

    #else //Init arguments for Desktop Devices
        ros::init(argc, argv, "screen_ui");

        ros::NodeHandle nh_public;
        ros::NodeHandle nh_private("~");

        std::string multimedia_path = "";
        nh_private.param("multimedia_path", multimedia_path, multimedia_path);
        multimedia_path = "file:///" + multimedia_path + "/";


    #endif

    //If we want the app to be full screen or not
    std::string window_state = "";
    nh_private.param("window_state", window_state, window_state);
    
    ///Creating Qt application
    QGuiApplication app(argc, argv);






    const char* boton="BOTON";

    qmlRegisterType <MenuButton> (boton,1,0,"MenuButton");
    qmlRegisterType <MenuProperties> (boton,1,0,"MenuProperties");


    //The QWidget for the screen of the robot (chest screen or tablet) where the images are going to be displayed
    ScreenInterface* robot_screen = new ScreenInterface(nh_public, QString::fromUtf8(multimedia_path.c_str()), QString::fromUtf8(window_state.c_str()));

    //A second thread is necessary for ros communication mechanisms since the thread
    //of the widget is blocked and the communication must be performed via "signals"
    //and "slots"

    RosSubscriberThread* msg_receiver = new RosSubscriberThread(nh_public);
    RosServerThread* my_server_thread = new RosServerThread(nh_public);
 //   TemplateProperties* msg_template = new TemplateProperties();

    //Connection between ros subscriber Signals and screen interface Slots
    QObject::connect(msg_receiver, SIGNAL(set_window_status(QString)),
                     robot_screen, SLOT(on_set_window_status_received(QString)));

    qRegisterMetaType<touch_screen_msgs::ScreenButton>("touch_screen_msgs::ScreenButton");
    qRegisterMetaType<std::vector<touch_screen_msgs::ScreenButton> >("std::vector<touch_screen_msgs::ScreenButton>");
    qRegisterMetaType<touch_screen_msgs::MultimediaContent>("touch_screen_msgs::MultimediaContent");
    qRegisterMetaType<std::vector<touch_screen_msgs::MultimediaContent> >("std::vector<touch_screen_msgs::MultimediaContent>");
    qRegisterMetaType<touch_screen_msgs::CustomizedMenu>("touch_screen_msgs::CustomizedMenu");
    qRegisterMetaType<std::vector<touch_screen_msgs::CustomizedMenu> >("std::vector<touch_screen_msgs::CustomizedMenu>");
    qRegisterMetaType<touch_screen_msgs::CustomizedText>("touch_screen_msgs::CustomizedText");
    qRegisterMetaType<std::vector<touch_screen_msgs::CustomizedText> >("std::vector<touch_screen_msgs::CustomizedText>");




    QObject::connect(msg_receiver, SIGNAL(show_customized_menu(QString, bool, int, QString, std::vector<touch_screen_msgs::ScreenButton>)),
                     robot_screen, SLOT(on_show_customized_menu_received(QString, bool, int, QString, std::vector<touch_screen_msgs::ScreenButton>)));

    QObject::connect(msg_receiver, SIGNAL(multimedia_request_sig(QString, QString, QString, int)),
                     robot_screen, SLOT(on_multimedia_request_received(QString, QString, QString, int))); //#####

    QObject::connect(msg_receiver, SIGNAL(multimedia_player_sig(QString, QString, QString)),
                     robot_screen, SLOT(on_multimedia_player_received(QString, QString, QString)));

    QObject::connect(msg_receiver, SIGNAL(show_customized_template(QString,std::vector<touch_screen_msgs::MultimediaContent>,std::vector<touch_screen_msgs::CustomizedMenu>,std::vector<touch_screen_msgs::CustomizedText>)),
                     robot_screen, SLOT(on_show_customized_template_received(QString,std::vector<touch_screen_msgs::MultimediaContent>,std::vector<touch_screen_msgs::CustomizedMenu>,std::vector<touch_screen_msgs::CustomizedText>)));

    QObject::connect(msg_receiver, SIGNAL(show_customized_text(QString, QString, int, QString)),
                     robot_screen, SLOT(on_show_customized_text_receiver(QString, QString, int, QString)));


   /* QObject::connect(msg_receiver, SIGNAL(multimedia_set_position_sig(int)),
                     robot_screen, SLOT(on_multimedia_set_position_received(int))); //########## */





   msg_receiver->start();
   my_server_thread->start();



    return app.exec();
}
