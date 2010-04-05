import Qt 4.6
import "../components"
import '/scripts/persistence.min.js' as Persistence
import '/scripts/QtGas.js' as QtGas

Rectangle {
    id: form
    width: parent.width
    height: parent.height
    y: parent.height
    color: 'lightyellow'
    z: 10
    property var odometer: odometer

    states: [
        State {
            name: 'display'
            PropertyChanges{
                target: form
                y: 0
            }
        }
    ]

    transitions: [
         Transition {
             NumberAnimation { properties: "y"; duration: 300 }
         }
     ]

     GradientBar {
         id: topBar
         height: 81
         width: appContainer.width
         anchors.top: parent.top

         GradientButton {
             text: "Cancel"
             font.pixelSize: headingButtonFontSize
             onClicked: form.state = '';
             anchors.verticalCenter: parent.verticalCenter
             anchors.left: parent.left;
             anchors.leftMargin: 5
         }

         Text {
             id: myText
             font.bold: true
             font.pixelSize: headingFontSize
             text: 'New Fill Up'
             font.family: fontFamily
             color: "white"
             anchors.centerIn: parent
         }

         GradientButton {
             text: "Save"
             font.pixelSize: headingButtonFontSize
             anchors.verticalCenter: parent.verticalCenter
             anchors.right: parent.right;
             anchors.rightMargin: 5
             onClicked: {
                 var track = QtGas.createFillUp({
                     cost: cost.floatValue(),
                     odometer: odometer.floatValue(),
                     units: litres.floatValue(),
                     costPerUnit: costPerLitre.floatValue()
                 });
                 myModel.insert(0, track);
                 form.state = '';
             }
         }
     }

     Column {
         id: layout
         spacing: 25

         anchors.top: topBar.bottom
         anchors.topMargin: 10
         anchors.bottom: parent.bottom

         anchors.left: parent.left
         anchors.leftMargin: 10

         anchors.right: parent.right
         anchors.rightMargin: 10

         function hasValue(field) {
             return field.value != '' && field.floatValue() > 0;
         }

         RoundedTextInput {
             id: odometer
             label: 'Odometer (Km)'
             width: parent.width
             maximumLength: 6
             value: '54460'
         }

         RoundedTextInput {
             id: litres
             label: 'Litres'
             width: parent.width
             value: '50'
             onValueChanged: {
                 if (!parent.hasValue(litres)) return;

                 if (parent.hasValue(cost))
                     costPerLitre.value = cost.floatValue() / litres.floatValue();
                 else if (parent.hasValue(costPerLitre))
                     cost.value = litres.floatValue() * costPerLitre.floatValue();
             }
         }

         RoundedTextInput {
             id: cost
             label: 'Total Cost'
             width: parent.width
             value: '100'
             onValueChanged: {
                 if (!parent.hasValue(cost)) return;

                 if (parent.hasValue(litres))
                     costPerLitre.value = cost.floatValue() / litres.floatValue();
                 else if (parent.hasValue(costPerLitre))
                     litres.value = cost.floatValue() / costPerLitre.floatValue();
             }
         }

         RoundedTextInput {
             id: costPerLitre
             label: 'Cost / Litre'
             width: parent.width
             value: '2'
             onValueChanged: {
                 if (!parent.hasValue(costPerLitre)) return;

                 if (parent.hasValue(litres))
                     cost.value = litres.floatValue() * costPerLitre.floatValue();
                 else if (parent.hasValue(cost))
                     litres.value = cost.floatValue() / costPerLitre.floatValue();
             }
         }
     }
}

