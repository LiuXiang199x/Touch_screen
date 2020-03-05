#include "screen_interface.h"

ScreenInterface::ScreenInterface(ros::NodeHandle nh, QString multimedia_path, QString default_window_status){

    nh_ = nh;

    msg_publisher = new RosPublisherThread(nh);
    msg_client = new RosClientThread(nh);

    my_menu_properties = new MenuProperties(nh);
    my_template_properties = new TemplateProperties();
    my_client_thread = new RosClientThread(nh);


//////////////////////////////////////////////QML//////////////////////////////////////////////

    #ifdef Q_OS_ANDROID
    #else
        //QtWebEngine::initialize(); //Initialize the QtWebEngine only for Desktop Devices

    #endif
	
        my_multimedia_properties.setMultimedia_path(multimedia_path);
        my_multimedia_properties.setWindow_state(default_window_status);

    engine.rootContext()->setContextProperty("msg_publisher", msg_publisher);
    engine.rootContext()->setContextProperty("msg_client", msg_client);
    engine.rootContext()->setContextProperty("menu_properties", my_menu_properties);
    engine.rootContext()->setContextProperty("multimedia_properties", &my_multimedia_properties);
    engine.rootContext()->setContextProperty("template_properties", my_template_properties);
    engine.rootContext()->setContextProperty("text_properties", &my_text_properties);
    engine.rootContext()->setContextProperty("client_thread", my_client_thread);


    QQmlComponent component(&engine, QUrl(QStringLiteral("qrc:/main.qml")), this);
    component.create();


    //QObject::connect( my_template_properties, SIGNAL(multimedia_template_sig(QString, QString, QString)),
                     //this, SLOT(on_multimedia_template_received(QString, QString, QString)));

    QObject::connect( my_template_properties, SIGNAL(multimedia_template_sig(QString, QString, QString, int)),  //#### Cambiado.1/04/19
                         this, SLOT(on_multimedia_template_received(QString, QString, QString, int)));


    QObject::connect( my_template_properties, SIGNAL(text_template_sig(QString,QString,int,QString)),
                     this, SLOT(on_text_template_received(QString,QString,int,QString)));


    QObject::connect(msg_client, SIGNAL(error_connection_sig(bool)),
                     this, SLOT(on_error_connection_received(bool)));





}

ScreenInterface::~ScreenInterface(){
}


///////////////////////////////////////////////////////////////////////
///SLOTS
///////////////////////////////////////////////////////////////////////

void ScreenInterface::on_set_window_status_received(QString set_window_status){

    my_multimedia_properties.setWindow_state(set_window_status);

}

///////////////////////////////////////////////////////////////////////

void ScreenInterface::on_show_customized_menu_received(QString container,
                                        bool enable_input,
                                        int num_buttons,
                                        QString button_distribution,
                                        std::vector<touch_screen_msgs::ScreenButton> buttons_config){

    ///Restarts menu interface if its enabled previously
    my_menu_properties->clearListas(container);

    my_menu_properties->setMenu_status(false);
    my_menu_properties->setContainer("");
    my_menu_properties->setButton_distribution("");




    my_menu_properties->setMenu_status(enable_input);


    if (enable_input) {

        my_menu_properties->setNum_buttons(num_buttons);

        my_menu_properties->setButton_distribution(button_distribution);

	for(int i=0;i<num_buttons;i++)
             my_menu_properties->configButton(container,i,buttons_config[i]);


    }
    // compatibilidad con el programa anterior, ni template ni contenedor (se aignaria a c_background)
     if (my_template_properties->num_template()=="" && container=="")
           container="c_background";
        my_menu_properties->setContainer(container);
}


/////////////////////////////////////////////////////////////////////////

void ScreenInterface::on_multimedia_request_received(QString container, QString type, QString multimedia_name, int msec){ // #####
   // my_multimedia_properties.setSend_player(true);
    my_menu_properties->setMenu_status(false);
    my_multimedia_properties.setContainer("");

    my_multimedia_properties.setSend_player(false);

    my_multimedia_properties.setMultimedia_type(type);
    my_multimedia_properties.setMultimedia_filename(multimedia_name);
    my_multimedia_properties.setMultimedia_state("play");

    my_multimedia_properties.setMultimedia_position(msec);  //######

    // compatibilidad con el programa anterior, ni template ni contenedor (se aignaria a c_background)

    if (my_template_properties->num_template()=="" && container=="")
          container="c_background";

    my_multimedia_properties.setContainer(container);
}

void ScreenInterface::on_multimedia_player_received(QString container, QString type, QString multimedia_state){

    my_menu_properties->setMenu_status(false);
    my_multimedia_properties.setContainer("");

    my_multimedia_properties.setSend_player(true);

    my_multimedia_properties.setMultimedia_type(type);

    my_multimedia_properties.setMultimedia_state(multimedia_state);

    // compatibilidad con el programa anterior, ni template ni contenedor (se aignaria a c_background)

    if (my_template_properties->num_template()=="" && container=="")
          container="c_background";

    my_multimedia_properties.setContainer(container);

}

/*
void ScreenInterface::on_multimedia_set_position_received(int position){ //#############

    my_menu_properties->setMenu_status(false);
    my_multimedia_properties.setContainer("");

    my_multimedia_properties.setSend_player(true);

    my_multimedia_properties.setMultimedia_state("play");

    my_multimedia_properties.setMultimedia_position(position);


} */

/////////////////////////////////////////////////////////////////////////////

void ScreenInterface::on_show_customized_template_received(QString num_template, std::vector<touch_screen_msgs::MultimediaContent> multimedia_config, std::vector<touch_screen_msgs::CustomizedMenu> menu_config, std::vector<touch_screen_msgs::CustomizedText> text_config){



    my_template_properties->setTemplate("");





    my_template_properties->setTemplate(num_template);

    // configuramos el multimedia del template a cargar

    for(int i=0; i<multimedia_config.size(); i++){
        my_template_properties->configMultimedia(multimedia_config[i]);

    }

    // configuramos los menus del template a cargar

	//vaciamos listas de botones (al cargar una nueva pantalla se deben limpiar las listas y liberar recursos de
    // menus de la anterior pantalla. !!! revisar si deben interaccionar diferentes pantallas !!!!!

    my_menu_properties->clearListas("c_all");

    // miramos si en algun contenedor va algun menu, y coniguramos el menu suponemos que tan solo hay un menu en todo el template
	for(int i=0; i<menu_config.size(); i++){
    	my_menu_properties->setMenu_status(false);
        my_menu_properties->setContainer("");  // forzamos cambio de container

    	my_menu_properties->setMenu_status(menu_config[i].enable_input);

	QString containerS = QString::fromUtf8(menu_config[i].container.c_str());  // extraemos contenedor (lo asignamos al final)



    if (menu_config[i].enable_input){

      my_menu_properties->setNum_buttons(menu_config[i].number_buttons);
      my_menu_properties->setButton_distribution(menu_config[i].button_distribution.c_str());
       
    for(int j=0;j<menu_config[i].number_buttons;j++){
        my_menu_properties->configButton(containerS,j,menu_config[i].buttons_config[j]);
                 }

    } // del if (menu_config[i].
     my_menu_properties->setContainer(containerS);  // activamos el container. ( se ejecutaran cambios en QML)

}  // del for(int i=0;i<menu_config.size()

    // configuramos el texto del template a cargar

    for(int i=0; i<text_config.size(); i++){
        my_template_properties->configText(text_config[i]);

    }
}

void ScreenInterface::on_multimedia_template_received(QString container, QString type, QString multimedia_name, int msec){      //### Cambiado 01/04/19
    my_menu_properties->setMenu_status(false);
    my_multimedia_properties.setContainer("");
    my_multimedia_properties.setMultimedia_type(type);
    my_multimedia_properties.setMultimedia_filename(multimedia_name);
    my_multimedia_properties.setMultimedia_state("play");

    my_multimedia_properties.setMultimedia_position(msec);      //### Cambiado 01/04/19

    my_multimedia_properties.setContainer(container);

}

void ScreenInterface::on_text_template_received(QString container, QString customized_text, int size_text, QString font_text){
    my_text_properties.setContainer("");

    my_text_properties.setSize_text(size_text);
    my_text_properties.setFont_text(font_text);
    my_text_properties.setCustomized_text(customized_text);

    my_text_properties.setContainer(container);
}

void ScreenInterface::on_show_customized_text_receiver(QString container, QString customized_text, int size_text, QString font_text){
    my_text_properties.setContainer("");

    my_text_properties.setSize_text(size_text);
    my_text_properties.setFont_text(font_text);
    my_text_properties.setCustomized_text(customized_text);

    my_text_properties.setContainer(container);

}

///////////////////////////////////////////////////////////////////////////////////////////////////

void ScreenInterface::on_error_connection_received(bool error_connection){
    qDebug() << "Slot check connection. Value error_connection: "<< error_connection;
    my_client_thread->setError_connection(error_connection);
    my_client_thread->setError_connection(false);
    my_template_properties->setTemplate("0");
    touch_screen_msgs::CustomizedText error_text;
    error_text.container = "c_background";
    error_text.customized_text = "Connection error, please relaunch the application";
    error_text.size_text = 200;
    error_text.font_text = "Helvetica";
    my_template_properties->configText(error_text);

}
