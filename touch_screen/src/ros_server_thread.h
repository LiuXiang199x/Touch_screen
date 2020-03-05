#ifndef ROS_SERVER_THREAD_H
#define ROS_SERVER_THREAD_H


#include <QThread>

//ROS
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/Bool.h"



//TOUCH_SCREEN
#include "touch_screen_msgs/check_connection.h"

class RosServerThread: public QThread{

    Q_OBJECT

public:
    explicit RosServerThread(ros::NodeHandle nh, QObject *parent = 0);

    virtual bool check_connection_callback(touch_screen_msgs::check_connection::Request &req, touch_screen_msgs::check_connection::Response &res){
        res.get_connection = req.set_connection;
        ROS_INFO("Peticion: %d",req.set_connection);
        ROS_INFO("Respuesta: %d",res.get_connection);

        return true;
    }


protected:
    virtual void run ();

private:
     ros::ServiceServer check_connection_server_;


     // ---------------- Callback check_connection service ----------------



};

#endif // ROS_SERVER_THREAD_H
