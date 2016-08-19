import QtQuick 2.0

Item {
     anchors.fill: parent


    Rectangle {
        color: "#000000"
        anchors.fill: parent
    }

    Image {
            anchors.fill: parent
            fillMode: Image.Tile
            source: "graphics/background.png"
    }
}
