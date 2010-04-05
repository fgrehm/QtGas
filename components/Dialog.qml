import Qt 4.6

Rectangle {
    id: page
    function close() {
        page.closed();
        page.opacity = 0;
    }
    function show() {
        page.opacity = 1;
    }
    signal closed();
    color: "lightyellow"
    border.width: 1
    opacity: 0
    Behavior on opacity {
        NumberAnimation { duration: 500 }
    }
}
