/**************************Template7.qml***************
// Plantilla con seis contenedores un  c_background --> fondo
                                       c_upper--> superior
                                       c_central_horiz_1--> central superior 1
                                       c_central_horiz_1--> central superior 2
                                       c_central_horiz_1--> central superior 3
                                       c_lower--> inferior
Ha excepción del central todos toman tamaños determinados ( ancho--> ancho de toda la plantilla
                                                            alto-->15% de la plantilla
                                                            espacios--> 3% de la altura de la plantilla)
  La altura del central horizontal 1 se redimensiona, absorbiendo el espacio del superior si falla. En el caso que falte el inferior, el central_lower se pondra en el lugar
  La altura del central horizontal 3 se redimensiona si falta el c_lower , absorbiendo su espacio.
  El tamaño y anclaje del central horizontal 2 es fijo y anclado en mitad del template.
  No se ha implementado el caso de que falten los dos, el c_upper y el c_lower
//*****************************************************************/

import QtQuick 2.0
import "../Myscripts/creacion_componentes.js" as Ms

Item {
    id: template7
    property string n_contenedor:""     // indica numero de contenedor a actualizar
    property bool actualizar:false      // se utilizara para saber cuando actuali
    property string tipo                // tipo de recurso, si es una imagen, un texto, una menu1 etc.

    property bool b_upper:false         // booleans que nos indican si esta presente ese contenedor o no
    property bool b_lower:false

    property int altura_upper:template7.height*0.15   // tamaño de los contenedores, 15% superior
    property int altura_lower:template7.height*0.15   //                             15% inferior
    property int espacio:template7.height*0.03          // espacio entre contenedores 3%
    property int margen_superior:template7.height*0.03  // margenes superior e inferior 3%

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
        anchors.fill:  template7   // tamaño contenedor de fondo

  }   // fin contenedor c_background


    // carga del contenedor superior

        Loader {
            id : c_upper     //c_upper
            anchors.top:template7.top       //anclamos
            anchors.topMargin: margen_superior
            anchors.horizontalCenter: template7.horizontalCenter

              height:altura_upper   // definimos tamaño ( de ancho asignamos un 60% del total
              width:template7.width  // todo el ancho del template

              // cuando este cargado, asignamos la variable b_upper a true, indicando que hay
              // contenedor superior

               onStatusChanged: if(this.status===Loader.Ready) b_upper=true

    }  // final contenedor c_upper

        // cargador central horizontal1
    Loader {
        id : c_central_horiz_1 // c_central_horizontal_1

        // se fija la anchura del contenedor, la altura y anclajes se fijaran aparte en función
        // de si aparece o no el contenedor superior.

       width:c_background.width

} // final de central_upper

            //cargador del central_horizontal_2
    Loader {
        id : c_central_horiz_2 // c_central_horizontal_2

        // fijamos anclas y dimensiones de este contenedor se considera fijo.
        anchors.verticalCenter: template7.verticalCenter

      height:(template7.height-2*altura_upper-4*espacio-2*margen_superior)/3  // fijamos al altura , y la anchura a la  del template
       width:c_background.width

}  // fin de central_horizontal_2

            //cargador del central_horizontal_3
        Loader {
        id : c_central_horiz_3 // c_central_horizontal_3

            // se fija la anchura del contenedor, la altura y anclajes se fijaran aparte en función
            // de si aparece o no el contenedor inferior.
        width:c_background.width

 }  // fin de central_horizontal_3

        // cargador del contenedor inferior
    Loader {
        id : c_lower    //c_lower
        anchors.bottom: template7.bottom  // anclamos y fijamos bordes
        anchors.bottomMargin: margen_superior
        anchors.horizontalCenter: template7.horizontalCenter  // centramos

        height:altura_lower  // fijamos altura y ancho del contenedor
        width:c_background.width

        // cuando este cargado, asignamos la variable b_lower a true, indicando que hay
        // contenedor inferior

         onStatusChanged: if(this.status===Loader.Ready) b_lower=true
    Component.onCompleted:{

    }

}  // del loader c_lower

 /***************** Asignamos la altura del contenedor central, que variará según tengamos contenedores superior o
inferior, se llama cuando se varia la altura,
   En este caso la función es local y no global (no se situa en el fichero de java script, ya que en
este caso hay que anclar dos contenedores centrales, el horiz_1 y el horiz_3, el horiz_2 se fija
en el centro del template, este caso solo se contempla en este template
   No se contempla el caso de que falten los contenedores superior e inferior a la vez
 */

 function asignarAlturaCentral(){

    if(b_upper && b_lower){  // existe contenedor superior e inferior

        c_central_horiz_1.anchors.top=c_upper.bottom  // asignamos las anclas
        c_central_horiz_1.anchors.topMargin=espacio
        c_central_horiz_1.anchors.bottom=c_central_horiz_2.top  // asignamos las anclas
        c_central_horiz_1.anchors.bottomMargin=espacio

        c_central_horiz_3.anchors.top=c_central_horiz_2.bottom  // asignamos las anclas
        c_central_horiz_3.anchors.topMargin=espacio
        c_central_horiz_3.anchors.bottom=c_lower.top  // asignamos las anclas
        c_central_horiz_3.anchors.bottomMargin=espacio

    }
     if(b_upper && !b_lower){  // No existe el inferior en este template esto es imposible

         c_central_horiz_1.anchors.top=c_upper.bottom  // asignamos las anclas
         c_central_horiz_1.anchors.topMargin=espacio
         c_central_horiz_1.anchors.bottom=c_central_horiz_2.top  // asignamos las anclas
         c_central_horiz_1.anchors.bottomMargin=espacio

         c_central_horiz_3.anchors.top=c_central_horiz_2.bottom  // asignamos las anclas
         c_central_horiz_3.anchors.topMargin=espacio
         c_central_horiz_3.anchors.bottom=c_background.bottom  // asignamos las anclas
         c_central_horiz_3.anchors.bottomMargin=espacio

    }

    if(b_lower && ! b_upper){  // no existe el superior, el central superior coge su espacio

        c_central_horiz_1.anchors.top=c_background.top  // asignamos las anclas
        c_central_horiz_1.anchors.topMargin=espacio
        c_central_horiz_1.anchors.bottom=c_central_horiz_2.top  // asignamos las anclas
        c_central_horiz_1.anchors.bottomMargin=espacio

        c_central_horiz_3.anchors.top=c_central_horiz_2.bottom  // asignamos las anclas
        c_central_horiz_3.anchors.topMargin=espacio
        c_central_horiz_3.anchors.bottom=c_lower.top  // asignamos las anclas
        c_central_horiz_3.anchors.bottomMargin=espacio

      }
 }   // fin de la funcion asignarAltura

 // en esta función se reclacula la altura cada vez que cambiamos el tamaño del template7


onHeightChanged: {

   asignarAlturaCentral();  // recalculamos alturas de los contenedores centrales horiz_1 y horiz_3

}  // de la funcion onHeightChanged

onB_lowerChanged: {

    asignarAlturaCentral();  // si cambia la aparición del contenedor inferior
}

onB_upperChanged: {

    asignarAlturaCentral();  // si cambia la aparición del contenedor superior
}

}   // del Item inicial




