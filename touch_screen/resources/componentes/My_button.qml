/********************************My_button.qml*******************
  Recurso menu: Recurso que cargaremos cuando recibamos en el mensaje correspondiente al tipo menu1.

  Carga una menu, con botones tipo texto o botones tipo icon, de forma estática.( los botones no se mueven)

  Se carga de forma dinámica desde contenedor.qml , indicándole todas las características del menu.

  Se utilizan funciones globales (aparecen en librerias javascrip , para ver el tipo de boton,
texto que hay que enseñar con el boton (si es de tipo texto) y la ruta de la imagen (si es de tipo
icon).

    En distribution tendremos la distribución con la que queremos que se muestre el menu:
            column--> 1 columna
            grid--> 1 columna
            grid;<numero columnas>--> se mostraran los botones utilizando "numero de columnas" calculando
automaticamente el numero de filas, altura de los botones y anchura de estos. Ejemplo grid;3
distribuiría el numero de botones en 3 columnas recalculando el numero de filas necesarias, altura etc.

  Se calcula la altura de los botones según el numero de botones y el tipo de distribución, calculamndose
de forma automática. (la anchura del boton tambien se calcula de forma automática).
  *******************************/

import QtQuick 2.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import "../Myscripts/creacion_componentes.js" as Ms

Item {

    id: menu_button_layout
    anchors.fill: parent            // tomamos todo el espacio del contenedor del que procede
    anchors.margins: parent.height/64  // definimos margenes
    visible: true
    property int botones            // numero de botones
    property string contenedor      // contenedor que contendrá el menu
    property string distribution    // tipo de distribución del menu (grid;3, column, animX, animY)
    property int button_height: 0   // altura del boton
    property int grid_columns: 1    // columnas por defecto de la distribución grid

    onDistributionChanged: {  // asignamos el tamaño del boton si cambia la distribución

        button_height=Ms.asignarAltura(distribution,botones)

    }

    onHeightChanged: {  // asignamos el tamaño del boton si cambia el tamaño de la plantilla

        button_height=Ms.asignarAltura(distribution,botones)

    }

    Component.onCompleted: {

    }

    Grid{               // se mostrará utilizando este componente QML
        id: menu_grid
        spacing: menu_button_layout.anchors.margins // espacio entre botones
        anchors.centerIn: parent
        columns: grid_columns   // numero de columnas del grid, por defeecto 1

        Repeater{  // repetimos para todos los botones

            id:repe
            model:botones    // numero de botones

            Button{             // características de cada boton
                id: button_1
                iconSource: ""
                visible: true
                                // definimos tamaño de los botones (alto recalculado en función aparte)
                width: menu_button_layout.width/Math.min(menu_grid.columns, num_buttons) - menu_grid.spacing
                height: button_height
                opacity: 1
                enabled: true

                Loader{             // cargamos dinámicamente el boton)
                    id:loader_imagen_boton
                    anchors.fill:parent

                    Component.onCompleted: {
                        if(Ms.asignIcon(index)!=="../image/default.png") // miramos si tenemos que cargar la imagen
                     // si la función asignIcon devuelve la ruta de la imagen del logotipo, simplmemente no cargamos ninguna imagen

                            loader_imagen_boton.sourceComponent=component_imagen_boton
                    }

                    Component{  // componente que se cargaría en caso que el boton fuera del tipo icon
                        id:component_imagen_boton
                        Image {
                            id:imagen_boton
                            anchors.fill: parent
                            visible:true
                            source:Ms.asignIcon(index)  // devuelve la ruta donde encontramos la imagen
                            fillMode: Image.PreserveAspectFit
                            //fillMode:Image.Stretch
                            opacity: parent.pressed ? 0.5 : 1

                        }  // de image

                    } // del component

                }  // del loader dentro du button

                style: ButtonStyle {     // escribimos el texto, siempre se carga
                    id:boton_estilo
                    //Text {
                    //label:TextEdit{
                        label:Text{
                        id:boton_label
                        // características del texto , que se mostrara en los botones
                        renderType: Text.NativeRendering        // alineaciones
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Helvetica"                // fuente

                        text:Ms.asignarTexto(index)     // extraemos el texto

                         fontSizeMode: Text.Fit         // tamaño se ajusta al tamño del boton
                         minimumPixelSize: 10           // minimos tamaño
                         font.pixelSize: 128

                    }  // de lapropiedad label

                } // de la propiedad style

                onClicked: {  // cuando pulsamos sobre el boton se comunica a la señal on_button1_clicked

                    menu_properties.on_button1_clicked(index,contenedor)
                    button_1.opacity = 0.2
                    button_1.enabled = false

                  }  // de onCliked

            }  // del button

        } // del repeater

    }  // de column

}  // del item inicial
