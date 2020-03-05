import QtQuick 2.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

Item {

    id: menu_button_layout
    anchors.fill: parent
    anchors.margins: parent.height/64
    visible: false
    property alias bu1:button_1
    property alias bu2:button_2
    property alias bu3:button_3
    property alias bu4:button_4
    property alias bu5:button_5
    property alias menu_button_layout:menu_button_layout
    property alias menu_grid:menu_grid


    property string button_distribution: menu_properties && menu_properties !== undefined ? menu_properties.button_distribution : ""
    //property alias button_height:button_height

     property string texto1;
     property string texto2;
     property variant textos:[];

    property int button_height: 0
    property int grid_columns: 1


  Component.onCompleted: {
//      textos.push(texto1);
//      textos.push(texto2);

      //debug
      //       multimedia_properties.on_mostrar_string("dentro de menu fuente "+button_1.width);
               multimedia_properties.on_mostrar_string("texto1 en menu "+textos.length+" primer :"+button_height);

  }



  onButton_distributionChanged: {
      var column_par
      var rows = IntValidator
      switch(button_distribution){
      case "grid":
          grid_columns = 2
          column_par = num_buttons%menu_grid.columns
          if(column_par===0){
              rows = num_buttons/menu_grid.columns
          }else{
              rows = (num_buttons/menu_grid.columns)
              rows = Math.round(rows)
          }
          button_height = menu_button_layout.height/rows - menu_button_layout.anchors.margins
          break;
      case "column":
      default:
          grid_columns = 1
          button_height = menu_button_layout.height/num_buttons - menu_button_layout.anchors.margins
          break;
      }

      multimedia_properties.on_mostrar_string("texto1 en menu "+textos.length+" primer :"+button_height);
  }
    Grid{
              id: menu_grid
              spacing: menu_button_layout.anchors.margins
              anchors.centerIn: parent
              columns: grid_columns
        Button{
            id: button_1
            iconSource: ""
            visible: false
            width: menu_button_layout.width/Math.min(menu_grid.columns, num_buttons) - menu_grid.spacing
            height: button_height

//            Image {
//                anchors.fill: parent

//               source:  (multimedia_path + button1_obj.icon)

//                opacity: parent.pressed ? 0.5 : 1
//            }

            style: ButtonStyle {
                label: Text {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Helvetica"
                    text:   button1_obj.text

                //    text:menu_button_layout.textos[0]
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 10
                    font.pixelSize: 128
                }
            }

            onClicked: {
                menu_properties.on_button1_clicked("contenedor 1")
                  multimedia_properties.on_mostrar_string("num botones en menu "+num_buttons+" texto : "+ menu_button_layout.textos[0])

            }

        }

        Button{
            id: button_2
            iconSource: ""
            visible: false
            width: menu_button_layout.width/Math.min(menu_grid.columns, num_buttons) - menu_grid.spacing
            height: button_height

//            Image {
//                anchors.fill: parent
//                source:  (multimedia_path + button2_obj.icon)
//                opacity: parent.pressed ? 0.5 : 1
//            }

            style: ButtonStyle {
                label: Text {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Helvetica"
                    text: button2_obj.text
                  //  text:menu_button_layout.textos[1]
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 10
                    font.pixelSize: 128
                }
            }

            onClicked: {
                menu_properties.on_button2_clicked()
            }

        }

        Button{
            id: button_3
            iconSource: ""
            visible: false
            width: menu_button_layout.width/Math.min(menu_grid.columns, num_buttons) - menu_grid.spacing
            height: button_height

            Image {
                anchors.fill: parent
                source:  (multimedia_path + button3_obj.icon)
                opacity: parent.pressed ? 0.5 : 1
            }

            style: ButtonStyle {
                label: Text {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Helvetica"
                    text: button3_obj.text
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 10
                    font.pixelSize: 128
                }
            }

            onClicked: {
                menu_properties.on_button3_clicked()
            }

        }

        Button{
            id: button_4
            iconSource: ""
            visible: false
            width: menu_button_layout.width/Math.min(menu_grid.columns, num_buttons) - menu_grid.spacing
            height: button_height

            Image {
                anchors.fill: parent
                source:  (multimedia_path + button4_obj.icon)
                opacity: parent.pressed ? 0.5 : 1
            }

            style: ButtonStyle {
                label: Text {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Helvetica"
                    text: button4_obj.text
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 10
                    font.pixelSize: 128
                }
            }

            onClicked: {
                menu_properties.on_button4_clicked()
            }


        }

        Button{
            id: button_5
            visible: false
            width: menu_button_layout.width/Math.min(menu_grid.columns, num_buttons) - menu_grid.spacing
            height: button_height

            Image {
                anchors.fill: parent
                source:  (multimedia_path + button5_obj.icon)
                opacity: parent.pressed ? 0.5 : 1
            }

            style: ButtonStyle {
                label: Text {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Helvetica"
                    text: button5_obj.text
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 10
                    font.pixelSize: 128
                }
            }

            onClicked: {
                menu_properties.on_button5_clicked()
            }


        }  //de button

    }  // de column

}  // del item inicial
