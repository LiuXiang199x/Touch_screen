/********************************Imagen.qml*******************
  Recurso imagen: Recurso que cargaremos cuando recibamos en el mensaje correspondiente al tipo image.
  Carga una imagen.
  Se carga de forma dinámica desde contenedor.qml , indicandole el source del recurso. (mediante la
  propiedad fuente, por defecto se cargaría el logotipo.)
  *******************************/

import QtQuick 2.2


Image {
    property string fuente:"../imagen/default.png";  // url de la imagen aa mostrar 
    id: imagen_2
    fillMode: Image.PreserveAspectFit  // preserva el aspecto de la imagen
    //fillMode:Image.Stretch              // ocupa todo el contenedor
    source: fuente
    visible: true


    onStatusChanged:
    {
        if (imagen_2.status == Image.Ready){
            msg_publisher.on_image_loaded();
        }
    }

}




