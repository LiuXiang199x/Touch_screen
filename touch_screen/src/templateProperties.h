#ifndef TEMPLATEPROPERTIES_H
#define TEMPLATEPROPERTIES_H

#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickView>
#include <QObject>


#include "ros/ros.h"
#include "std_msgs/String.h"

#include "touch_screen_msgs/CustomizedMenu.h"
#include "touch_screen_msgs/ScreenButton.h"
#include "touch_screen_msgs/MultimediaContent.h"
#include "touch_screen_msgs/CustomizedText.h"
#include "touch_screen_msgs/CustomizedTemplate.h"

#include "MenuButton.h"
#include "ros_subscriber_thread.h"

class TemplateProperties : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString num_template READ num_template NOTIFY num_templateChanged)

public:
    TemplateProperties(QObject *parent=0):QObject(parent){}



    QString num_template() const{
        return _num_template;
    }

    void setTemplate(const QString &new_template){
        if(new_template != _num_template){
            _num_template = new_template;
        }
        Q_EMIT(num_templateChanged());
    }

    //Methods
    void configMultimedia(touch_screen_msgs::MultimediaContent multimedia_config){
        QString container = multimedia_config.container.c_str();
        QString type = multimedia_config.type.c_str();
        QString url = multimedia_config.url.c_str();
        int msec = multimedia_config.msec;                      //#### Cambiado.1/04/19
      //  emit (multimedia_template_sig(container, type, url));
        //qDebug()<<"Container multimedia en templateProperties: "<<container<<endl;
         //qDebug()<<"tipo multimedia en templateProperties: "<<type<<endl;
         // qDebug()<<"url multimedia en templatePropeprties: "<<url<<endl;
            emit (multimedia_template_sig(container, type, url, msec));     //#### Cambiado.1/04/19
    }

    void configText(touch_screen_msgs::CustomizedText text_config){
        QString container = text_config.container.c_str();
        QString customized_text = text_config.customized_text.c_str();
        int size_text = text_config.size_text;
        QString font_text = text_config.font_text.c_str();
        emit (text_template_sig(container, customized_text, size_text, font_text));
    }



signals:
    void num_templateChanged();
    void multimedia_template_sig(QString container, QString type, QString url, int msec);      //#### Cambiado.1/04/19
    void text_template_sig(QString container, QString customized_text, int size_text, QString font_text);


private:
    QString _num_template;
};



#endif // TEMPLATEPROPERTIES_H
