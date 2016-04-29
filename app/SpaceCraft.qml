import QtQuick 2.0

SpaceObject {
    id:spacecraft

    radius:units.gu(2)
    property double minspeed: units.gu(1)
    property double speed: units.gu(1)
    property double maxspeed: units.gu(1)*8
    onTick: {
        vx = Math.sin(stick.direction)*stick.force*speed
        vy = -1* Math.cos(stick.direction)*stick.force*speed
        if(vx != 0 && vy != 0) {
            rotation = stick.direction*(180/Math.PI)
            //spacecraft_img_moving.visible = true
        }
        else {
            //spacecraft_img_moving.visible = false
        }

        speed*=1.02*stick.force
        if(speed < minspeed) speed=minspeed
        if(speed > maxspeed) speed=maxspeed
        spacecraft_img_moving.opacity = stick.force
    }

    Circle {
        radius:parent.radius*1.5
        anchors.top: parent.Top
        anchors.horizontalCenter: parent.horizontalCenter
        color:"transparent"
        Image {
            id:spacecraft_img
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            //width: parent.width;
            clip:false
            source: "../../../graphics/spaceship.png"
        }
        Image {
            id:spacecraft_img_moving
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            opacity: 0
            width: parent.width;
            source: "../../../graphics/spaceship_moving.png"
        }
    }


}
