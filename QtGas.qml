import Qt 4.6
import "components"
import "views"
import '/scripts/persistence.min.js' as Persistence
import '/scripts/QtGas.js' as QtGas

Rectangle {
    id: appContainer
    width: 480
    height: 660

    Component.onCompleted: {
        QtGas.setup(Persistence.persistence);

        myModel.clear();
        QtGas.Track.all().order('date', false).each(null, function (t) {
            myModel.append(t);
        });
    }

    GradientBar {
        id: topBar
        height: 81
        width: appContainer.width
        anchors.horizontalCenter: appContainer.horizontalCenter
        anchors.top: appContainer.top

        Text {
            id: myText
            font.bold: true
            font.pixelSize: headingFontSize
            text: 'QtGas'
            font.family: fontFamily
            color: "white"
            anchors.centerIn: parent
        }
    }

    GradientBar {
        id: bar2
        x: 0
        width: appContainer.width
        height: 82
        anchors.horizontalCenter: appContainer.horizontalCenter
        anchors.bottom: appContainer.bottom

        Row {
            spacing: 30
            anchors.centerIn: parent

//            GradientButton {
//                text: "All"
//            }

            GradientButton {
                text: "Register fill up"
                onClicked: {
                    fillUpForm.state = 'display'
                    fillUpForm.odometer.value = QtGas.Track.carOdometer();
                }
            }

//            GradientButton {
//                id: btService
//                text: "Service"
//                onClicked: QtGas.newService();
//            }
        }
    }

    FillUpForm {
        id: fillUpForm
    }

//    Dialog {
//        id: dialog
//        anchors.top: listview1.top
//        height: 200
//        width: parent.width
//        z: 99
//
//        Row {
//            Column {
//                x: 2
//                y: 2
//                spacing: 5
//                Text {
//                    text: "Amount: "
//                    width: 50
//                    font.pixelSize: 20
//                    font.bold: true
//                }
//                RoundedTextInput {
//                    text: 'sss'
//                }
//            }
//            GradientButton {
//                y: 100
//                text: "Service"
//                anchors.horizontalCenter: parent.horizontalCenter
//                onClicked: function(){QtGas.newService(input.text);input.focus=false;dialog.close();}()
//            }
//        }
//    }

    ListView {
        id: listview1
        clip: true
        anchors.top: topBar.bottom
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
         width: appContainer.width-border.width*2
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
                         text: '<b>'+Qt.formatDateTime(date, 'MMM d, yyyy')+'</b>'
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
                         text: (type == 'gas' ? units+' L' : description)
                         font.pixelSize: 20
                         width: 150
                         color: 'gray'
                     }
                     Text {
                         text: (type == 'gas' ? distancePerUnit + ' Km/L' : '')
                         width: 130
                         font.pixelSize: 20
                         color: 'gray'
                     }
                     Text {
                         text: (type == 'gas' ? costPerUnit + ' $/L' : '')
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
    }
}
