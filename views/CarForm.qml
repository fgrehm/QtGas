import Qt 4.7
import "../components"
import '../scripts/persistence.min.js' as Persistence
import '../scripts/QtGas.js' as QtGas

Dialog {
    id: form
    anchors.centerIn: parent
    property alias odometer: odometer.value

    contentWidth: 470
    contentHeight: 240

    Column {
        anchors.fill: parent
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        spacing: 20

        StyledText {
            text: "Please enter current odometer"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        RoundedTextInput {
            id: odometer

            anchors.horizontalCenter: parent.horizontalCenter

            label: 'Odometer (Km)'
            width: parent.width - 20

            maximumLength: 6

            validator: IntValidator{}
        }

        GradientButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: 'Save and close'
            anchors.bottom: parent.bottom
            onClicked: {
                QtGas.setCurrentCarOdometer(odometer.value, true);
                form.close();
            }
        }
    }
}
