import QtQuick 2.0

SpaceObject {
    id:planet
    radius:units.gu(4)
    onTick: {
    }
    Image {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width*1.25
        height:parent.width*1.25
        fillMode: Image.PreserveAspectFit
        source: "../../../graphics/planet1_400_500.png"
    }
}
