import Qt 4.7
import "components"
import "views"
import '/scripts/persistence.min.js' as Persistence
import '/scripts/QtGas.js' as QtGas

Rectangle {
    id: appContainer
    width: parent ? parent.width : 480
    height: parent ? parent.height : 800

    function reload() {
        myModel.clear();
        QtGas.currentCar.tracks.order('date', false).each(null, function (t) {
            myModel.append(t);
        });
    }

    Component.onCompleted: {
        QtGas.setup(Persistence.persistence, function() {
            if (QtGas.currentCar.odometer != 0) {
                reload();
            } else {
                carForm.odometer = QtGas.currentCar.odometer;
                carForm.show();
            }
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

        GradientButton {
            text: "Close"
            font.pixelSize: headingButtonFontSize
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5
            onClicked: mainDialog.close();
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
                    fillUpForm.resetValues();
                    fillUpForm.state = 'display';
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

    CarForm {
        id: carForm
    }

    ListView {
        id: listview1
        clip: true
        anchors.top: topBar.bottom
        anchors.bottom: bar2.top
        width: parent.width
        model: myModel
        delegate: delegate
        spacing: 0

        Rectangle {
            color: "black"
            opacity: 0.4; anchors.right: listview1.right; anchors.rightMargin:2; width: 6
            y: listview1.visibleArea.yPosition * listview1.height
            height: listview1.visibleArea.heightRatio * listview1.height
        }
    }

    Component {
     id: delegate
     Rectangle {
         id: wrapper
         width: appContainer.width-border.width*2
         height: display.height+display.y*2
         border.color: "darkgray"
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
                         width: wrapper.width - 200
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
                         width: wrapper.width - 340
                         color: 'gray'
                     }
                     Text {
                         text: (type == 'gas' ? distancePerUnit + ' Km/L' : '')
                         width: 140
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
     }
    }

    ListModel {
        id: myModel
    }
}
