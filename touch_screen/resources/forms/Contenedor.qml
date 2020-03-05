/*************************contenedor.qml*************************
  Fichero que se utiliza como paso intermedio para cargar el recurso pedido. De esta forma
la aplicación se comportará de forma totalmente dinámica, cargando en cada momento el recurso pedido
en el contenedor adecuado, liberando los recursos que hubiera en dicho contenedor ( se utiliza el
comando Loader de QML, que nos permite gestionar dinámicamente los diferentes componentes al mismo
tiempo que nos permite utilizar instrucciones de anclajes y posicionamiento de estos).
 Para las animaciones se ha implementado dentro del tipo menu con la caaracterística "distribution"
con los valores adecuados. (animX--> animación horizontal , animY --> animacion Vertical)
  ************************/

import QtQuick 2.0

Item {
    id:item_contenedor
    property string tipo:"image"        // tipo de recurso, si es una imagen, un texto, una menu1 etc.
    property string fuente:"../image/default.png"  // indica el source de una imagen, o el texto de un recurso de este tipo etc.
    property int botones              // numero de botones se el caso de que sea un menu
    property string contenedor        // contenedor donde se cargara el recurso
    property string distribution        // distribucion del menu
    property int size_text              // tamaño del texto , para el recurso de customized_text
    property string font_text           // fuente del texto  , para el recurso customized_text
    property string estado              // se utilizada para saber el estado del audio o video

    property int posicion    //########

    property alias e_compo:compo   // para acceder al Loader del recurso desde qml's antereriores
    property string imagen_anterior:"../image/default.png"  // para cargar en el caso del audio

    // para poder cambiar el estado del audio o video ( sin cargarlo de nuevo)


    onEstadoChanged: {

        if (tipo==="audio" || tipo==="video"){

            compo.item.estado=estado
        }

    }


    // se cargar el recurso adecuado, (como se utiliza Loader)liberarandose los recursos anteriores
    // de esta forma practicamente toda la aplicación tiene un caracter dinámico

    Loader {
        id: compo

        Component.onCompleted: {

            if(contenedor==='c_central')
               z=99  // se fuerza a que el contenedor central este siempre por encima del resto
                      // se utiliza fundamentalmente para animaciones

            // activamos el serSource correspondiente al recurso pedido (se define un qml por cada recurso)
            // pasandose los parametros adecuados

            if (tipo==="image") {
                compo.anchors.fill=parent
                compo.setSource("../componentes/Imagen.qml",{"fuente":fuente});
                        }
            if (tipo==="gif"){
                compo.anchors.fill=parent
                compo.setSource("../componentes/Gif.qml",{"fuente":fuente});
            }

            if (tipo==="video") {
                compo.anchors.fill=parent
                //compo.setSource("../componentes/Video.qml",{"fuente":fuente,"estado":estado});
                //compo.item.multimedia_position = m_position     //#######
                compo.setSource("../componentes/Video.qml",{"fuente":fuente,"estado":estado, "posicion":posicion});      //##########
                        }
            if (tipo==="audio") {
                compo.anchors.fill=parent
                compo.setSource("../componentes/Audio.qml",{"audioLayout.source":fuente,"estado":estado,"imagenAudio.source":imagen_anterior, "posicion":posicion});

                }

            if (tipo==="web") {
                compo.anchors.fill=parent
                compo.setSource("../componentes/My_webview.qml",{"fuente":fuente});
            }

            if (tipo==="texto") {
                compo.anchors.centerIn=parent;
                compo.anchors.fill=parent
                compo.setSource("../componentes/Texto.qml",{"fuente":fuente,"size_text":size_text,"font_text":font_text,"contenedor":contenedor});
            }

  // En el caso de menu, hay que distinguir si esta animado ó estatico , y en el primer caso si es
  // horizontal animX ó vertical animY, según la distribution se cargará un recurso u otro

            if (tipo==="menu1") {
                compo.anchors.fill=parent
                if (distribution!="animX" && distribution!="animY")
                    compo.setSource("../componentes/My_button.qml",{"fuente":fuente,"botones":botones,"distribution":distribution,"contenedor":contenedor});
                if (distribution=="animX")
                     compo.setSource("../componentes/My_button_anim.qml",{"fuente":fuente,"botones":botones,"distribution":distribution,"contenedor":contenedor});
                if (distribution=="animY")
                     compo.setSource("../componentes/My_button_anim_Y.qml",{"fuente":fuente,"botones":botones,"distribution":distribution,"contenedor":contenedor});

                                }

        } // de component.onCompletes

    }  // del Loader

}  // del Item
