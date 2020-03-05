
//*******************creacion_componentes.js
// libreria JavaScript utilizada para ampliar el proyecto touch_screen.
// Realizado por : Sara Marqués Villarroya
// Proyecto Final de Master
// Funciones Implementadas:
//      crearTemplate()
//      asignarTexto()
//      asignIcon()
//      cambiarContenedor()
//      cargar_b()
//      sacarDistribucion()
//      sacarColumnas()
//      asignarAltura()
//      asignarAlturaCentral()
// Variables Globales:
//      audio_video
//      imagen_anterior1
//***********************************************************************

//********************crearTemplate ***********************
// Parametros: n_template: Qstring indicando el numero de la plantilla a cargar
// Devuelve: Nada
// Descripción: Simplemente activa la propiedad setSource del Loader carga_template con el qml
//              que contiene la plantilla a cargar
//*******************************************************************************


function crearTemplate(n_template){

    
     carga_template.setSource("../forms/Template"+n_template+".qml");

}

//********************asignarTexto ***********************
// Parametros: index--> indice del boton que hay que mostrar
// Devuelve: texto que debe mostrar el boton cuando se enseñe por pantalla
// Descripción: Devuelve el texto que debe mostrar el boton (si es un boton de texto) indicado en el
//              button_design , cuando se creo el menu, para ello lee la lista creada en la clase
//              menu_properties para el contenedor correspondiente
//*******************************************************************************


function asignarTexto(index){

    switch(contenedor){   // seleccionamos el contenedor ( variable global  que contiene el contenedor actual)
    case "c_background":
  //  default:
//Leemos de la lista correspondiente esta propiedad
         return (menu_properties.objButtonListBackground[index].text);
    case "c_central":
          return menu_properties.objButtonListCenter[index].text;
    case "c_upper":
          return menu_properties.objButtonListUpper[index].text;
    case "c_lower":
          return menu_properties.objButtonListLower[index].text;
    case "c_lower_right":
          return menu_properties.objButtonListLowerRight[index].text;
    case "c_lower_left":
          return menu_properties.objButtonListLowerLeft[index].text;
    case "c_model":
          return menu_properties.objButtonListModel[index].text;
    case "c_central_right":
          return menu_properties.objButtonListCenterRight[index].text;
    case "c_central_left":
          return menu_properties.objButtonListCenterLeft[index].text;
    case "c_central_upper":
          return menu_properties.objButtonListCenterUpper[index].text;
    case "c_central_lower":
          return menu_properties.objButtonListCenterLower[index].text;
    case "c_central_horiz_1":
          return menu_properties.objButtonListCenterHoriz1[index].text;
    case "c_central_horiz_2":
          return menu_properties.objButtonListCenterHoriz2[index].text;
    case "c_central_horiz_3":
          return menu_properties.objButtonListCenterHoriz3[index].text;
    }

}

//********************asignarIcon ***********************
// Parametros: index--> indice del boton que hay que mostrar
// Devuelve: la ruta de la imagen que habría que mostrar,
// Descripción: Devuelve la ruta de la imagen que debe mostrar el boton (si es un boton tipo icon)
//    indicado en el button_design , cuando se creo el menu, para ello lee la lista creada en la clase
//    menu_properties para el contenedor correspondiente. Si es de tipo texto , devuelve la ruta de la
//      imagen por defecto (despues no se mostrara)
//*******************************************************************************

function asignIcon(index){

    switch(contenedor){  // seleccionamos contenedor

    case "c_background":
//    default:

        if (menu_properties.objButtonListBackground[index].type !== "icon"){
              // si es de tipo text devolvemos la ruta de la imagen por defecto
                    return "../image/default.png"
        }else{
              // si el boton es de tipo icon, devolvemos la ruta completa de la imagen a mostrar
            return (multimedia_path + menu_properties.objButtonListBackground[index].icon);
        }

    case "c_central":
        if (menu_properties.objButtonListCenter[index].type !== "icon"){

                return "../image/default.png"
        }else{

            return (multimedia_path + menu_properties.objButtonListCenter[index].icon);
        }

    case "c_upper":
        if (menu_properties.objButtonListUpper[index].type !== "icon"){

                return "../image/default.png"
        }else{

           return (multimedia_path + menu_properties.objButtonListUpper[index].icon);
        }

    case "c_lower":
        if (menu_properties.objButtonListLower[index].type !== "icon"){

                return "../image/default.png"
        }else{

          return (multimedia_path + menu_properties.objButtonListLower[index].icon);
        }
    case "c_lower_right":
        if (menu_properties.objButtonListLowerRight[index].type !== "icon"){

                return "../image/default.png"
        }else{

          return (multimedia_path + menu_properties.objButtonListLowerRight[index].icon);
        }
    case "c_lower_left":
        if (menu_properties.objButtonListLowerLeft[index].type !== "icon"){

                return "../image/default.png"
        }else{

          return (multimedia_path + menu_properties.objButtonListLowerLeft[index].icon);
        }
    case "c_model":
        if (menu_properties.objButtonListModel[index].type !== "icon"){

                return "../image/default.png"
        }else{

          return (multimedia_path + menu_properties.objButtonListModel[index].icon);
        }
    case "c_central_right":
        if (menu_properties.objButtonListCenterRight[index].type !== "icon"){

                return "../image/default.png"
        }else{

          return (multimedia_path + menu_properties.objButtonListCenterRight[index].icon);
        }
    case "c_central_left":
        if (menu_properties.objButtonListCenterLeft[index].type !== "icon"){

                return "../image/default.png"
        }else{

          return (multimedia_path + menu_properties.objButtonListCenterLeft[index].icon);
        }
    case "c_central_upper":
        if (menu_properties.objButtonListCenterUpper[index].type !== "icon"){

                return "../image/default.png"
        }else{

          return (multimedia_path + menu_properties.objButtonListCenterUpper[index].icon);
        }
    case "c_central_lower":

        if (menu_properties.objButtonListCenterLower[index].type !== "icon"){

                return "../image/default.png"
        }else{

          return (multimedia_path + menu_properties.objButtonListCenterLower[index].icon);
        }
    case "c_central_horiz_1":
        if (menu_properties.objButtonListCenterHoriz1[index].type !== "icon"){

                return "../image/default.png"
        }else{

          return (multimedia_path + menu_properties.objButtonListCenterHoriz1[index].icon);
        }
    case "c_central_horiz_2":
        if (menu_properties.objButtonListCenterHoriz2[index].type !== "icon"){

                return "../image/default.png"
        }else{

          return (multimedia_path + menu_properties.objButtonListCenterHoriz2[index].icon);
        }
    case "c_central_horiz_3":
        if (menu_properties.objButtonListCenterHoriz3[index].type !== "icon"){

                return "../image/default.png"
        }else{

          return (multimedia_path + menu_properties.objButtonListCenterHoriz3[index].icon);
        }

    }
}

// *****************************variable audio_video
// Tipo: arrays de objetos
// Descripcion: Nos indicará si un componenten del tipo audio o video se esta ejecutando en el
//          contenedor correspondiente, necesario para poder implementar correctamente las funcionalidades de
//          "pause" "play" y "stop
//*******************************************************

var audio_video={c_background:"false",c_central:"false",c_upper:"false",c_lower:"false",c_model:"false",
    c_central_upper:"false",c_central_lower:"false",
    c_central_horiz_1:"false", c_central_horiz_2:"false", c_central_horiz_3:"false",
    c_central_lower_left:"false",c_central_lower_right:"false",
    c_central_left:"false",c_central_right:"false"};

//***********************cambiarContenedor**************************************
// Parametros: n_contenedor--> nombre del contenedor que se va a cargar
//             tipo: tipo de recurso que se cargara
// Devuelve:Nada
// Descripción: Carga el contenedor, con el recurso adecuado -image, texto,audio,video,web o menu1
//      para ello llama a una función complementaria que será la encargada de realizar la carga.
//***********************************************************************************

function cambiarContenedor(n_contenedor,tipo){

    // actualizo el array de objetos de audio_video

    //if(inicializarAudioVideo===true)
            audio_video[n_contenedor]=multimedia_properties.send_player;

  switch (n_contenedor){  // se elige el contenedor adecuado

  case "c_background":

      cargar_b(c_background,tipo,n_contenedor);
      break;

  case "c_central":

      cargar_b(c_central,tipo,n_contenedor);
      break;

  case "c_upper":

      cargar_b(c_upper,tipo,n_contenedor);
      break;

  case "c_lower":

      cargar_b(c_lower,tipo,n_contenedor);
      break;

  case "c_lower_right":

      cargar_b(c_lower_right,tipo,n_contenedor);
      break;

  case "c_lower_left":

      cargar_b(c_lower_left,tipo,n_contenedor);
      break;

  case "c_central_right":

      cargar_b(c_central_right,tipo,n_contenedor);
      break;

  case "c_central_left":

      cargar_b(c_central_left,tipo,n_contenedor);
      break;

  case "c_central_upper":

      cargar_b(c_central_upper,tipo,n_contenedor);
      break;

  case "c_central_lower":

      cargar_b(c_central_lower,tipo,n_contenedor);
      break;

  case "c_central_horiz_1":

      cargar_b(c_central_horiz_1,tipo,n_contenedor);
      break;

  case "c_central_horiz_2":

      cargar_b(c_central_horiz_2,tipo,n_contenedor);
      break;

  case "c_central_horiz_3":

      cargar_b(c_central_horiz_3,tipo,n_contenedor);
      break;

  case "c_model":

      cargar_b(c_model,tipo,n_contenedor);
      break;

   }  // DEL SWITCH

// actualizamos audio_video

  audio_video[n_contenedor]= (tipo==="audio" || tipo==="video") ? true : false ;

 }  // DE FUNCTION de cambiarContenedor

// *****************variable imagen_anterior1
// Descripción: Se utiliza para cargar la imagen anterior si se carga un audio. ( mientrar suena
// el audio se mostraría la última imagen cargada

var imagen_anterior1;

//***********************carga_br**************************************
// Parametros: b--> contenedor que se va a cargar (objeto contenedor)
//             tipo-->tipo de recurso que se cargara
//             n_contenedor-> QString que muestra el nombre del contenedor a cargar
// Devuelve:Nada
// Descripción: Función complementara a "cambiaContenedor",sarga el contenedor, con el recurso adecuado -image, texto,audio,video,web o menu1
//      activando la función setSource del contenedor adecuado ( que se presenta como un Loader).
//***********************************************************************************


function cargar_b(b,tipo,n_contenedor){
    // elegimos el tipo de recurso a cargar
    switch(tipo){

    case "menu1":
        // se cargará un menu, cargamos el qml Contenedor.qml activando las propiedades adecuadas

         b.setSource("../forms/Contenedor.qml",{"tipo":tipo,"botones":menu_properties.num_buttons,"distribution":menu_properties.button_distribution,"contenedor":n_contenedor});
        break;

    case "image":
         // se cargará una imagen, cargamos el qml Contenedor.qml activando las propiedades adecuadas

        b.setSource("../forms/Contenedor.qml",{"tipo":tipo,"fuente":multimedia_full_file_path});
        //guardamos la imagen por si despues se ponen una audio se mostraría esta imagen.

        imagen_anterior1=multimedia_full_file_path;
       break;

    case "gif":
        b.setSource("../forms/Contenedor.qml",{"tipo":tipo,"fuente":multimedia_full_file_path});
        break;

    case "video":

        // si hay uno ejecutandose, no se carga sino que se cambia el estado (pause, play o stop)
        if ( audio_video[n_contenedor]===true){
                b.item.e_compo.item.estado=estado_video // composición de objetos para definir el estado del audio o video
    }
        else
            // se cargará un video, cargamos el qml Contenedor.qml activando las propiedades adecuadas
                //b.setSource("../forms/Contenedor.qml",{"tipo":tipo,"fuente":fuente_video,"estado":estado_video}); //##########
                b.setSource("../forms/Contenedor.qml",{"tipo":tipo,"fuente":fuente_video,"estado":estado_video, "posicion":position});   //#######
       break;
    case "audio":

         // si hay uno ejecutandose, no se carga sino que se cambia el estado (pause, play o stop)
        if ( audio_video[n_contenedor]===true){
            b.item.e_compo.item.estado=estado_audio

        }
        else{
            // se cargará un audio, cargamos el qml Contenedor.qml activando las propiedades adecuadas
                b.setSource("../forms/Contenedor.qml",{"tipo":tipo,"fuente":fuente_audio,"estado":estado_audio,"imagen_anterior":imagen_anterior1, "posicion":position});    //#######
  }
            break;
    case "texto":
        // se cargará un texto, cargamos el qml Contenedor.qml activando las propiedades adecuadas

         b.setSource("../forms/Contenedor.qml",{"tipo":tipo,"fuente":text_properties.customized_text,"size_text":text_properties.size_text,"font_text":text_properties.font_text,"contenedor":n_contenedor});
        break;
    case "web":
        // se cargará una web, cargamos el qml Contenedor.qml activando las propiedades adecuadas
         b.setSource("../forms/Contenedor.qml",{"tipo":tipo,"fuente":url});
        break;
    }  // fin del switch

} // fin de carga_b

//***********************sacarDistribucion()**************************************
// Parametros: dis--> distribucion del menu que se mostrar por pantalla
// Devuelve:devuelve la distribución (grid o column) que se mostrará por pantalla
// Descripción: Función que separa el parámetro "distribution" construido cuando se ha creado el menu
//     devolviendo en esta función el primer parámetro (grid o column o anim)
//***********************************************************************************

function sacarDistribucion(dis){
    var a=dis.split(";");           // separamos los dos parámetros de distrobution
    return a.slice(0,1).toString() ;    // devolvemos el primero

}

//***********************sacarColumnas()**************************************
// Parametros: dis--> distribucion del menu que se mostrar por pantalla
// Devuelve:devuelve numero de ccolumnas que se mostrará por pantalla
// Descripción: Función que separa el parámetro "distribution" construido cuando se ha creado el menu
//     devolviendo en esta función el segundo parámetro numero de columnas
//***********************************************************************************

function sacarColumnas(dis){
    var a=dis.split(";");
    return a.slice(1,2).toString();  // devolvemos el segundo parámetro
}

//***********************asignarAltura()**************************************
// Parametros: distri--> distribucion del menu que se mostrar por pantalla
//             n_botones--> numero de botones que tiene el menu
// Devuelve:altura que debe tener el botón para que el menu encaje bien en el contenedor
// Descripción: Función que calcula la altura de los diferentes botones, para ello calcula
//      el numero de columnas que debera tener el menu, y lo divide entre la altura del menu_layout
//              Función que se ha implementado a fin de hacer compatible la presente aplicación con la
//      aplicación anterior
//***********************************************************************************

function asignarAltura(distri,n_botones){
    var column_par,alto         // si es para o impar el numero de columnas, y el valor de alto de los botones que devolveremos
    var rows = IntValidator
    var distribucion,columnas

    distribucion=Ms.sacarDistribucion(distribution)  // miramos si es grid o column
    columnas=Ms.sacarColumnas(distribution)     // numero de columnas que debemos poner

    switch(distribucion){  // segun la distribucion
    case "grid":
        if (columnas==="")      // por defecto se tomaran dos columnas ( so
            grid_columns = 2
        else
            grid_columns=parseInt(columnas)   // pasamos a entero
        column_par = num_buttons%menu_grid.columns   // miramos si el numero de columnas es para
        if(column_par===0){
            rows = num_buttons/menu_grid.columns   // calculamos el numero de filas que debe tener
        }else{
            rows = (num_buttons/menu_grid.columns)   // si es impar redondeamos
            rows = Math.ceil(rows)
        }
        alto = menu_button_layout.height/rows - menu_button_layout.anchors.margins  // calculamos alto de las filas (botones)


        break;

    case "column":   // version antigua del programa, se mantiene por compatibilidad
    default:
        grid_columns = 1   // solo una columna, caculamos el alto de las filas.
        alto = menu_button_layout.height/num_buttons - menu_button_layout.anchors.margins
        break;
    }

    return alto   // devolvemos el valor del alto de las filas

}  // fin de la función asignarAltura()

//***********************asignarAlturaCentral()**************************************
// Parametros: Nada
// Devuelve:Nada
// Descripción: Función que ancla el contenedor central de diferentes plantillas, segun
// aparezcan o no los contenedores superiores e inferiores.
//              Algunas plantillas esta función es interna a la plantilla por tener peculiaridades
//   que aconsejan mantenerlas internas (aparecen varios contenedores centrales etc.)
//              Incluso algunas plantillas, no utilizan la reasignación , por carecer de sentido
//    tal reasignación devido a la propia naturaleza de la plantilla
//***********************************************************************************


function asignarAlturaCentral(){


   if(b_upper && b_lower){  // si aparecen el contenedor superior e inferior

// se ancla a la parte inferior del contenedor superior y a la parte superior del contenedor inferior

       c_central.anchors.top=c_upper.bottom
       c_central.anchors.topMargin=espacio

       c_central.anchors.bottom=c_lower.top
       c_central.anchors.bottomMargin=espacio

   }
    if(b_upper && !b_lower){        // si aparece el contenedor superior pero no el inferior

// se ancla a la parte inferior del contenedor superior y a la parte inferior del background

        c_central.anchors.top=c_upper.bottom
        c_central.anchors.topMargin=espacio

        c_central.anchors.bottom=c_background.bottom
        c_central.anchors.bottomMargin=espacio


   }

   if(b_lower && ! b_upper){        // aparece el inferior pero no el superior

// se ancla a la parte superior del background y a la parte superior del contenedor inferior

       c_central.anchors.top=c_background.top
       c_central.anchors.topMargin=espacio

       c_central.anchors.bottom=c_lower.top
       c_central.anchors.bottomMargin=espacio


     }

}  // fin de la función asignarAlturaCentral()

function error_screen_function(){
    carga_template.setSource("../forms/Template0.qml");
}

