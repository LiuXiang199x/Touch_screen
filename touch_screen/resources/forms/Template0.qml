//**************************Template0.qml***************
// Plantilla con único contenedor. c_background,
//*****************************************************************

import QtQuick 2.0
import "../Myscripts/creacion_componentes.js" as Ms

Item {
    id: template0
    property string tipo   // tipo de recurso, si es una imagen, un texto, una menu1 etc.
    property string n_contenedor // indicara el numero de contenedor a actualizar
    property bool actualizar      // se utilizara para saber cuando actualizar y cuando no
    property bool error_connection

    onActualizarChanged: {

        // si hay que actualizar llamamos a cambiar contenedor, con el tipo de recurso a cargar

        if(actualizar===true){
            Ms.cambiarContenedor(n_contenedor,tipo)  // función que se encuentra en creacion_componentes de javascript
        }
    actualizar=false  // inicializamos la variable para próximas actualizaciones

    }

    onError_connectionChanged: {
        if(error_connection===true){
            c_background.setSource("Contenedor.qml",{"tipo":"text","fuente":"Error de conexión","size_text":15,"font_text":"Helvetica","contenedor":"c_background"});

        }
    error_connection=false
    }

    // Se definen los diferentes contenedores, de forma dinámica, se utiliza para este fin
    // el componente de qml Loader, que nos permite cargar recursos qml de forma dinámica, liberando
    // los recursos cuando se vuelve a definer la propiedad setSource.

    // Contenedor c_background
    // Unico contenedor de fondo.

    Loader {
        id : c_background   // contenedor a actualizar
        anchors.fill : parent  // toma toda la plantalla como la plantillas



    Component.onCompleted:{

        c_background.setSource("Contenedor.qml");  // en este caso se carga el unico contenedor
    }

}

}
