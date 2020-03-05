/**************************Template8.qml***************
// Plantilla con seis contenedores un  c_background --> fondo
                                       c_upper--> superior
                                       c_central_upper--> central superior 1
                                       c_central_lower--> central superior 2
                                       c_lower--> inferior
Ha excepción del central inferior todos toman tamaños determinados ( ancho--> ancho de toda la plantilla
                                                            alto-->15% de la plantilla
                                                            espacios--> 3% de la altura de la plantilla)
  En este caso el central inferior se redimesionara , siendo el tamaño del resto de los conteendores
  fijo (15% de la plantilla , respecto  a la altura y de ancho el de la plantilla), la altura del
  central inferior se ajustará al resto de contenedores (central superior e inferior)
  En este caso se ha supuesto que siempre aparecerán el superior e inferior.
//*****************************************************************/

import QtQuick 2.0
import "../Myscripts/creacion_componentes.js" as Ms

Item {
    id: template8
    property string n_contenedor:""     // indica numero de contenedor a actualizar
    property bool actualizar:false      // se utilizara para saber cuando actuali
    property string tipo:"image"                // tipo de recurso, si es una imagen, un texto, una menu1 etc.

    property bool b_upper:false         // booleans que nos indican si esta presente ese contenedor o no
    property bool b_lower:false         // en esta plantilla no se utilizan

    property int altura_upper:template8.height*0.15   // tamaño de los contenedores, 15% superior
    property int altura_lower:template8.height*0.15   //                             15% inferior
    property int espacio:template8.height*0.03          // espacio entre contenedores 3%
    property int margen_superior:template8.height*0.03  // margenes superior e inferior 3%

    anchors.fill:parent     // definimos el tamaño del template igual a del objeto del cual proviene

    // funcion principal que se llama cada vez que cambia la variable actuallizar
     // si la variable actualizar=true, y contenedor es !="" se actualiza el contenedor adecuado

    onActualizarChanged: {

        if (actualizar===true && n_contenedor!=""){

            Ms.cambiarContenedor(n_contenedor,tipo)

        }
        actualizar=false    // actualizado el contenedor , inicializamos la variable otra vez a false.

    }

    // Se definen los diferentes contenedores, de forma dinámica, se utiliza para este fin
    // el componente de qml Loader, que nos permite cargar recursos qml de forma dinámica, liberando
    // los recursos cuando se vuelve a definer la propiedad setSource.

         // cargamos el contenedor de fondo
    Loader {
        id : c_background    // c_background
        anchors.fill:  template8   // tamaño contenedor de fondo

  }   // fin contenedor c_background

    // carga del contenedor superior

        Loader {
            id : c_upper     //c_upper
            anchors.top:template8.top       //anclamos
            anchors.topMargin: margen_superior
            anchors.horizontalCenter: template8.horizontalCenter

              height:altura_upper   // definimos tamaño
              width:template8.width  // todo el ancho del template

    }  // final contenedor c_upper

        // cargador central superior
    Loader {
        id : c_central_upper   // c_central_izquierda

       anchors.top: c_upper.bottom // anclamos al lado izquierda del template8
       anchors.topMargin: espacio

      height:altura_lower  // // fijamos al altura a la que tienen los contenedores upper y lower y la anchura a la  del template
       width:c_background.width

} // final de central_upper

            //cargador del central_inferior
    Loader {
        id : c_central_lower   // c_central_inferior

       anchors.bottom: c_lower.top // anclamos - se fijara la altura a la posición de los contenedores
       anchors.bottomMargin: espacio
       anchors.top:c_central_upper.bottom
       anchors.topMargin: espacio

 // fijamos lo ancho y la altura  se fija con las anclas definidas

       width:c_background.width

}  // fin de central_inferior

        // cargador del contenedor inferior
    Loader {
        id : c_lower    //c_lower
        anchors.bottom: template8.bottom  // anclamos y fijamos bordes
        anchors.bottomMargin: margen_superior
        anchors.horizontalCenter: template8.horizontalCenter  // centramos

        height:altura_lower  // fijamos altura y ancho del contenedor
        width:c_background.width

}  // del loader c_lower

}   // del Item inicial




