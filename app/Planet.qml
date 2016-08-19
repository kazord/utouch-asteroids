import QtQuick 2.0

MovingObject {
    id:planet
    radius:playground.width/50*4
    property string image: "graphics/planet1_400_500.png"
    property int divcount: 2
    onTick: {
       shadowX0.visible = (centerX+radius > parent.width)
       shadowXMax.visible = (centerX-radius < 0)
       shadowY0.visible = (centerY+radius > parent.height)
       shadowYMax.visible = (centerY-radius < 0)
    }
    Image {
        id:main
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width*1.25
        height:parent.width*1.25
        fillMode: Image.PreserveAspectFit
        source: parent.image
    }
    Image {
        id:shadowX0
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -1*parent.parent.width
//        anchors.verticalCenterOffset: parent.parent.height
        width:parent.width*1.25
        height:parent.width*1.25
        fillMode: Image.PreserveAspectFit
        source: parent.image
    }
    Image {
        id:shadowY0
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.horizontalCenterOffset: parent.parent.width
        anchors.verticalCenterOffset: -1*parent.parent.height
        width:parent.width*1.25
        height:parent.width*1.25
        fillMode: Image.PreserveAspectFit
        source: parent.image
    }
    Image {
        id:shadowXMax
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: parent.parent.width
//        anchors.verticalCenterOffset: parent.parent.height
        width:parent.width*1.25
        height:parent.width*1.25
        fillMode: Image.PreserveAspectFit
        source: parent.image
    }
    Image {
        id:shadowYMax
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.horizontalCenterOffset: parent.parent.width
        anchors.verticalCenterOffset: parent.parent.height
        width:parent.width*1.25
        height:parent.width*1.25
        fillMode: Image.PreserveAspectFit
        source: parent.image
    }

}
