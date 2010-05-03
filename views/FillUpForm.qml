import Qt 4.7
import "../components"
import '../scripts/persistence.min.js' as Persistence
import '../scripts/QtGas.js' as QtGas

Rectangle {
    id: form
    width: parent.width
    height: parent.height
    y: parent.height
    color: 'lightyellow'
    z: 10

    function resetValues() {
        odometer.value = QtGas.currentCar.odometer;

        distancePerUnit.value =
        litres.value =
        costPerLitre.value =
        cost.value = '';
    }


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
             id: btnCancel
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
             font.pixelSize: headingFontSize-3
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
             width: btnCancel.width
             onClicked: {
                 var track = QtGas.createFillUp({
                     cost: cost.floatValue(),
                     odometer: odometer.floatValue(),
                     units: litres.floatValue(),
                     costPerUnit: costPerLitre.floatValue()
                 });
                 Persistence.persistence.flush(null, function(){
                     form.state = '';
                     myModel.insert(0, track);
                 });
             }
         }
     }

     Flickable {
         anchors.top: topBar.bottom

         anchors.bottom: parent.bottom

         clip: true

         width: form.width
         contentWidth: form.width
         contentHeight: layout.height

         Column {
             id: layout
             spacing: 25

             anchors.top: parent.top
             anchors.topMargin: 20

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
                 onValueChanged: {
                     if (!parent.hasValue(odometer)) return;

                     if (parent.hasValue(litres))
                        distancePerUnit.value = ((odometer.floatValue() - QtGas.currentCar.odometer) / litres.floatValue()).toFixed(3);
                 }

                 validator: IntValidator{}
             }

             RoundedTextInput {
                 id: litres
                 label: 'Litres'
                 width: parent.width
                 onValueChanged: {
                     if (!parent.hasValue(litres)) return;

                     if (parent.hasValue(cost))
                         costPerLitre.value = (cost.floatValue() / litres.floatValue()).toFixed(2);
                     else if (parent.hasValue(costPerLitre))
                         cost.value = (litres.floatValue() * costPerLitre.floatValue()).toFixed(2);

                     if (!parent.hasValue(odometer)) return;

                     distancePerUnit.value = ((odometer.floatValue() - QtGas.currentCar.odometer) / litres.floatValue()).toFixed(3);
                 }

                 validator: DoubleValidator{}
             }

             RoundedTextInput {
                 id: cost
                 label: 'Total Cost'
                 width: parent.width
                 onValueChanged: {
                     if (!parent.hasValue(cost)) return;

                     if (parent.hasValue(litres))
                         costPerLitre.value = (cost.floatValue() / litres.floatValue()).toFixed(2);
                     else if (parent.hasValue(costPerLitre))
                         litres.value = (cost.floatValue() / costPerLitre.floatValue()).toFixed(3);
                 }

                 validator: DoubleValidator{}
             }

             RoundedTextInput {
                 id: costPerLitre
                 label: 'Cost / Litre'
                 width: parent.width
                 onValueChanged: {
                     if (!parent.hasValue(costPerLitre)) return;

                     if (parent.hasValue(litres))
                         cost.value = (litres.floatValue() * costPerLitre.floatValue()).toFixed(2);
                     else if (parent.hasValue(cost))
                         litres.value = (cost.floatValue() / costPerLitre.floatValue()).toFixed(3);
                 }

                 validator: DoubleValidator{}
             }

             RoundedTextInput {
                 id: distancePerUnit
                 label: 'Km / Litre'
                 width: parent.width
                 enabled: false
             }
         }
     }
}

