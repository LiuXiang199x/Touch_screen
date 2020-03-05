/**************************Template4.qml***************
// Plantilla con seis contenedores un  c_background --> fondo
                                       c_upper--> superior
                                       c_central--> central
                                       c_lower_right-> modelo inferior derecho
                                       c_lower_left-> modelo inferior izquierda
                                       c_lower--> inferior
Ha excepción del central todos toman tamaños determinados ( ancho--> ancho de toda la plantilla
                                                            alto-->15% de la plantilla
                                                            espacios--> 3% de la altura de la plantilla)
  La altura del central se redimensiona, absorbiendo el espacio del superior o del inferior si
  alguno de estos falla.( en el caso del inferior deben faltar el inferior y ambos modelos)
  No se ha implementado el caso de que falten los dos, el c_upper y el c_lower
//*****************************************************************/

import QtQuick 2.0
import "../Myscripts/creacion_componentes.js" as Ms

Item {
    id: template4
    property string n_contenedor:""    // indicara el numero de contenedor a actualizar
    property bool actualizar:false      // se utilizara para saber cunado actualizar y cuando no
    property string tipo                // tipo de recurso, si es una imagen, un texto, una menu1 etc.

    property bool b_upper:false         // booleans que nos indican si esta presente ese contenedor o no
    property bool b_lower:false

    property int altura_upper:template4.height*0.15  // tamaño de los contenedores, 15% superior
    property int altura_lower:template4.height*0.15  //                             15% inferior
    property int espacio:template4.height*0.03          // espacio entre contenedores 3%
    property int margen_superior:template4.height*0.03   // margenes superior e inferior 3%

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
        anchors.fill:  template4    // tamaño del contenedor de fondo identico al del template

  }   // fin contenedor c_background

// carga del contenedor superior
        Loader {
            id : c_upper     //c_upper
            anchors.top:template4.top               //  anclamos
            anchors.topMargin: margen_superior
            anchors.horizontalCenter: template4.horizontalCenter

              height:altura_upper       // definimos tamaño ( de ancho asignamos un 60% del total
              width:template4.width*0.80   //80 % de anchora para el contenedor superior

              // cuando este cargado, asignamos la variable b_upper a true, indicando que hay
              // contenedor superior

        onStatusChanged: if(this.status===Loader.Ready) b_upper=true

    }  // fin cargado c_upper

        // cargador del modelo inferior derecha, en el lado inferior derecha
        Loader {
            id : c_lower_right    //c_lower_right

            anchors.bottom: template4.bottom           // definimos los anclajes
            anchors.bottomMargin: margen_superior
            anchors.right:template4.right
            anchors.rightMargin: espacio

              height:altura_lower              // definimos el tamaño
              width:template4.width*0.20-2*espacio

              // cuando este cargado, asignamos la variable b_lower a true, indicando que hay
              // un contenedor inferior

               onStatusChanged: if(this===Loader.Ready) b_lower=true

    } // fin del modelo inferior derecha

        // cargador del modelo inferior izquierda, en el lado inferior izquierda
        Loader {
            id : c_lower_left   //c_lower_right

            anchors.bottom: template4.bottom           // definimos los anclajes
            anchors.bottomMargin: margen_superior
            anchors.left:template4.left
            anchors.leftMargin: espacio

              height:altura_lower               // definimos el tamaño
              width:template4.width*0.20-2*espacio

              // cuando este cargado, asignamos la variable b_lower a true, indicando que hay
              // un contenedor inferior

    onStatusChanged: if(this.status===Loader.Ready) b_lower=true

    } // fin del modelo inferior izquierda

        // cargador central
    Loader {
        id : c_central   // c_central
      height:0       // fijamos altura (0) y anchura, la altura y anclaje se fija a posteriori
       width:template4.width



} // fin del central

// cargador del contenedor inferior
    Loader {
        id : c_lower    //c_lower
        anchors.bottom: template4.bottom    // anclamos y fijamos margenes
        anchors.bottomMargin: margen_superior
        anchors.horizontalCenter: template4.horizontalCenter  // centramos

        height:altura_lower     // fijamos altura y anchura
        width:template4.width *0.60     //  60 % del ancho total (hay dos contenedores

        // cuando este cargado, asignamos la variable b_lower a true, indicando que hay
        // un contenedor inferior

        onStatusChanged: if(this.status===Loader.Ready) b_lower=true

}  // final del loader c_lower

 // en esta función se recalcula la altura cada vez que cambie algún parametro

onHeightChanged: {

    Ms.asignarAlturaCentral();  //si cambia la altura del template
}

onB_lowerChanged: {

    Ms.asignarAlturaCentral();  // si cambia la aparición del contenedor inferior
}

onB_upperChanged: {

    Ms.asignarAlturaCentral();  // si cambia la aparición del contenedor superior
}

}   // del Item inicial
