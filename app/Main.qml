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
            //color: black

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

            Rectangle {
                id:spacecraft
                color:"blue"
                width:units.gu(2)
                height:units.gu(2)
                property double speed: 10
                Timer {
                       interval: 50; running: true; repeat: true
                       onTriggered: {
                           //console.log(stick.direction+" "+stick.force+ " "+parent.speed)
                           spacecraft.x+=Math.sin(stick.direction)*stick.force*parent.speed
                       spacecraft.y-=Math.cos(stick.direction)*stick.force*parent.speed
                       spacecraft.rotation=stick.direction*(180/Math.PI)
                       spacecraft.speed*=1.02*stick.force
                       if(spacecraft.speed < 10)spacecraft.speed=10}
                   }
            }

        }


    }
}

