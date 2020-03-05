/********************************Audio.qml*******************
  Recurso audio: Recurso que cargaremos cuando recibamos en el mensaje correspondiente el tipo audio.
  Carga un audio.
  Se carga de forma dinámica desde contenedor.qml , indicandole el source del recurso.
   En este caso se carga también desde contenedor.qml la imagen a mostrar mientras se ejecuta el audio
que no es más que la última imagen mostrada , en casa de que nos haya ninguna , se muestra el logotipo.
  Se publica el estado del recurso, por si interesa a otros proyectos
  *******************************/


import QtQuick 2.2
import QtQuick.Window 2.2
import QtMultimedia 5.0
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import QtWebView 1.0


Item{
    id: item_audio
    property string estado                     // estado del audio, play, pause o stop
    property alias audioLayout:audio_layout  // variable para accedere al audio desde otros qml's
    property string tipo:"audio"            // variable que indica el tipo de recurso, en este caso audio
    property alias imagenAudio:imagen_audio // variable para acceder al source de la imagen que debe mostrarse
    property int posicion:0 //######

    Audio {

        id:audio_layout
        autoPlay: true
        //source:""       // se cargará dinámicamente desde el fichero contenedor.qml
        // position es el atributo posicion en msec del audio

        onPlaying: {
            msg_publisher.on_audio_played() // publicamos el estado por si interesa
            //msg_publisher.on_multimedia_minute(position) //#######
            //msg_publisher.on_multimedia_detailed_state(status.toString());  //######
        }

        onPaused: {
            msg_publisher.on_audio_paused()
            //msg_publisher.on_multimedia_minute(position) //#############
            //msg_publisher.on_multimedia_detailed_state(status.toString());  //######
        }

        onStopped:{
           // estado="stop"           // pasamos el esta a stop
            msg_publisher.on_audio_stopped()
            //msg_publisher.on_multimedia_minute(position) //#############
            //msg_publisher.on_multimedia_detailed_state(status.toString());  //######

            if (audio_layout.position === audio_layout.duration)
                if (audio_layout.position != 0)
                    msg_publisher.on_audio_end()
        }

    }  // fin del audio

    //imagen que se mostrará mientras se ejecuta el audio, el source se cargará , al cargarse
    // dinamicamente el qml , desde el fichero contenedor.qml

    Image{
        id:imagen_audio

        visible:true
        anchors.fill:parent
        fillMode: Image.PreserveAspectFit

    }
    // fin imagen


    //Progress bar
    Progress_bar {
        id: progress_bar1
        initial_position: 0
        multimedia_duration: audioLayout.duration

    }



    Component.onCompleted: { // cuando se complete el item inicial

            switch(estado){         // según el estado se realiza una acción u otro
            case "play":

                //audio_layout.play()
                audio_layout.seek(posicion)  //#############
                break;

            case "pause":

                audio_layout.pause()
                break;

            case "stop":

                audio_layout.stop()
                posicion = 0                //########
                break;

            }
    }

    onEstadoChanged: {  // si cambiamos el estado , debe cambiar el comportamiento del audio

        switch(estado){
        case "play":
            audio_layout.play()
            break;
        case "pause":
            audio_layout.pause()
            break;
        case "stop":
            audio_layout.stop()
            posicion = 0                    //########
            break;

        }

    }


    //Timer to send the audio position
    Timer  {
        id: sendPositionTimer
        interval: 100;
        running: true;
        repeat: true;
        onTriggered:{
            progress_bar1.position = audioLayout.position
            msg_publisher.on_multimedia_minute(audioLayout.position)

        }
    }


}



