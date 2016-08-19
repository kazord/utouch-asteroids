import QtQuick 2.0
import Qt.labs.settings 1.0

Item {
    anchors.fill: parent
    property alias settings: controlsSettings
    property alias joystick: joystick_area
    property alias force: joystick_area.force
    property alias direction: joystick_area.direction
    property alias rx: joystick_area.rx
    property alias ry: joystick_area.ry
    signal buttonAFired()
    signal buttonBFired()
    property alias buttonB_repeat: bb_click.repeat

    Settings {
           id: controlsSettings
           category: "Constrols"
           property string joy_state: "LEFT"
           property double joy_size: 13
           property double joy_stickSize: 0.35
           property double joy_bottomMargin: 2
           property double joy_sideMargin: 2
           property bool joy_linear: true

           property double but_bottomMargin: 5
           property double but_sideMargin: 2
           property double but_size: 5
           property string but_state: "RIGHT"

           property string space_direction: "DIR"

    }

    Circle {
        id: joystick_area
        radius: units.gu(controlsSettings.joy_size)
        state: controlsSettings.joy_state
        border.color: "#6CCD6A"
        border.width: 1
        color: "transparent"
        property double direction:0
        property double force:0
        property int dx: 0
        property int dy: 0
        property double rx: 0
        property double ry: 0
        MultiPointTouchArea {
            anchors.fill: parent
            touchPoints: [
                TouchPoint { id: point1
                onXChanged: {
                    if(x < stick.width/2) stick.centerX = stick.width/2
                    else if(x > joystick_area.width-stick.width/2) stick.centerX = joystick_area.width-stick.width/2
                    else stick.centerX = x}
                onYChanged: {
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
        onDyChanged: {
                direction = Math.atan2(dx, -dy)//* (180 / Math.PI)
                force = Math.sqrt(dx*dx+dy*dy) / ((joystick_area.width-stick.width)/2)
                if(force > 1.0) force = 1.0
                if(force < .0) force = .0
                ry = dy/ ((joystick_area.width-stick.width)/2)

        }
        onDxChanged: {
                direction = Math.atan2(dx, -dy)//* (180 / Math.PI)
                force = Math.sqrt(dx*dx+dy*dy) / ((joystick_area.width-stick.width)/2)
                if(force > 1.0) force = 1.0
                if(force < .0) force = .0

                rx = dx/ ((joystick_area.width-stick.width)/2)
         }
       Circle {
        id: stick
        border.color: "purple"
        border.width: 1
        color: "transparent"
        radius: parent.radius*controlsSettings.joy_stickSize
        text: "+"
        textSize:radius

        signal reset
        onReset: {
            stick.centerX = joystick_area.centerX - joystick_area.x
            stick.centerY = joystick_area.centerY - joystick_area.y
        }
        onXChanged: {
            parent.dx = (stick.x+stick.width/2)-(joystick_area.width/2)
        }
        onYChanged: {
            parent.dy = (stick.y+stick.width/2)-(joystick_area.width/2)
        }
        onRadiusChanged: {
            reset()
        }

        Component.onCompleted: {reset()}
    }
       states: [
           State {
               name: "LEFT"
                AnchorChanges {
                   target: joystick_area
                   anchors { bottom: parent.bottom; left: parent.left; right: undefined}
               }
                PropertyChanges {
                    target: joystick_area
                    anchors { bottomMargin: units.gu(settings.joy_bottomMargin); leftMargin:units.gu(settings.joy_sideMargin); rightMargin:0}
                }
           },
           State {
               name: "RIGHT"
                AnchorChanges {
                   target: joystick_area
                   anchors { bottom: parent.bottom; right: parent.right; left: undefined}

               }
                PropertyChanges {
                    target: joystick_area
                    anchors { bottomMargin: units.gu(settings.joy_bottomMargin); rightMargin:units.gu(settings.joy_sideMargin); leftMargin:0}
                }
           }
       ]
  }

    Item {
        id:buttons
        state: controlsSettings.but_state
      //  height:units.gu(30)
       // width:units.gu(30)

        Circle {
            id:button_b
            anchors { bottom: parent.bottom; }
            radius:units.gu(settings.but_size)
            border.color: "#6CCD6A"
            border.width: 1
            color: "transparent"
            text:"Fire"
            MultiPointTouchArea {
                id: bb_click
                anchors.fill: parent
                property bool repeat:false
                onPressed: {
                    buttonBFired()
                    repeat=true
                }
                onReleased: repeat=false
            }
        }
        Circle {
            id:button_a
            anchors { bottom: button_b.top;}
            radius:units.gu(settings.but_size)
            border.color: "#6CCD6A"
            border.width: 1
            color: "transparent"
            text:"Jmp"
            MultiPointTouchArea {
                id: ba_click
                anchors.fill: parent
                onPressed: {
                    buttonAFired()
                }
            }
        }
        states: [
            State {
                name: "LEFT"
                 AnchorChanges {
                    target: buttons
                    anchors { bottom: parent.bottom; left: parent.left; right:undefined}
                }
                 AnchorChanges {
                    target: button_a
                    anchors { left: parent.left; right:undefined}
                }
                 AnchorChanges {
                    target: button_b
                    anchors { left: button_a.right; right:undefined}
                }
                 PropertyChanges {
                     target: buttons
                     anchors { bottomMargin: units.gu(settings.but_bottomMargin); leftMargin:units.gu(settings.but_sideMargin); rightMargin:0}
                 }
            },
            State {
                name: "RIGHT"
                 AnchorChanges {
                    target: buttons
                    anchors { bottom: parent.bottom; right: parent.right; left:undefined }
                }
                 AnchorChanges {
                    target: button_a
                    anchors { right: parent.right; left:undefined}
                }
                 AnchorChanges {
                    target: button_b
                    anchors { right: button_a.left; left:undefined}
                }
                 PropertyChanges {
                     target: buttons
                     anchors { bottomMargin: units.gu(settings.but_bottomMargin); rightMargin:units.gu(settings.but_sideMargin); leftMargin:0}
                 }
            }
        ]
    }
}


