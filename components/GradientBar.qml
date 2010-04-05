import Qt 4.6

Item {
    id: container
    width: parent.width

    Rectangle {
        id: rectangle
        width: container.width
        height: container.height
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#7C6D5B" }
            GradientStop { position: 0.8; color: "#412D16" }
            GradientStop { position: 1.0; color: "#372612" }
        }
    }
}
