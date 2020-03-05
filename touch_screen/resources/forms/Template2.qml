/**************************Template2.qml***************
// Plantilla con cuatro contenedores un  c_background --> fondo
                                       c_upper--> superior
                                       c_central--> central
                                       c_lower--> inferior
Ha excepción del central todos toman tamaños determinados ( ancho--> ancho de toda la plantilla
                                                            alto-->15% de la plantilla
                                                            espacios--> 3% de la altura de la plantilla)
  La altura del central se redimensiona, absorbiendo el espacio del superior o del inferior si
  alguno de estos falla.
  No se ha implementado el caso de que falten los dos, el c_upper y el c_lower
//*****************************************************************/

import QtQuick 2.0
import "../Myscripts/creacion_componentes.js" as Ms

Item {
    id: template2
    property string n_contenedor:""     // indicara el numero de contenedor a actualizar
    property bool actualizar:false       // se utilizara para saber cuando actualizar y cuando no
    property string tipo                 // tipo de recurso, si es una imagen, un texto, una menu1 etc.

    property bool b_upper:false         // variable que se pone a true si hay contenedor superior
    property bool b_lower:false          // variable que se pone a true si hay contenedor inferior

    property int altura_upper:template2.height*0.15 // altura contenedor superior 15% de la altura total
    property int altura_lower:template2.height*0.15  // altura contenedor inferior 15% de la altura total
    property int espacio:template2.height*0.03       // espacio entre contenedores  3% de la altura total
    property int margen_superior:template2.height*0.03  // margen entre los extremos de la plantilla y contenedores

    anchors.fill:parent // al ser la carga dinámica adquirirá el mismo tamaño que su creador

    onActualizarChanged: {

        if (actualizar===true && n_contenedor!=""){
 // si hay que actualizar llamamos a cambiar contenedor, con el tipo de recurso a cargar
            Ms.cambiarContenedor(n_contenedor,tipo)

        }
        actualizar=false

    }

    // Se definen los diferentes contenedores, de forma dinámica, se utiliza para este fin
    // el componente de qml Loader, que nos permite cargar recursos qml de forma dinámica, liberando
    // los recursos cuando se vuelve a definer la propiedad setSource.

     // Contenedor c_background

    Loader {
        id : c_background    // c_background
        anchors.fill:  template2


  }   // fin contenedor c_background

    // contenedor c_upper, contenedor superior

        Loader {
            id : c_upper     //c_upper
            anchors.top:template2.top       // anclamos
            anchors.topMargin: margen_superior

              height:altura_upper  // asignamos la altura y ancho
              width:c_background.width

              // cuando este cargado, asignamos la variable b_upper a true, indicando que hay
              // contenedor superior

                onStatusChanged: if(this.status===Loader.Ready) b_upper=true

    }  // fin del loader de c_upper

        // contenedor c_central, contenedor central

    Loader {
        id : c_central   // c_central

       width:c_background.width  // asignamos la anchora, la altura se asignara dinamicamente

}  // del loader de c_central

    // contenedor c_lower, contenedor inferior

    Loader {
        id : c_lower    //c_lower
        anchors.bottom: template2.bottom    // anclamos el contenedor
        anchors.bottomMargin: margen_superior

        height:altura_lower     // aasignamos la altura y anchura
        width:c_background.width

        // cuando este cargado, asignamos la variable b_lower a true, indicando que hay
        // contenedor inferior

        onStatusChanged: if(this.status===Loader.Ready) b_lower=true

}  // del loader c_lower

// propiedades que cuando cambien, se deberá calcular la altura.

onHeightChanged: {      // si casmbia la altura de la plantilla
    Ms.asignarAlturaCentral();
}

onB_lowerChanged: {     // si cambia la aparición del contenedor inferior
    Ms.asignarAlturaCentral();
}

onB_upperChanged: {     // si cambia la aparición del contenedor superior
    Ms.asignarAlturaCentral();
}

}   // del Item inicial
