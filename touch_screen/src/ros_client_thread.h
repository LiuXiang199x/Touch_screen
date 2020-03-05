#ifndef ROS_CLIENT_THREAD_H
#define ROS_CLIENT_THREAD_H

#include <QThread>


//ROS
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/Bool.h"



//TOUCH_SCREEN
#include "touch_screen_msgs/check_connection.h"



class RosClientThread: public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool error_connection READ error_connection NOTIFY error_connectionChanged)


public:
    explicit RosClientThread(ros::NodeHandle nh, QObject *parent = 0);


    bool error_connection() const {
        return _error_connection;
    }

    void setError_connection(const int &new_error_connection){
        if (new_error_connection != _error_connection) {
            _error_connection = new_error_connection;
        }
        Q_EMIT(error_connectionChanged());
    }

signals:
    void error_connectionChanged();
    void error_connection_sig(bool error_connection);


public slots:
    void on_client_request();

private:
    ros::ServiceClient _check_connection_client_;

    bool _error_connection;
};

#endif // ROS_CLIENT_THREAD_H
