import QtQuick 2.0

SpaceObject {
    id:planet
    radius:units.gu(4)
    property string image: "../../../graphics/planet1_400_500.png"
    onTick: {
    }
    Image {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width*1.25
        height:parent.width*1.25
        fillMode: Image.PreserveAspectFit
        source: parent.image
    }

}
