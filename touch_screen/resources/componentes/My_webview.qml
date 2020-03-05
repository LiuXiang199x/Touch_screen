/********************************My_web.qml*******************
  Recurso web: Recurso que cargaremos cuando recibamos en el mensaje correspondiente al tipo web.
  Carga una página web.
  Se carga de forma dinámica desde contenedor.qml , indicandole las características del recurso.
(mediante la  propiedad fuente, , se tiene una url por defecto
  *******************************/

import QtQuick 2.2
import QtWebView 1.0

WebView {

    property string default_url: "http://www.uji.es"
    property string fuente;

    id: web_view
    anchors.fill: parent
    url:fuente
    visible: true

}
