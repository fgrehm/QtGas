import Qt 4.7

ListView {
    id: listView
    clip: true
    spacing: 0

    Rectangle {
        color: "black"
        opacity: 0.2; anchors.right: parent.right; anchors.rightMargin:0; width: 8
        y: parent.visibleArea.yPosition * parent.height
        height: parent.visibleArea.heightRatio * parent.height
        radius: 3
        id: scroll
        visible: listView.moving
    }
}
