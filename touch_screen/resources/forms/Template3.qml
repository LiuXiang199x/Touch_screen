/**************************Template3.qml***************
// Plantilla con cinco contenedores un  c_background --> fondo
                                       c_upper--> superior
                                       c_model--> lado superior derecho
                                       c_central--> central
                                       c_lower--> inferior
Ha excepción del central todos toman tamaños determinados ( ancho--> ancho de toda la plantilla
                                                            alto-->15% de la plantilla
                                                            espacios--> 3% de la altura de la plantilla)
  La altura del central se redimensiona, absorbiendo el espacio del superior o del inferior si
  alguno de estos falla.( en el caso del superior deben faltar el superior y el modelo)
  No se ha implementado el caso de que falten los dos, el c_upper y el c_lower
//*****************************************************************/

import QtQuick 2.0
import "../Myscripts/creacion_componentes.js" as Ms

Item {
    id: template3
    property string n_contenedor:""    // indicara el numero de contenedor a actualizar
    property bool actualizar:false      // se utilizara para saber cuando actualizar y cuando no
    property string tipo                // tipo de recurso, si es una imagen, un texto, una menu1 etc.

    property bool b_upper:false         // booleans que nos indican si esta presente ese contenedor o no
    property bool b_lower:false


    property int altura_upper:template3.height*0.15  // tamaño de los contenedores, 15% superior
    property int altura_lower:template3.height*0.15  //                             15% inferior
    property int espacio:template3.height*0.03          // espacio entre contenedores 3%
    property int margen_superior:template3.height*0.03   // margenes superior e inferior 3%

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

        // cargamos el contenedor de fondo c_background
    Loader {
        id : c_background   // c_background
        anchors.fill:  template3    // tamaño del contenedor de fondo identico al del template


  }   // fin contenedor c_background

// carga del contenedor superior

        Loader {
            id : c_upper     //c_upper
            anchors.top:template3.top               //  anclamos
            anchors.topMargin: margen_superior
            anchors.horizontalCenter: template3.horizontalCenter // centramos al centro de la plantilla (horizonalmente)

              height:altura_upper       // definimos tamaño ( de ancho asignamos un 60% del total
              width:template3.width*0.60   //60 % de anchora para el contenedor superior tiene que caber el modelo

              // cuando este cargado, asignamos la variable b_upper a true, indicando que hay
              // contenedor superior

             onStatusChanged: if(this.status===Loader.Ready) b_upper=true

    }

        // carga del contenedor modelo c_model, en el lado superior derecha
        Loader {
            id : c_model    //c_model

            anchors.top:template3.top           // definimos los anclajes
            anchors.topMargin: margen_superior
            anchors.left:c_upper.right
            anchors.leftMargin: espacio

            height:altura_upper               // definimos el tamaño
            width:template3.width*0.20-2*espacio  // 20% del ancho total

              // cuando este cargado, asignamos la variable b_upper a true, indicando que hay
              // un contenedor superior (o c_upper o c_model)

              onStatusChanged: if(this.status===Loader.Ready) b_upper=true

    } // fin del c_model

        // carga del contenedor central
    Loader {
        id : c_central   // c_central

      height:0              // fijamos la anchura, la altura y anclaje se fija a posteriori (se redimensionara)
       width:template3.width

} // fin del central

// cargador del contenedor inferior
    Loader {
        id : c_lower    //c_lower
        anchors.bottom: template3.bottom    // anclamos y fijamos margenes
        anchors.bottomMargin: margen_superior

        height:altura_lower     // fijamos altura y anchura
        width:template3.width

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
