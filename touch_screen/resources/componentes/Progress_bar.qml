/********************************Progress_bar.qml*******************
  Recurso progress bar: Recurso que cargaremos cuando se reproduzca un audio o un vídeo.
  *******************************/

import QtQuick 2.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import "../Myscripts/creacion_componentes.js" as Ms

Item {
    id: item_progressbar
    anchors.fill:parent         // Coge el tamaño de la pantalla

    property alias progress_barLayout:progressbar_layout  // variable para accedere al audio desde otros qml's
    property real initial_position:0
    property real multimedia_duration:0     // Este valor es asignado cuando se reproduce un audio o video
    property real position:0

    ProgressBar {

        id: progressbar_layout
        //x: 250
        //y: 1050
        x: item_progressbar.width * 0.04
        y: item_progressbar.height * 0.9

        minimumValue: initial_position
        maximumValue: multimedia_duration
        orientation: Qt.Horizontal

       value: position

       style: ProgressBarStyle {

            background: Rectangle {

                radius: 2
                color: "lightgray"
                border.color: "gray"
                border.width: 1
                //implicitWidth: 1400
                //implicitHeight: 50
                implicitWidth: item_progressbar.width * 0.92
                implicitHeight: item_progressbar.height * 0.06
            }

            progress: Rectangle {
                //color: "lightskyblue"
                //border.color: "steelblue"
                color: "yellowgreen"
                border.color: "forestgreen"
            }
       }
    }



}
