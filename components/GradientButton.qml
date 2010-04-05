import Qt 4.6

Rectangle {
    id: container

    signal clicked
    property string text: "Button"
    property alias font: txtItem.font

    smooth: true
    width: txtItem.width + 21
    height: txtItem.height + 8
    border.width: 1
    border.color: "black"
    radius: 8

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: if (mr.pressed) { "#605B56" } else { "#71695F" }
        }
        GradientStop {
            position: 0.7
            color: if (mr.pressed) { "#191308" } else { "#2A1E10" }
        }
    }

    MouseArea {
        id: mr
        anchors.fill: parent
        onClicked: container.clicked()
    }

    Text {
        id: txtItem
        text: container.text
        anchors.centerIn: container
        font.family: fontFamily
        font.pixelSize: buttonFontSize
        font.bold: true
        color: "white"
    }
}
