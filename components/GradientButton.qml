import Qt 4.7

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
            color: if (mr.pressed) { Qt.darker("#616569") } else { "#616569" }
        }
        GradientStop {
            position: 0.7
            color: if (mr.pressed) { Qt.darker("#1E2329") } else { "#1E2329" }
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
