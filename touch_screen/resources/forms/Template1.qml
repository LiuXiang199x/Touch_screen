//**************************Template1.qml***************
// Plantilla con dos contenedores, un contenedor. c_background de fondo y
// otro c_central centrado en el fondo , el central tiene un 60% de ancho y un 60% de alto que el fondo
//*****************************************************************


import QtQuick 2.0
import "../Myscripts/creacion_componentes.js" as Ms

Item {

    id: template1
    property string n_contenedor:""     // indicara el numero de contenedor a actualizar
    property bool actualizar:false       // se utilizara para saber cuando actualizar y cuando no
    property string tipo            // tipo de recurso, si es una imagen, un texto, una menu1 etc.

    anchors.fill:parent

    onActualizarChanged: {

        if (actualizar===true && n_contenedor!=""){
     // si hay que actualizar llamamos a cambiar contenedor, con el tipo de recurso a cargar
            Ms.cambiarContenedor(n_contenedor,tipo)

        }
        actualizar=false

    }  // de onActualizarChanged

    // Se definen los diferentes contenedores, de forma dinámica, se utiliza para este fin
    // el componente de qml Loader, que nos permite cargar recursos qml de forma dinámica, liberando
    // los recursos cuando se vuelve a definer la propiedad setSource.

     // Contenedor c_background

    Loader {
        id : c_background
        anchors.fill:  template1   // toma todo el tamaño de la plantilla

  }

    // contenedor c_central
    // Ocupa el 60% de ancho y el 60% de alto del contenedor del fondo c_backgrund
    // centrado en el centro de c_background

    Loader {
        id : c_central
       anchors.centerIn: c_background   // centrado en el centro de c_background

       width:c_background.width*0.6     // 60% de alto que el fondo
        height:c_background.height*0.6  // 60% de ancho que el fondo

}

} // DEL ITEM INICIAL
