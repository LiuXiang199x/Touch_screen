#ifndef MENUBUTTON_H
#define MENUBUTTON_H

#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickView>
#include <QList>

class MenuButton : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString type READ type NOTIFY typeChanged)
    Q_PROPERTY(QString text READ text NOTIFY textChanged)
    Q_PROPERTY(QString icon READ icon NOTIFY iconChanged)


public:

    MenuButton (){
        _type = "default_type";
        _text = "default_text";
        _icon = "../menu/default.png";

        _msg_value = "";
    }

    ///Type
    QString type() const {
        return _type;
    }

    void setType(const QString &new_type){
        if (new_type != _type) {
            _type = new_type;
        }
        Q_EMIT(typeChanged());
    }

    ///Text
    QString text() const {
        return _text;
    }

    void setText(const QString &new_text){
        if (new_text != _text) {
            _text = new_text;
        }
        Q_EMIT(textChanged());
    }

    ///Icon
    QString icon() const {
        return _icon;
    }

    void setIcon(const QString &new_icon){
        if (new_icon != _icon) {
            _icon = new_icon;
        }
        Q_EMIT(iconChanged());
    }

    ///msg Value
   std::string  getMsgValue() const {
        return _msg_value;
    }

    void setMsgValue(const std::string &new_msg_value){
        if (new_msg_value != _msg_value) {
            _msg_value = new_msg_value;
        }

    }

signals:
    void typeChanged();
    void textChanged();
    void iconChanged();


private:

    QString _type;
    QString _text;
    QString _icon;

    std::string _msg_value;

};

#endif // MENUBUTTON_H
