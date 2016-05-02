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
    property bool tickmode: false
    signal tick()
    MultiPointTouchArea {
        anchors.fill: parent
        touchPoints: [
            TouchPoint { id: point1
            onXChanged: {console.log(x)
                if(x < stick.width/2) stick.centerX = stick.width/2
                else if(x > joystick_area.width-stick.width/2) stick.centerX = joystick_area.width-stick.width/2
                else stick.centerX = x}
            onYChanged: {
                console.log(y)
                if(y < stick.height/2) stick.centerY = stick.height/2
               else if(y > joystick_area.height-stick.height/2) stick.centerY = joystick_area.height-stick.height/2
                else stick.centerY = y
            }
            onPressedChanged: {
                if(!pressed) {
                    stick.reset()
                }
            }
            }
        ]
    }
           Circle {
            id: stick
            border.color: "red"
            border.width: 1
            color: "transparent"
            radius: units.gu(10)
            text: "+"
            textSize:units.gu(4)
            /*
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



*/
            signal reset
            onReset: {
                stick.centerX = joystick_area.centerX - joystick_area.x
                stick.centerY = joystick_area.centerY - joystick_area.y
            }
            onXChanged: {
              //  if(x < 0) x = 0
              //  if(x > joystick_area.width-stick.width) x = joystick_area.width-stick.width

                parent.dx = (stick.x+stick.width/2)-(joystick_area.width/2)
            }
            onYChanged: {
              //  if(y < 0) y = 0
               // if(y > joystick_area.height-stick.height) y = joystick_area.height-stick.height
                parent.dy = (stick.y+stick.width/2)-(joystick_area.width/2)
            }


            Component.onCompleted: {reset()}
        }






        onDyChanged: {
            if(!tickmode) {
                direction = Math.atan2(dx, -dy)//* (180 / Math.PI)
                force = Math.sqrt(dx*dx+dy*dy) / ((joystick_area.width-stick.width)/2)
                force -= 0.1
                if(force > 1.0) force = 1.0
                if(force < .0) force = .0
                /*if(force < 0.2) force = 0
                 else force -= 0.2*/
            }


        }
        onDxChanged: {
            if(!tickmode) {
                direction = Math.atan2(dx, -dy)//* (180 / Math.PI)
                force = Math.sqrt(dx*dx+dy*dy) / ((joystick_area.width-stick.width)/2)
                force -= 0.1
                if(force > 1.0) force = 1.0
                if(force < .0) force = .0
                /*if(force < 0.2) force = 0
                else force -= 0.2*/
            }


        }
        onTick: {
             if(tickmode) {
                force = (force+0.01)*-1*dy/((joystick_area.width-stick.width)/2)
                if(force > 1.0) force = 1.0
                direction= direction+dx/((joystick_area.width-stick.width)/2)/2/Math.PI
             }
        }
}
