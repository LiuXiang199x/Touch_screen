#ifndef TEXTPROPERTIES_H
#define TEXTPROPERTIES_H

#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickView>

#include "ros/ros.h"
#include "std_msgs/String.h"

#include "touch_screen_msgs/CustomizedText.h"

class TextProperties : public QObject
{
    Q_OBJECT
    ///Text properties
    Q_PROPERTY(QString container READ container NOTIFY containerChanged)
    Q_PROPERTY(QString customized_text READ customized_text WRITE setCustomized_text NOTIFY customized_textChanged)
    Q_PROPERTY(QString font_text READ font_text NOTIFY font_textChanged)
    Q_PROPERTY(int size_text READ size_text NOTIFY size_textChanged)


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
    QString customized_text() const {
        return _customized_text;
    }

    void setCustomized_text(const QString &new_customized_text){
        if (new_customized_text != _customized_text) {
            _customized_text = new_customized_text;
        }
        Q_EMIT(customized_textChanged());
    }

    QString font_text() const {
        return _font_text;
    }

    void setFont_text(const QString &new_font_text){
        if (new_font_text != _font_text) {
            _font_text = new_font_text;
        }
        Q_EMIT(font_textChanged());
    }

    int size_text() const {
        return _size_text;
    }

    void setSize_text(const int &new_size_text){
        if (new_size_text != _size_text) {
            _size_text = new_size_text;
        }
        Q_EMIT(size_textChanged());
    }

signals:
    void customized_textChanged();
    void font_textChanged();
    void size_textChanged();
    void containerChanged();


private:
    QString _customized_text;
    QString _font_text;
    QString _container;
    int _size_text;

};


#endif // TEXTPROPERTIES_H
