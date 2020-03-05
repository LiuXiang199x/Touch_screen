import QtQuick 2.2
import QtQuick.Window 2.2
import QtMultimedia 5.0
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtWebView 1.0




import "componentes"
import "forms"
import "Myscripts/creacion_componentes.js" as Ms

Window {
    visible: true
    id: main_window
    width: 400
    height: 400
    visibility: Window.FullScreen


    ////////////////////
    ///  Multimedia  ///
    ////////////////////   

    property string multimedia_type : multimedia_properties && multimedia_properties !== undefined ? multimedia_properties.multimedia_type : ""
    property string multimedia_path : multimedia_properties && multimedia_properties !== undefined ? multimedia_properties.multimedia_path : ""
    property string multimedia_filename : multimedia_properties && multimedia_properties !== undefined ? multimedia_properties.multimedia_filename : ""
    property string multimedia_state : multimedia_properties && multimedia_properties !== undefined ? multimedia_properties.multimedia_state : ""
    property string window_state : multimedia_properties && multimedia_properties !== undefined ? multimedia_properties.window_state : ""
    property bool send_player : multimedia_properties && multimedia_properties != undefined ? multimedia_properties.send_player : false

    property int multimedia_position : multimedia_properties && multimedia_properties != undefined ? multimedia_properties.multimedia_position : 0  //#########

    property string container: multimedia_properties && multimedia_properties !== undefined ? multimedia_properties.container : ""

    property string num_template: template_properties && template_properties !== undefined ? template_properties.num_template: ""

    property string multimedia_full_file_path: ""
    property string url: ""

    property string fuente_audio
    property string fuente_video
    property string estado_audio
    property string estado_video
    property bool inicializarAudioVideo:false

    property int position:0       //#### Cambiado 2/4/19

   // property int posicion_multimedia    //#########


    //////////
    //// texto
    ////////////

    property string container_text:text_properties && text_properties !== undefined ? text_properties.container : ""
    property string customized_text:text_properties && text_properties !== undefined ? text_properties.customized_text : ""
    property int size_text:text_properties && text_properties !== undefined ? text_properties.size_text : ""
    property string font_text:text_properties && text_properties !== undefined ? text_properties.font_text : ""

    onWindow_stateChanged: {

        switch(window_state){
        case "fullscreen":
            main_window.visibility = Window.FullScreen
            break;
        case "hide":
            main_window.visibility = Window.Hidden
            break;
        case "maximize":
            main_window.visibility = Window.Maximized
            break;
        case "minimize":
            main_window.visibility = Window.Minimized
            break;
        case "window":
            main_window.visibility = Window.Windowed
            break;
        }

        msg_publisher.on_window_status_changed(window_state)
    }


    onContainer_textChanged: {
        if(container_text==="")
            carga_template.item.actualizar=false
        else{
            carga_template.item.n_contenedor=text_properties.container
            carga_template.item.tipo="texto"
            carga_template.item.actualizar=true
              msg_publisher.on_inicializado();  // comunicamos que hemos recibido un mensaje de carga de contenedor
        }
    }


    onContainerChanged: {

        carga_template.item.tipo=multimedia_type

        if (multimedia_type==="audio"){
            if(inicializarAudioVideo==true)
                estado_audio="play"
            else
                estado_audio=multimedia_state

        }
        if (multimedia_type==="video"){
            if(inicializarAudioVideo==true)
                estado_video="play"
            else
                estado_video=multimedia_state

        }


        carga_template.item.n_contenedor=container
        if(container==="" && num_template!=="")
            carga_template.item.actualizar=false
        else{
            carga_template.item.actualizar=true
              msg_publisher.on_inicializado();  // comunicamos que hemos recibido un mensaje de carga de contenedor
        }
        //inicializarAudioVideo=false;
    }

    onSend_playerChanged: {
        if(send_player)
            inicializarAudioVideo = false;

        else
            inicializarAudioVideo = true;
    }


    onMultimedia_positionChanged: {         //#########
        /*
        if (multimedia_type==="audio"){     //##### Cambiado 2/4/19
           position = multimedia_position

        }
        if (multimedia_type==="video"){     //####  Cambiado 2/4/19
            position = multimedia_position

        }*/
        position = multimedia_position
    }


    onMultimedia_filenameChanged: {
        multimedia_full_file_path = multimedia_path + multimedia_filename

        //If multimedia_filename starts with "http://" or "https://" the url value will be equal to multimedia_filename,
        //otherwise the url value will take the value of multimedia_full_file_path

        if (multimedia_filename.substring(0, 7) == "http://" || multimedia_filename.substring(0, 8) == "https://") {
            url = multimedia_filename
        }else{
            url = multimedia_full_file_path
        }

        if (multimedia_type=="audio"){
                    fuente_audio=multimedia_full_file_path
                //    estado_audio=multimedia_state
                    estado_audio="play"
                  //   inicializarAudioVideo=true;
        }
        if (multimedia_type=="video"){
                    fuente_video=multimedia_full_file_path
          //          estado_video=multimedia_state
                    estado_video="play"
                  //   inicializarAudioVideo=true;
        }

    }

    onMultimedia_stateChanged: {


    }

    onNum_templateChanged: {
        var n_template
        n_template = num_template

        if (num_template!=""){
          Ms.crearTemplate(n_template);
             msg_publisher.on_inicializado();  // comunicamos que hemos recibido un mensaje de carga del template
        }

    }


    Loader {
        id: carga_template
        anchors.fill:parent

    }

    Component.onCompleted: {

        //Por defecto se mostrara la imagen ../image/default.png, con el contenedor 0

        var n_template="0";
//        var fuente="../image/default.png";

        Ms.crearTemplate(n_template);

    }


    //////////////
    ///  Menu  ///
    //////////////
    property int num_buttons : menu_properties && menu_properties != undefined ? menu_properties.num_buttons : 1
    property bool menu_state : menu_properties && menu_properties != undefined ? menu_properties.menu_status : false
    property string menu_container: menu_properties && menu_properties !== undefined ? menu_properties.container : ""

    onMenu_stateChanged: {
    }

    onMenu_containerChanged: {

        carga_template.item.tipo="menu1"

        carga_template.item.n_contenedor=menu_container

        carga_template.item.actualizar=true
          msg_publisher.on_inicializado();  // comunicamos que hemos recibido un mensaje de carga del contenedor



    }

    onNum_buttonsChanged: {


    }

    /////////////////////////
    /// Check connection ////
    ////////////////////////


    Timer  {
        id: elapsedTimer
        interval: 1000;
        running: true;
        repeat: true;
        onTriggered: msg_client.on_client_request()
    }






}

