#ifndef ROS_PUBLISHER_THREAD
#define ROS_PUBLISHER_THREAD

#include <QThread>
#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/Bool.h"
#include "std_msgs/Int64.h"

#include "touch_screen_msgs/MultimediaState.h"

#include "touch_screen_msgs/TouchPosition.h"

class RosPublisherThread : public QObject{
    Q_OBJECT

public:
    explicit RosPublisherThread(ros::NodeHandle nh, QObject *parent = 0);

public slots:
    void on_audio_played();
    void on_audio_paused();
    void on_audio_stopped();
    void on_video_played();
    void on_video_paused();
    void on_video_stopped();

    void on_image_loaded(); //#########
    void on_video_end();    //#########
    void on_audio_end();    //#########
    void on_video_detailed_status(); // ##########

    void on_window_status_changed(QString new_status);
    void on_screen_touched();
    void on_inicializado();

    void on_multimedia_minute(int data); //#######

    void on_multimedia_detailed_state(QString state); //#######


private:

    void multimediaPublisher(std::string type, std::string state);

    ros::Publisher _multimedia_status_pub_, _window_status_pub_, _screen_touched_pub_, _inicializado_pub_, _multimedia_minute_pub_, _multimedia_detailed_state_pub_; //###########

};



#endif // ROS_PUBLISHER_THREAD

