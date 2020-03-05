#ifndef MENUPROPERTIES_H
#define MENUPROPERTIES_H

#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickView>
#include <QVariantList>
#include <QString>

#include "ros/ros.h"
#include "std_msgs/String.h"

#include "touch_screen_msgs/CustomizedMenu.h"
#include "touch_screen_msgs/ScreenButton.h"

#include "MenuButton.h"


class MenuProperties : public QObject
{



    Q_OBJECT
    Q_PROPERTY(int num_buttons READ num_buttons NOTIFY num_buttonsChanged)
    Q_PROPERTY(bool menu_status READ menu_status NOTIFY menu_statusChanged)
    Q_PROPERTY(QString button_distribution READ button_distribution NOTIFY button_distributionChanged)
    Q_PROPERTY(QString container READ container NOTIFY containerChanged)
// listas que accederemos desde QML para saber el indice del boton pulsado y contenedor al que esta aasignado
// creamos una lista para cada contenedor

    Q_PROPERTY(QVariantList  objButtonList READ objButtonList  NOTIFY objButtonListChanged)
    Q_PROPERTY(QVariantList  objButtonListBackground READ objButtonListBackground  NOTIFY objButtonListBackgroundChanged)
    Q_PROPERTY(QVariantList  objButtonListCenter READ objButtonListCenter  NOTIFY objButtonListCenterChanged)
    Q_PROPERTY(QVariantList  objButtonListUpper READ objButtonListUpper  NOTIFY objButtonListUpperChanged)
    Q_PROPERTY(QVariantList  objButtonListLower READ objButtonListLower  NOTIFY objButtonListLowerChanged)
    Q_PROPERTY(QVariantList  objButtonListLowerRight READ objButtonListLowerRight  NOTIFY objButtonListLowerRightChanged)
    Q_PROPERTY(QVariantList  objButtonListLowerLeft READ objButtonListLowerLeft  NOTIFY objButtonListLowerLeftChanged)
    Q_PROPERTY(QVariantList  objButtonListModel READ objButtonListModel  NOTIFY objButtonListModelChanged)
    Q_PROPERTY(QVariantList  objButtonListCenterRight READ objButtonListCenterRight  NOTIFY objButtonListCenterRightChanged)
    Q_PROPERTY(QVariantList  objButtonListCenterLeft READ objButtonListCenterLeft  NOTIFY objButtonListCenterLeftChanged)
    Q_PROPERTY(QVariantList  objButtonListCenterUpper READ objButtonListCenterUpper  NOTIFY objButtonListCenterUpperChanged)
    Q_PROPERTY(QVariantList  objButtonListCenterLower READ objButtonListCenterLower  NOTIFY objButtonListCenterLowerChanged)
    Q_PROPERTY(QVariantList  objButtonListCenterHoriz1 READ objButtonListCenterHoriz1  NOTIFY objButtonListCenterHoriz1Changed)
    Q_PROPERTY(QVariantList  objButtonListCenterHoriz2 READ objButtonListCenterHoriz2  NOTIFY objButtonListCenterHoriz2Changed)
    Q_PROPERTY(QVariantList  objButtonListCenterHoriz3 READ objButtonListCenterHoriz3  NOTIFY objButtonListCenterHoriz3Changed)


public:

    explicit MenuProperties(ros::NodeHandle nh, QObject *parent = 0){
        _nh = nh;
        _menu_status = false;

        _menu_pub = _nh.advertise<std_msgs::String>("menu_response", 1);


    }

    MenuProperties(){

    }

    ~ MenuProperties(){}

// funciones propias de las listas creadas y definidas para poder utilizarlas desde QML (Q_PROPERTY)
    QVariantList objButtonList() const {
        return m_objButtonList; }

    QVariantList objButtonListBackground() const {
        return m_objButtonList_backgroung; }

    QVariantList objButtonListCenter() const {
        return m_objButtonList_center; }

    QVariantList objButtonListUpper() const {
        return m_objButtonList_upper; }

    QVariantList objButtonListLower() const {
        return m_objButtonList_lower; }

    QVariantList objButtonListLowerRight() const {
        return m_objButtonList_lowerRight; }

    QVariantList objButtonListLowerLeft() const {
        return m_objButtonList_lowerLeft; }

    QVariantList objButtonListModel() const {
        return m_objButtonList_model; }

    QVariantList objButtonListCenterRight() const {
        return m_objButtonList_centerRight; }

    QVariantList objButtonListCenterLeft() const {
        return m_objButtonList_centerLeft; }

    QVariantList objButtonListCenterUpper() const {
        return m_objButtonList_centerUpper; }

    QVariantList objButtonListCenterLower() const {
        return m_objButtonList_centerLower; }

    QVariantList objButtonListCenterHoriz1() const {
        return m_objButtonList_centerHoriz1; }

    QVariantList objButtonListCenterHoriz2() const {
        return m_objButtonList_centerHoriz2; }

    QVariantList objButtonListCenterHoriz3() const {
        return m_objButtonList_centerHoriz3; }




    QString container() const {
        return _container;
    }

    void setContainer(const QString &new_container){
        if (new_container != _container) {
            _container = new_container;
        }
        Q_EMIT(containerChanged());
    }


    QString button_distribution() const{
        return _button_distribution;
    }

    void setButton_distribution(const QString &new_button_distribution){
        if(new_button_distribution != _button_distribution){
            _button_distribution = new_button_distribution;
        }
        Q_EMIT(button_distributionChanged());
    }

    int num_buttons() const {
        return _current_num_buttons;
    }

    void setNum_buttons(const int &new_num_buttons){
        if (new_num_buttons != _current_num_buttons) {
            _current_num_buttons = new_num_buttons;
        }
        Q_EMIT(num_buttonsChanged());
    }

    bool menu_status() const {
        return _menu_status;
    }

    void setMenu_status(const int &new_menu_status){
        if (new_menu_status != _menu_status) {
            _menu_status = new_menu_status;
        }
        Q_EMIT(menu_statusChanged());
    }

    // clearListas--> función creada para limpiar una lista determinada (con c_all se limpian todas)

    void clearListas(QString c_container){

        m_objButtonList.clear();    // limpiamos las lista y liberamos recursos (cuando se carga nuevo template)
        if ( (c_container=="c_background") ||    (c_container==""))
            m_objButtonList_backgroung.clear();
        if (c_container=="c_central")
            m_objButtonList_center.clear();
        if (c_container=="c_upper")
            m_objButtonList_upper.clear();
        if (c_container=="c_lower")
            m_objButtonList_lower.clear();
        if (c_container=="c_lower_right")
            m_objButtonList_lowerRight.clear();
        if (c_container=="c_lower_left")
            m_objButtonList_lowerLeft.clear();
        if (c_container=="c_model")
            m_objButtonList_model.clear();
        if (c_container=="c_central_right")
            m_objButtonList_centerRight.clear();
        if (c_container=="c_central_left")
            m_objButtonList_centerLeft.clear();
        if (c_container=="c_central_upper")
            m_objButtonList_centerUpper.clear();
        if (c_container=="c_central_lower")
            m_objButtonList_centerLower.clear();
        if (c_container=="c_central_horiz_1")
            m_objButtonList_centerHoriz1.clear();
        if (c_container=="c_central_horiz_2")
            m_objButtonList_centerHoriz2.clear();
        if (c_container=="c_central_horiz_3")
            m_objButtonList_centerHoriz3.clear();

        if (c_container=="c_all"){
            m_objButtonList_backgroung.clear();
            m_objButtonList_center.clear();
            m_objButtonList_upper.clear();
            m_objButtonList_lower.clear();
            m_objButtonList_lowerRight.clear();
            m_objButtonList_lowerLeft.clear();
            m_objButtonList_model.clear();
            m_objButtonList_centerRight.clear();
            m_objButtonList_centerLeft.clear();
            m_objButtonList_centerUpper.clear();
            m_objButtonList_centerLower.clear();
            m_objButtonList_centerHoriz1.clear();
            m_objButtonList_centerHoriz2.clear();
            m_objButtonList_centerHoriz3.clear();
        }


    }


// función para configurar cada boton creado

    void setButtonx(MenuButton* buttonx,QString type, QString text, QString icon, std::string msg_value){
        buttonx->setType(type);
        buttonx->setText(text);
        buttonx->setIcon(icon);
        buttonx->setMsgValue(msg_value);
        Q_EMIT(buttonxChanged());

    }//

    ///Methods
    void configButton(QString containerS,int button_index, touch_screen_msgs::ScreenButton button_config){

        QString button_design(button_config.button_design.c_str());
        QStringList name_options = button_design.split(";");

        std::string msg_value = button_config.msg_value;

        QString type = name_options.first();
        QString text = "";
        QString icon = "";

        if (type == "text")  {
            text = name_options.last();
        }
        else if(type == "icon"){
            icon = name_options.last();
        }

        //  creamos un boton nuevo por cada boton que tenga el menu (no hay limitación salvo las limitaciones del sistema)

        MenuButton* buttonx=new MenuButton();

        // configuramos el boton

        setButtonx(buttonx,type,text,icon,msg_value);

        // activamos el tipo

        buttonx->setType(type);

        // añadimos a una lista genérica. No se usa

        m_objButtonList.append(qVariantFromValue((MenuButton*)buttonx));

        // asignamos los botones al contenedor adecuado, mediante las listas creadas
        // en cada lista tendremos el boton creado. Separado por contenedor

        if (containerS=="c_background" || containerS=="")
            m_objButtonList_backgroung.append(qVariantFromValue((MenuButton*)buttonx));

        if (containerS=="c_central")
            m_objButtonList_center.append(qVariantFromValue((MenuButton*)buttonx));

        if (containerS=="c_upper")
            m_objButtonList_upper.append(qVariantFromValue((MenuButton*)buttonx));

        if (containerS=="c_lower")
            m_objButtonList_lower.append(qVariantFromValue((MenuButton*)buttonx));

        if (containerS=="c_lower_right")
            m_objButtonList_lowerRight.append(qVariantFromValue((MenuButton*)buttonx));

        if (containerS=="c_lower_left")
            m_objButtonList_lowerLeft.append(qVariantFromValue((MenuButton*)buttonx));

        if (containerS=="c_model")
            m_objButtonList_model.append(qVariantFromValue((MenuButton*)buttonx));

        if (containerS=="c_central_right")
            m_objButtonList_centerRight.append(qVariantFromValue((MenuButton*)buttonx));

        if (containerS=="c_central_left")
            m_objButtonList_centerLeft.append(qVariantFromValue((MenuButton*)buttonx));

        if (containerS=="c_central_upper")
            m_objButtonList_centerUpper.append(qVariantFromValue((MenuButton*)buttonx));

        if (containerS=="c_central_lower")
            m_objButtonList_centerLower.append(qVariantFromValue((MenuButton*)buttonx));

        if (containerS=="c_central_horiz_1")
            m_objButtonList_centerHoriz1.append(qVariantFromValue((MenuButton*)buttonx));

        if (containerS=="c_central_horiz_2")
            m_objButtonList_centerHoriz2.append(qVariantFromValue((MenuButton*)buttonx));

        if (containerS=="c_central_horiz_3")
            m_objButtonList_centerHoriz3.append(qVariantFromValue((MenuButton*)buttonx));

    }  // de configButton







signals:
    void num_buttonsChanged();
    void menu_statusChanged();
    void containerChanged();
    void button_distributionChanged();


    void buttonxChanged();
   // funciones requeridas en Q_PROPERTY

    void objButtonListChanged(QVariantList argu);
    void objButtonListBackgroundChanged(QVariantList argu);
    void objButtonListCenterChanged(QVariantList argu);
    void objButtonListUpperChanged(QVariantList argu);
    void objButtonListLowerChanged(QVariantList argu);
    void objButtonListLowerRightChanged(QVariantList argu);
    void objButtonListLowerLeftChanged(QVariantList argu);
    void objButtonListModelChanged(QVariantList argu);
    void objButtonListCenterRightChanged(QVariantList argu);
    void objButtonListCenterLeftChanged(QVariantList argu);
    void objButtonListCenterUpperChanged(QVariantList argu);
    void objButtonListCenterLowerChanged(QVariantList argu);
    void objButtonListCenterHoriz1Changed(QVariantList argu);
    void objButtonListCenterHoriz2Changed(QVariantList argu);
    void objButtonListCenterHoriz3Changed(QVariantList argu);

public slots:

    // no se utiliza
    void setObjButtonList(QVariantList argu){
        if( m_objButtonList==argu)
            return;
        m_objButtonList=argu;
        emit objButtonListChanged(argu);
    }

// slot al que se llama cuando se pulsa un boton desde QML, a partir de aqui se decide que hacer
    void on_button1_clicked(int index,QString contenedor){

        std_msgs::String msg;

        MenuButton *pp;  // creamos un puntero al boton pulsado y segun que contenedor y el indice
                         // accedemos al contenido del botón

        if (contenedor=="c_background" || contenedor==""){
            QVariant p=m_objButtonList_backgroung.at(index);
            pp=p.value<MenuButton*>();  // en pp tenemos el valor del boton buscado en forma de MenuButton
        }

        if (contenedor=="c_central"){
            QVariant p=m_objButtonList_center.at(index);
            pp=p.value<MenuButton*>();
        }

        if (contenedor=="c_upper"){
            QVariant p=m_objButtonList_upper.at(index);
            pp=p.value<MenuButton*>();
        }

        if (contenedor=="c_lower"){
            QVariant p=m_objButtonList_lower.at(index);
            pp=p.value<MenuButton*>();
        }

        if (contenedor=="c_lower_right"){
            QVariant p=m_objButtonList_lowerRight.at(index);
            pp=p.value<MenuButton*>();
        }

        if (contenedor=="c_lower_left"){
            QVariant p=m_objButtonList_lowerLeft.at(index);
            pp=p.value<MenuButton*>();
        }

        if (contenedor=="c_model"){
            QVariant p=m_objButtonList_model.at(index);
            pp=p.value<MenuButton*>();
        }

        if (contenedor=="c_central_left"){
            QVariant p=m_objButtonList_centerLeft.at(index);
            pp=p.value<MenuButton*>();
        }

        if (contenedor=="c_central_right"){
            QVariant p=m_objButtonList_centerRight.at(index);
            pp=p.value<MenuButton*>();
        }

        if (contenedor=="c_central_upper"){
            QVariant p=m_objButtonList_centerUpper.at(index);
            pp=p.value<MenuButton*>();
        }

        if (contenedor=="c_central_lower"){
            QVariant p=m_objButtonList_centerLower.at(index);
            pp=p.value<MenuButton*>();
        }

        if (contenedor=="c_central_horiz_1"){
            QVariant p=m_objButtonList_centerHoriz1.at(index);
            pp=p.value<MenuButton*>();
        }

        if (contenedor=="c_central_horiz_2"){
            QVariant p=m_objButtonList_centerHoriz2.at(index);
            pp=p.value<MenuButton*>();
        }

        if (contenedor=="c_central_horiz_3"){
            QVariant p=m_objButtonList_centerHoriz3.at(index);
            pp=p.value<MenuButton*>();
        }

        // construimos un mensaje para publicar en "menu_response" que se ha pulsado un boton
        // en este punto tenemos acceso al indice pulsado y al contenedor que pertenece el menu.

        msg.data=pp->getMsgValue();  // construimos con el mensaje que llebava el boton
        QString qs=QString::fromUtf8(msg.data.c_str());
        qDebug() << "msg De la lista:"+qs;  // enseñamos por consolo
        _menu_pub.publish(msg);  // publicamos en menu_response



    }  // de on button1 clicled

private:

    ros::NodeHandle _nh;
    ros::Publisher _menu_pub;

    QString _container;
    int _current_num_buttons;
    QString _button_distribution;
    bool _menu_status;

    QVariantList  m_objButtonList;
    QVariantList  m_objButtonList_backgroung;
    QVariantList  m_objButtonList_center;
    QVariantList  m_objButtonList_upper;
    QVariantList  m_objButtonList_lower;
    QVariantList  m_objButtonList_lowerRight;
    QVariantList  m_objButtonList_lowerLeft;
    QVariantList  m_objButtonList_model;
    QVariantList  m_objButtonList_centerRight;
    QVariantList  m_objButtonList_centerLeft;
    QVariantList  m_objButtonList_centerUpper;
    QVariantList  m_objButtonList_centerLower;
    QVariantList  m_objButtonList_centerHoriz1;
    QVariantList  m_objButtonList_centerHoriz2;
    QVariantList  m_objButtonList_centerHoriz3;

};

#endif // MENUPROPERTIES_H
