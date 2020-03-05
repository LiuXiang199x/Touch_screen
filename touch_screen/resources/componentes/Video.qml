/********************************Video.qml*******************
  Recurso Video: Recurso que cargaremos cuando recibamos en el mensaje correspondiente el tipo video.
  Carga un Video.
  Se carga de forma dinámica desde contenedor.qml , indicandole el source del recurso.
   Cuando finaliza el video se muestra el logotipo.
  Se publica el estado del recurso, por si interesa a otros proyectos
  *******************************/

import QtQuick 2.0
import QtMultimedia 5.0

//import "../Myscripts/creacion_componentes.js" as Ms

Rectangle {
    id: video_layout
    anchors.fill: parent
    color: "black"  // mostramos una imgaen por debajo del video que es el logotipo
    visible: true

    property string fuente  // url del video
    property string estado  // estado de ejecución del video play,pause o stop
    property alias videoLayout:video_layout  // variable para acceder desde otros qml's
    property int posicion:0   //######
    //property int minute: 0 // Minuto del video #######

    // imagen que se mostrará al finalizar el video, y mientras se ejecuta (por debajo del video)
/*
    Image{
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source:"../image/default.png" // se muestra el logotipo
        visible:true
    }*/

    MediaPlayer {
        id: video_player
        autoPlay: true
        source: fuente
        //position: minute //##################
        //property int minute: 0 // Minuto del video #######
        //minute: position        // La variable minute tendrá el valor de la posición ######

        onPlaying: {
            msg_publisher.on_video_played()
            //msg_publisher.on_multimedia_minute(position) //#############
            //msg_publisher.on_multimedia_detailed_state(status.toString());  //######
        }

        onPaused: {

            msg_publisher.on_video_paused()
            //msg_publisher.on_multimedia_minute(position) //#############
            //msg_publisher.on_multimedia_detailed_state(status.toString());  //######

        }

        onStopped:{

          //  estado="stop"
            msg_publisher.on_video_stopped()
            //msg_publisher.on_multimedia_minute(position) //#############
            //msg_publisher.on_multimedia_detailed_state(status.toString());  //######

            if (video_player.position === video_player.duration)
                if (video_player.position != 0){
                    msg_publisher.on_video_end()
            }

        } // de onStopped


    }


    VideoOutput {
        id: video_output
        source: video_player
        anchors.fill: parent

    }


    //Progress bar
    Progress_bar {
        id: progress_bar1
        initial_position: 0
        multimedia_duration: video_player.duration
        //position:video_player.position
    }

    Component.onCompleted: {  // cuando se termina de cargar , se ejecuta segun el estado

        switch(estado){
        case "play":

            //video_player.play() // ··············
            video_player.seek(posicion)  //#############
            break;

        case "pause":

            video_player.pause()
            break;

        case "stop":

            video_player.stop()
            posicion = 0                //########
            break;

        }
    }

    onEstadoChanged: {

        switch(estado){  // si cambiamos de estado debe ejecutarse la orden correspondiente
        case "play":

            video_player.play()
            break;

        case "pause":

            video_player.pause()
            break;

        case "stop":

            video_player.stop()
            posicion = 0            //########
            break;

        } // del switch

    }  //del onEstadoChanged


    // Timer to send video position
    Timer  {
        id: sendPositionTimer
        interval: 100;
        running: true;
        repeat: true;
        onTriggered: {
            progress_bar1.position = video_player.position
            msg_publisher.on_multimedia_minute(video_player.position)

        }
    }

} // del Rectangle inicial

