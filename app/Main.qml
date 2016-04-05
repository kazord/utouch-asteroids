import QtQuick 2.0
import Ubuntu.Components 1.1

/*!
    \brief MainView with Tabs element.
           First Tab has a single Label and
           second Tab has a single ToolbarAction.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "asteroids.kazord"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(100)
    height: units.gu(75)


    Page {
        title: i18n.tr("Asteroids")

        Rectangle {
            id: background
            color: "#c8c8c8"
            height: units.gu(75)
            width: units.gu(75)
            x:units.gu(12.5)

            Text {
                id: joyX
                color: "black"
                y:units.gu(10)
                x:units.gu(40)

                text: "X:"
                signal update(int new_x)
                onUpdate: {text = "X:"+new_x}
            }

            Text {
                id: joyY
                color: "black"
                y:units.gu(40)
                x:units.gu(10)

                text: "Y:"
                signal update(int new_y)
                onUpdate: {text = "Y:"+new_y}
            }
            Text {
                id: joyDir
                color: "black"
                y:units.gu(40)
                x:units.gu(40)

                text: "Dir:"
                signal update(double new_dir)
                onUpdate: {text = "Dir:"+new_dir}
            }
            Text {
                id: joyF
                color: "black"
                y:units.gu(50)
                x:units.gu(40)

                text: "F:"
                signal update(double new_dir)
                onUpdate: {text = "F:"+new_dir}
            }

            Joystick {
                id:stick
                onForceChanged: {joyF.update(force)}
                onDirectionChanged: {joyDir.update(direction)}
                onDxChanged: {joyX.update(dx)}
                onDyChanged: {joyY.update(dy)}

            }

            SpaceObject {
                id:spacecraft
                color:"blue"
                y:100
                radius:units.gu(2)

                //height:units.gu(2)
                property double minspeed: 5
                property double speed: 5
                property double maxspeed: 50
                onTick: {
                    vx = Math.sin(stick.direction)*stick.force*speed
                    vy = -1* Math.cos(stick.direction)*stick.force*speed
                    rotation = stick.direction*(180/Math.PI)
                    speed*=1.02*stick.force
                    if(speed < minspeed) speed=minspeed
                    if(speed > maxspeed) speed=maxspeed
                }


            }
            SpaceObject {
                id:asteroids
                centerX: units.gu(20)
                centerY: units.gu(32)
                vx: 10
                vy: -3
            }
            Timer {
               interval: 50; running: true; repeat: true
               onTriggered: {
                asteroids.tick()
                spacecraft.tick()
               }
           }


        }


    }
}

