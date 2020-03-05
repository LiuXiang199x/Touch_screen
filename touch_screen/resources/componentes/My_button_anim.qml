/********************************My_button_anim.qml*******************
  Recurso menu: Recurso que cargaremos cuando recibamos en el mensaje correspondiente al tipo menu1.

  Carga una menu, con botones tipo texto o botones tipo icon,de forma que esten animados

  Se carga de forma dinámica desde contenedor.qml , indicándole todas las características del menu.

  Se utilizan funciones locales , para ver el tipo de boton,texto que hay que enseñar con el boton (si es de tipo texto) y la ruta de la imagen (si es de tipo
icon).

    En distribution tendremos la distribución con la que queremos que se animen los botones en este
case "animX" animación en eje X, la posición de los botones animados siempre se situa en el centro
del contenedor que los contiene (el central).

    La animación se produce de izquierda a derecha. De forma indefinida.

    El tamaño de los botones se ajustan al tamaño del contenedor.

  *******************************/

import QtQuick 2.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

import "../Myscripts/creacion_componentes.js" as Ms

Item {

    id: menu_anim_layout
    anchors.fill: parent
    anchors.margins: parent.height/64  // margenes botones
    visible: true

    property int botones            // numero de botones
    property string contenedor      // contenedor donde se mostrara
    property string distribution  // nos indica ladistribución , en este fichero no haria falta, si ha entrado aqui
    // es porque es animX

    property int ancho_pantalla:menu_anim_layout.width  // almacenamos valores iniciales para poder operar despues
    property int tiempo_elemento0:7000  // en ms  tiempo que tardara la animación
    property int ancho_boton:menu_anim_layout.width*0.20  // 20% del total  ancho del boton

    Repeater{

        id:repe
        model:botones  // numero de botones que componen el menu

        Button{
            id: button_1
            iconSource: ""
            visible: true

            width: menu_anim_layout.width*0.20      // ancho del boton (definido anteriormente
            height: menu_anim_layout.height*0.50    // alto del boton
            x:-width-index*2*width                  // posicionamiento inicial (fuera del contenedor, no se ven)
            y:menu_anim_layout.height/2-height/2    // mitad del contenedor

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

            style: ButtonStyle {  // asignamos las propiedades del boton de tipo texto
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

            }   // del buttonStyle

            onClicked: {  // cuando cliekeamos se activa el slot correspondiente, pasand indice y contenedor
                menu_properties.on_button1_clicked(index,contenedor)
            }

            NumberAnimation{   // animación del boton, el tiempo se calcula de manera que siempre se mantenga la distancia entre ellos ( la distancia sería de un botón) aproximadamente
                id:anim
                // loops:Animation.Infinite  //no funciona correctamente
                target:button_1
                property:"x"            // animacion en el eje x (horizontal)
                duration: tiempo_elemento0+calculoTiempo()*index  // se calcula el tiempo de la 1ª animación

                from:-width-index*2*width // lugar desde donde partira el boton, depende del índice (fuera de pantalla)
                to:ancho_pantalla   // recorre toda la pantalla horizontalmente

                onStopped:   {
  // cuando se para, la animación se vuelve activar, inicializando posición inicial y tiempos( para todos igual, justo antes de la pantalla y el mismo tiempo para todos)
                    anim.from=-width
                    anim.duration=tiempo_elemento0
                    anim.running=true  // volvemos a activar animación
                }

            }

             // calulo del tiempo según el indice del boton, debe tardar más o menos en recorrer la distancia,
             // solo la primera vez

            function calculoTiempo(){

                if(index==0)
                    return tiempo_elemento0;
                else
                    return 1/index*((ancho_pantalla+2*ancho_boton*index)*tiempo_elemento0/ancho_pantalla-tiempo_elemento0)
            }

            Component.onCompleted: {   // activamos la animación

                anim.running=true

            }

        }  // del button

    } // del repeater

}  // del item inicial

