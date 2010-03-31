import Qt 4.6
import "GradientBar.qml"
import "GradientButton.qml"
import 'qrc:/scripts/database.js' as DB

Rectangle {
    id: window
    width: 480
    height: 700

    GradientBar {
        id: bar
        height: 81
        width: 480
        anchors.horizontalCenter: window.horizontalCenter
        anchors.top: window.top

        Text {
            id: myText
            font.bold: true
            font.pixelSize: 42
            text: "QtGas"
            color: "white"
            anchors.centerIn: parent
        }
    }

    GradientBar {
        id: bar2
        x: 0
        y: 538
        width: 480
        height: 62
        anchors.horizontalCenter: window.horizontalCenter
        anchors.bottom: window.bottom

        Row {
            spacing: 30
            anchors.centerIn: parent

//            GradientButton {
//                text: "All"
//            }

            GradientButton {
                text: "Gas"
                onClicked: DB.insertGas();
            }

            GradientButton {
                text: "Service"
                onClicked: DB.insertService();
            }
        }
    }

    ListView {
        id: listview1
        clip: true
        anchors.top: bar.bottom
        anchors.bottom: bar2.top
        width: parent.width
        model: myModel
        delegate: delegate
        spacing: 0
    }

    Component {
     id: delegate
     Rectangle {
         id: wrapper
         width: window.width-border.width*2
         height: display.height+display.y*2
         Row {
             id: display
             x: 18; y: 5
             spacing: 5

             Image {
                 source: "qrc:/images/"+type+".png"
                 width: 50
                 height: 50
             }
             Column {
                 Row {
                     Text {
                         text: '<b>'+date+'</b>'
                         font.pixelSize: 23
                         width: 280;
                     }
                     Text {
                         text: '<b>$ '+cost+'</b>'
                         font.pixelSize: 23
                     }
                 }
                 Row {
                     Text {
                         text: (type == 'gas' ? amount+' L' : description)
                         font.pixelSize: 20
                         width: 180;
                         color: 'gray'
                     }
                     Text {
                         text: (type == 'gas' ? Math.round(perunit*100)/100 + ' Km/L' : '')
                         width: 100
                         font.pixelSize: 20
                         color: 'gray'
                     }
                     Text {
                         text: (type == 'gas' ? Math.round((cost / amount)*100)/100 + ' $/L' : '')
                         font.pixelSize: 20
                         color: 'gray'
                     }
                 }
             }
         }
         border.color: "darkgray"
     }
    }

    ListModel {
        id: myModel

        // TODO: is there another way to do this?
        Component.onCompleted: function(){DB.setup(); DB.reloadData();}()
    }
}
