/********************************Texto.qml*******************
  Recurso texto: Recurso que cargaremos cuando recibamos en el mensaje correspondiente al tipo texto.
  Carga un texto.
  Se carga de forma dinámica desde contenedor.qml , indicandole las características delrecurso.
(mediante la  propiedad fuente,font_text etc , se tiene un texto por defecto
  *******************************/

import QtQuick 2.0

Rectangle{

    id: base_texto
    anchors.fill:parent
    color:"transparent"  // color de fondo por defecto
    property string fuente  // texto a enseñar, se cargará en ficheros anteriores
    property string font_text  // fuente del texto
    property int size_text      // tamaño del texto
    property string contenedor  // contenedor donde se mostrará el texto
    TextEdit {      // se elige TextEdit a fin de poder escribir en varias líneas

        property string default_texto: "Texto por defecto"
        property string last_texto: "Texto por defecto"

        id: texto_2
        anchors.fill:parent  // toma el tamaño del contendor que lo contiene

        font.family:font_text    // asignamos propiedades
        font.pixelSize:size_text
        text:fuente
        readOnly: true

        textFormat:TextEdit.AutoText   // características del texto
        horizontalAlignment: TextEdit.AlignHCenter // alienado horizontalmente
        wrapMode: TextEdit.Wrap

    }  // del texto

}   // del rectangle
