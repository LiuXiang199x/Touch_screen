#ifndef MULTIMEDIAPROPERTIES_H
#define MULTIMEDIAPROPERTIES_H

#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickView>

#include "ros/ros.h"
#include "std_msgs/String.h"

#include "touch_screen_msgs/MultimediaState.h"

class MultimediaProperties : public QObject
{
    Q_OBJECT
    ///Multimedia properties
    Q_PROPERTY(QString container READ container NOTIFY containerChanged)
    Q_PROPERTY(QString multimedia_path READ multimedia_path NOTIFY multimedia_pathChanged)
    Q_PROPERTY(QString multimedia_type READ multimedia_type NOTIFY multimedia_typeChanged)
    Q_PROPERTY(QString multimedia_filename READ multimedia_filename NOTIFY multimedia_filenameChanged)
    Q_PROPERTY(QString multimedia_state READ multimedia_state NOTIFY multimedia_stateChanged)
    Q_PROPERTY(bool send_player READ send_player NOTIFY send_playerChanged)

    Q_PROPERTY(int multimedia_position READ multimedia_position NOTIFY multimedia_positionChanged)  //########

    //Q_PROPERTY(int multimedia_length READ multimedia_length NOTIFY multimedia_lengthChanged)  //########

    ///Window State
    Q_PROPERTY(QString window_state READ window_state NOTIFY window_stateChanged)

public:
    ///Multimedia Properties
    QString container() const {
        return _container;
    }

    void setContainer(const QString &new_container){
        if (new_container != _container) {
            _container = new_container;
        }
        Q_EMIT(containerChanged());
    }
    QString multimedia_path() const {
        return _multimedia_path;
    }

    void setMultimedia_path(const QString &new_multimedia_path){
        if (new_multimedia_path != _multimedia_path) {
            _multimedia_path = new_multimedia_path;
        }
        Q_EMIT(multimedia_pathChanged());
    }

    QString multimedia_type() const {
        return _multimedia_type;
    }

    void setMultimedia_type(const QString &new_multimedia_type){
        if (new_multimedia_type != _multimedia_type) {
            _multimedia_type = new_multimedia_type;
        }
        Q_EMIT(multimedia_typeChanged());
    }

    QString multimedia_filename() const {
        return _multimedia_filename;
    }

    void setMultimedia_filename(const QString &new_multimedia_filename){
        if (new_multimedia_filename != _multimedia_filename) {
            _multimedia_filename = new_multimedia_filename;
        }
        Q_EMIT(multimedia_filenameChanged());
    }

    QString multimedia_state() const {
        return _multimedia_state;
    }

    void setMultimedia_state(const QString &new_multimedia_state){
        if (new_multimedia_state != _multimedia_state) {
            _multimedia_state = new_multimedia_state;
        }
        Q_EMIT(multimedia_stateChanged());
    }

    bool send_player() const {
        return _send_player;
    }

    void setSend_player(const int &new_send_player){
        if (new_send_player != _send_player) {
            _send_player = new_send_player;
        }
        qDebug()<<"Valor de send player:" << _send_player;
        Q_EMIT(send_playerChanged());
    }


    int multimedia_position() const {      //#########
        return _multimedia_position;
    }

    void setMultimedia_position(const int &new_multimedia_position){        //#########
        if (new_multimedia_position != _multimedia_position) {
            _multimedia_position = new_multimedia_position;
        }
        qDebug()<<"Valor de multimedia position:" << _multimedia_position;
        Q_EMIT(multimedia_positionChanged());
    }


    //int multimedia_length() const {      //#########
        //return _multimedia_length;
    //}

   // void setMultimedia_length(const int &new_multimedia_length){        //#########
   //     if (new_multimedia_length != _multimedia_length) {
   //         _multimedia_length = new_multimedia_length;
   //     }
   //     qDebug()<<"Valor de multimedia length:" << _multimedia_length;
   //     Q_EMIT(multimedia_lengthChanged());
   // }



    ///Window State
    QString window_state() const {
        return _window_state;
    }

    void setWindow_state(const QString &new_window_state){
        if (new_window_state != _window_state) {
            _window_state = new_window_state;
        }
        Q_EMIT(window_stateChanged());
    }

signals:
    void multimedia_pathChanged();
    void multimedia_typeChanged();
    void multimedia_filenameChanged();
    void multimedia_stateChanged();
    void containerChanged();
    void send_playerChanged();

    void multimedia_positionChanged();      //######

    //void multimedia_lengthChanged();      //######

    void window_stateChanged();


public slots:

    // se añade este slot a fin de poder mostrar mensajes desde QML y poder debuggear el programa.
    void on_mostrar_string(const QString &mensaje){
        qDebug()<<"llamada desde qml"<<mensaje;

    }

private:
    QString _multimedia_path;
    QString _multimedia_type;
    QString _multimedia_filename;
    QString _multimedia_state;
    QString _container;
    bool _send_player;

    int _multimedia_position;   //######

   // int _multimedia_length;     //#####

    QString _window_state;

};

#endif // MULTIMEDIAPROPERTIES_H
