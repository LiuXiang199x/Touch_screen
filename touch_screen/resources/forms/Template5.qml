/**************************Template5.qml***************
// Plantilla con seis contenedores un  c_background --> fondo
                                       c_upper--> superior
                                       c_central_right--> central  derecho
                                       c_central_left-> central izquierda
                                       c_lower--> inferior
Ha excepción del central todos toman tamaños determinados ( ancho--> ancho de toda la plantilla
                                                            alto-->15% de la plantilla
                                                            espacios--> 3% de la altura de la plantilla)
  La altura de los centrales se redimensiona, absorbiendo el espacio del superior o del inferior si
  alguno de estos falla.
  No se ha implementado el caso de que falten los dos, el c_upper y el c_lower
//*****************************************************************/

import QtQuick 2.0
import "../Myscripts/creacion_componentes.js" as Ms

Item {
    id: template5
    property string n_contenedor:""     // indica numero de contenedor a actualizar
    property bool actualizar:false      // se utilizara para saber cuando actuali
    property string tipo                // tipo de recurso, si es una imagen, un texto, una menu1 etc.

    property bool b_upper:false         // booleans que nos indican si esta presente ese contenedor o no
    property bool b_lower:false

    property int altura_upper:template5.height*0.15   // tamaño de los contenedores, 15% superior
    property int altura_lower:template5.height*0.15   //                             15% inferior
    property int espacio:template5.height*0.03          // espacio entre contenedores 3%
    property int margen_superior:template5.height*0.03  // margenes superior e inferior 3%

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
        anchors.fill:  template5   // tamaño contenedor de fondo

  }   // fin contenedor c_background


    // carga del contenedor superior

        Loader {
            id : c_upper     //c_upper
            anchors.top:template5.top       //anclamos
            anchors.topMargin: margen_superior
            anchors.horizontalCenter: template5.horizontalCenter

              height:altura_upper   // definimos tamaño
              width:template5.width  // todo el ancho del template

              // cuando este cargado, asignamos la variable b_upper a true, indicando que hay
              // contenedor superior

            onStatusChanged: if(this.status===Loader.Ready) b_upper=true

    }  // final contenedor c_upper

        // cargador central izquierda
    Loader {
        id : c_central_left   // c_central_izquierda

       anchors.left: template5.left // anclamos al lado izquierda del template5

       height:0  // fijamlos al altura a cero (se recalculara), y la anchura a la mitad del template menos el espacio entre contenedores
       width:c_background.width/2-espacio

} // final de central_leeft

            //cargador del central_derecha
    Loader {
        id : c_central_right   // c_central_derecha

       anchors.right: template5.right // anclamos

      height:0   // fijamlos al altura a cero (se recalculara), y la anchura a la mitad del template menos el espacio entre contenedores
       width:c_background.width/2-espacio

}  // fin de central_derecha

        // cargador del contenedor inferior
    Loader {
        id : c_lower    //c_lower
        anchors.bottom: template5.bottom  // anclamos y fijamos bordes
        anchors.bottomMargin: margen_superior
        anchors.horizontalCenter: template5.horizontalCenter  // centramos

        height:altura_lower  // fijamos altura y ancho del contenedor
        width:c_background.width

        // cuando este cargado, asignamos la variable b_lower a true, indicando que hay
        // contenedor inferior

        onStatusChanged: if(this.status===Loader.Ready) b_lower=true

}  // del loader c_lower

 /***************** Asignamos la altura del contenedor central, que variará según tengamos contenedores superior o
 inferior, se llama cuando se varia la altura,
   En este caso la función es local y no global (no se situa en el fichero de java script, ya que en
  este caso hay que anclar dos contenedores centrales y este caso solo se contempla en este template
   No se contempla el caso de que falten los contenedores superior e inferior a la vez
*/

 function asignarAlturaCentral(){

    if(b_upper && b_lower){  // existe contenedor superior e inferior

        c_central_left.anchors.top=c_upper.bottom  // asignamos las anclas
        c_central_left.anchors.topMargin=espacio
        c_central_left.anchors.bottom=c_lower.top
        c_central_left.anchors.bottomMargin=espacio

        c_central_right.anchors.top=c_upper.bottom
        c_central_right.anchors.topMargin=espacio
        c_central_right.anchors.bottom=c_lower.top
        c_central_right.anchors.bottomMargin=espacio


    }
     if(b_upper && !b_lower){  // No existe el inferior



         c_central_left.anchors.top=c_upper.bottom
         c_central_left.anchors.topMargin=espacio
         c_central_left.anchors.bottom=c_background.bottom
         c_central_left.anchors.bottomMargin=espacio


         c_central_right.anchors.top=c_upper.bottom
         c_central_right.anchors.topMargin=espacio
         c_central_right.anchors.bottom=c_background.bottom
         c_central_right.anchors.bottomMargin=espacio



    }

    if(b_lower && ! b_upper){  // no existe el superior


        c_central_left.anchors.top=c_background.top
        c_central_left.anchors.topMargin=espacio
        c_central_left.anchors.bottom=c_lower.top
        c_central_left.anchors.bottomMargin=espacio

        c_central_right.anchors.top=c_background.top
        c_central_right.anchors.topMargin=espacio
        c_central_right.anchors.bottom=c_lower.top
        c_central_right.anchors.bottomMargin=espacio

      }
 }   // fin de la funcion asignarAltura

 // En estas funciónes se recalculara la altura cada vez que cambiamos el tamaño del template5

onHeightChanged: {

    asignarAlturaCentral();  // Si cambia la altura del template

}  // de la funcion onHeightChanged

onB_lowerChanged: {

    asignarAlturaCentral();  // si cambia la aparición del contenedor inferior
}

onB_upperChanged: {

    asignarAlturaCentral();  // si cambia la aparición del contenedor superior
}

}   // del Item inicial


