import Qt 4.6

Rectangle {
    id: rectangle

    gradient: Gradient {
        GradientStop { position: 0.0; color: Qt.lighter("#616569") }
        GradientStop { position: 0.5; color: Qt.lighter("#1E2329") }
    }

    color: '#53b401';
}
