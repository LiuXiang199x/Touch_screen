import QtQuick 2.2
import QtQuick.Window 2.2
import QtQuick.Controls 1.3

Window {
    width: 800
    height: 600
    title: 'Error: Missing file'
    visible: true
    color: "black"

    Label {
        text: 'Missing /sdcard/ros_config.xml file \nPlease, check if file exists in the specified path \nand if the file has not got syntax errors.'
        anchors.centerIn: parent
        font.pixelSize: 50
        color: "crimson"
    }

    MultiPointTouchArea{

        anchors.fill: parent
        minimumTouchPoints: 1
        maximumTouchPoints: 1
        touchPoints: [

            TouchPoint {
                id: touch

                onPressedChanged: {
                    if (pressed) {
                        Qt.quit()
                    }
                }

            }

        ]

    }


}
