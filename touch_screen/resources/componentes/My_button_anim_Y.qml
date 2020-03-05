/********************************My_button_anim_Y.qml*******************
  Recurso menu: Recurso que cargaremos cuando recibamos en el mensaje correspondiente al tipo menu1.

  Carga una menu, con botones tipo texto o botones tipo icon,de forma que esten animados

  Se carga de forma dinámica desde contenedor.qml , indicándole todas las características del menu.

  Se utilizan funciones locales , para ver el tipo de boton,texto que hay que enseñar con el boton (si es de tipo texto) y la ruta de la imagen (si es de tipo
icon).

    En distribution tendremos la distribución con la que queremos que se animen los botones en este
case "animY" animación en eje Y, las posiciones iniciales y finales se calculan de forma aleatoria.

    La animación se produce de abajo hacia arriba.De forma indefinida

    El tamaño de los botones se ajustan al tamaño del contenedor. */

import QtQuick 2.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import "../Myscripts/creacion_componentes.js" as Ms

Item {

    id: menu_anim_layout
    anchors.fill: parent
    anchors.margins: parent.height/64       // margenes de los botones
    visible: true

    property int botones            // numero de botones
    property string contenedor      // contenedor que contendrá la animación
    property string distribution  // nos indica ladistribución , en este fichero no haria falta, si ha entrado aqui
    // es porque es animY

    property int ancho_pantalla:menu_anim_layout.width  // almacenamos valores iniciales para poder operar despues
    property int alto_pantalla: menu_anim_layout.height
    property int tiempo_elemento0:7000  // en ms
    property int ancho_boton:menu_anim_layout.width*0.20  // 20% del total  ancho del boton
    property int alto_boton:menu_anim_layout.height*0.20   // 20% del total

    Repeater{

        id:repe
        model:botones  // numero de botones que componen el menu

        Button{
            id: button_1
            iconSource: ""
            visible: true

            width: ancho_boton      // ancho del boton (definido anteriormente
            height: alto_boton    // alto del boton

            x:aleatorio(0,menu_anim_layout.width) //posición inicial en X aleaatoria
            y:alto_pantalla+2*index*height              // ocultamos el boton creado fuera de la pantalla

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
                        //    fillMode: Image.PreserveAspectFit
                        fillMode:Image.Stretch
                        opacity: parent.pressed ? 0.5 : 1

                    }  // de image

                } // del component

            }  // del loader dentro du button

            style: ButtonStyle {  // asignamos las propiedades del boton de tipo text
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

            } // ButtonStyle

            onClicked: {  // cuando cliekeamos se activa el slot correspondiente, pasand indice y contenedor
                menu_properties.on_button1_clicked(index,contenedor)

            }
            // en este caso se ha implementado dos animaciones en paralelo, en el eje X y eje Y
            // de tal manera que los botones animados se desplacen de forma oblicua.

            ParallelAnimation{
                id:anim

                NumberAnimation{   // animación del boton, el tiempo se calcula de manera que siempre se mantenga la distancia entre ellos ( la distancia sería de un botón) aproximadamente
                    id:anim_y

                    target:button_1
                    property:"y"        // desplazamiento en eje Y
                    duration: tiempo_elemento0+calculoTiempo()*index  // tiempo inicial
                    to:-height   // recorre toda la pantalla verticalemnte hacia arriba de la pantalla
                    from:button_1.y

                }

                NumberAnimation{   // animación del boton, el tiempo se calcula de manera que siempre se mantenga la distancia entre ellos ( la distancia sería de un botón) aproximadamente
                    id:anim_x

                    target:button_1
                    property:"x"        // desplazamiento en el eje X
                    duration: tiempo_elemento0+calculoTiempo()*index  // tiempo inicial
                    to:aleatorio(0,menu_anim_layout.width)   // recorre toda la pantalla horizontalmente
                    from:button_1.x
                }
                onStopped: {  // al pararse la 1ª animación, se definen nuevos parametros para las siguientes animaciones..
                    anim_x.duration=tiempo_elemento0   // tiempo el mismo para todos los botones tanto en eje X como en eje Y
                    anim_y.duration=tiempo_elemento0
                    anim_x.from=button_1.x              // button_1 siempre vale los mismo
                    anim_x.to=aleatorio(0,menu_anim_layout.width)  // destino horizontal aleatorio
                    anim_y.to=-height   // recorre toda la pantalla verticalemnte
                    anim_y.from=alto_pantalla+height  // punto inicial

                    anim.running=true      // se inicial la animación paralela otra vez
                }

            }

            function calculoTiempo(){  // calulo del tiempo según el indice del boton, debe tardar más o menos en recorrer la distancia,
                if(index==0)
                    return tiempo_elemento0;
                else
                    return (1/index)*((alto_pantalla+2*alto_boton*index)*tiempo_elemento0/alto_pantalla-tiempo_elemento0)
            }

            Component.onCompleted: {   // activamos la animación

                anim.running=true
            }

        }  // del button


    } // del repeater

    function aleatorio(a,b) { // funcion que nos devuelve un entero aleatoria entre a y b
        return Math.round(Math.random()*(b-a)+parseInt(a));
    }

}  // del item inicial

