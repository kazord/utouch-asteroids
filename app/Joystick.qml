import QtQuick 2.0

Circle {
    id: joystick_area

    border.color: "#ffffff"
    border.width: 1
    color: "transparent"
    property double direction:0
    property double force:0
    property int dx: 0
    property int dy: 0

        Circle {
            id: stick
            border.color: "red"
            border.width: 1
            color: "transparent"
            radius: units.gu(10)
            text: "+"
            textSize:units.gu(4)
            Drag.active: joystickDragArea.drag.active
            Drag.source: joystickDragArea
            Drag.hotSpot.x: width / 2
            Drag.hotSpot.y: height / 2
            MouseArea {
                id: joystickDragArea

                anchors.fill: parent
                drag.target: parent
                drag.minimumX: 0
                drag.minimumY: 0
                drag.maximumX: joystick_area.width-stick.width
                drag.maximumY: joystick_area.height-stick.height
                onReleased: {stick.reset()}
            }




            signal reset
            onReset: {
                stick.centerX = joystick_area.centerX - joystick_area.x
                stick.centerY = joystick_area.centerY - joystick_area.y
            }
            onXChanged: {
                parent.dx = (stick.x+stick.width/2)-(joystick_area.width/2)
                console.log(centerX)
            }
            onYChanged: {
                parent.dy = (stick.y+stick.width/2)-(joystick_area.width/2)
            }


            Component.onCompleted: {reset()}
        }
        onDyChanged: {
            direction = Math.atan2(dx, -dy)//* (180 / Math.PI)
            force = Math.sqrt(dx*dx+dy*dy) / ((joystick_area.width-stick.width)/2)
            if(force > 1.0) force = 1.0
        }
        onDxChanged: {
            direction = Math.atan2(dx, -dy)//* (180 / Math.PI)
            force = Math.sqrt(dx*dx+dy*dy) / ((joystick_area.width-stick.width)/2)
            if(force > 1.0) force = 1.0
        }
}
