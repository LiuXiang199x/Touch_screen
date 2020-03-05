/**************************Template10.qml***************
// Plantilla con seis contenedores un  c_background --> fondo
                                       c_upper--> superior
                                       c_central--> central
                                       c_lower--> inferior
 Template de animación vertical, los botones del menu central, salen por la parte inferior y
avanzan hacia la parte superior, repitiendose el ciclo constantemente.
 Los botones se comportan como menu se pueden pichar sobre ellos y se responderá como un menu
 No se absorve ningún contenedor si este falta. Tamaños no varian (se redimensional cuando se cambia
 el tamaño del template).
 En el ciclo de repetición no se verifica que hayan pasado todos los botones, por lo que se corre
el peligro de solapamiento.
 En la animacion el punto inicial y final son aleatorios, varian de un boton a otro
//*****************************************************************/

import QtQuick 2.0
import "../Myscripts/creacion_componentes.js" as Ms

Item {
    id: template10
    property string n_contenedor:""    // indicara el numero de contenedor a actualizar
    property bool actualizar:false      // se utilizara para saber cunado actualizar y cuando no
    property string tipo                // tipo de recurso, si es una imagen, un texto, una menu1 etc.

    property int altura_upper:template10.height*0.15  // tamaño de los contenedores, 15% superior
    property int altura_lower:template10.height*0.15  //                             15% inferior
    property int espacio:template10.height*0.03          // espacio entre contenedores 3%
    property int margen_superior:template10.height*0.03   // margenes superior e inferior 3%

    anchors.fill:parent    // definimos el tamaño del template igual a del objeto del cual proviene

   // funcion principal que se llama cada vez que cambia la variable actuallizar
    // si la variable actualizar=true, y contenedor es !="" se actualiza el contenedor adecuado

    onActualizarChanged: {

        if (actualizar===true && n_contenedor!=""){

            Ms.cambiarContenedor(n_contenedor,tipo)

        }
        actualizar=false  // actualizado el contenedor , inicializamos la variable otra vez a false.

    }

    // Se definen los diferentes contenedores, de forma dinámica, se utiliza para este fin
    // el componente de qml Loader, que nos permite cargar recursos qml de forma dinámica, liberando
    // los recursos cuando se vuelve a definer la propiedad setSource.

        // cargamos el contenedor de fondo
    Loader {
        id : c_background   // c_background
        anchors.fill:  template10    // tamaño del contenedor de fondo identico al del template

  }   // fin contenedor c_background

// carga del contenedor superior (debe se mas estrecho que en el caso de la plantilla 2)
        Loader {
            id : c_upper     //c_upper
            anchors.top:template10.top               //  anclamos
            anchors.topMargin: margen_superior
            anchors.horizontalCenter: template10.horizontalCenter

              height:altura_upper       // definimos tamaño ( de ancho asignamos un 60% del total
              width:template10.width*0.60   //60 % de anchora para el contenedor superior

    } // fin contenedor c_upper

        // cargador del modelo, en el lado superior derecha
        Loader {
            id : c_model    //c_model

            anchors.top:template10.top           // definimos los anclajes
            anchors.topMargin: margen_superior
            anchors.left:c_upper.right
            anchors.leftMargin: espacio

              height:altura_upper               // definimos el tamaño
              width:template10.width*0.20-2*espacio

    } // fin del c_model

        // cargador central
    Loader {
        id : c_central   // c_central

         anchors.horizontalCenter: template10.horizontalCenter
      height:template10.height             // altura completa de la panatalla
       width:template10.width*0.60   //60 % de anchora para el contenedor central, igual que el superior o el inferior
        z:99  // sobresale por encima del resto

} // fin del central

// cargador del contenedor inferior
    Loader {
        id : c_lower    //c_lower
        anchors.bottom: template10.bottom    // anclamos y fijamos margenes
        anchors.bottomMargin: margen_superior

        height:altura_lower     // fijamos altura y anchura
        width:template10.width

}  // final del loader c_lower

}   // del Item inicial
