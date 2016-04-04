import QtQuick 2.0

Circle {
    id: joystick_area
    radius: units.gu(15)
    color: "#ffffff"
    property double direction:0
    property double force:0
    property int dx: 0
    property int dy: 0

        Circle {
            id: stick
            color: "red"
            radius: units.gu(10)

            Drag.active: joystickDragArea.drag.active
            Drag.source: joystickDragArea
            Drag.hotSpot.x: width / 2
            Drag.hotSpot.y: height / 2
            MouseArea {
                id: joystickDragArea

                anchors.fill: parent
                drag.target: parent
                drag.minimumX: joystick_area.x
                drag.minimumY: joystick_area.y
                drag.maximumX: joystick_area.x+joystick_area.width-stick.width
                drag.maximumY: joystick_area.y+joystick_area.width-stick.width
                onReleased: {stick.reset()}
            }



            signal reset
            onReset: {
                stick.centerX = joystick_area.centerX
                stick.centerY = joystick_area.centerY
            }
            onXChanged: {
                parent.dx = (stick.x+stick.width/2)-(joystick_area.x+joystick_area.width/2)
            }
            onYChanged: {
                parent.dy = (stick.y+stick.width/2)-(joystick_area.y+joystick_area.width/2)
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
