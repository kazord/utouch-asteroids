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

    width: units.gu(50)
    height: units.gu(75)


    Item {
        anchors.fill:parent
        //title: i18n.tr("Asteroids")

        Rectangle {
            id: background
            clip:true
            color: "#282828"
            height: units.gu(50)
            width: units.gu(50)
            x:0
            function createSpriteObjects(myProp) {
                var component = Qt.createComponent("SpaceObject.qml");
                var sprite = component.createObject(background, myProp);
                if (sprite === null) {
                    // Error Handling
                    console.log("Error creating object");
                }
            }
            function fire() {
                var fire_speed = spacecraft.minspeed*1.5
                var component = Qt.createComponent("FireObject.qml");
                var sprite = component.createObject(background, {"centerX":spacecraft.centerX+spacecraft.radius*Math.sin(spacecraft.rotation*(Math.PI/180)),
                                                        "centerY":spacecraft.centerY-spacecraft.radius*Math.cos(spacecraft.rotation*(Math.PI/180)),
                                                        "vy":-fire_speed*Math.cos(spacecraft.rotation*(Math.PI/180)),
                                                        "vx":fire_speed*Math.sin(spacecraft.rotation*(Math.PI/180)),
                                                        "color": "white"});
                if (sprite === null) {
                    // Error Handling
                    console.log("Error creating object");
                }
            }
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



            SpaceCraft {
                id:spacecraft
                color:"transparent"
                y:100
            }
            SpaceCraft {
                id:spacecraft_shade_px
                color:"transparent"
                x:spacecraft.x+parent.height
                y:spacecraft.y
                onTick: {
                    x = spacecraft.x+parent.height
                }
            }
            SpaceCraft {
                id:spacecraft_shade_mx
                color:"transparent"
                x:spacecraft.x-parent.height
                y:spacecraft.y
                onTick: {
                    x = spacecraft.x-parent.height
                }
            }
            SpaceCraft {
                id:spacecraft_shade_py
                color:"transparent"
                x:spacecraft.x
                y:spacecraft.y+parent.width
                onTick: {
                    y = spacecraft.y+parent.width
                }
            }
            SpaceCraft {
                id:spacecraft_shade_my
                color:"transparent"
                x:spacecraft.x
                y:spacecraft.y-parent.width
                onTick: {
                    y = spacecraft.y-parent.width
                }
            }
            /*SpaceObject {
                id:asteroids
                centerX: units.gu(20)
                centerY: units.gu(32)
                vx: 10
                vy: -3
            }*/

            Timer {
               interval: 50; running: true; repeat: true
               onTriggered: {
                //asteroids.tick()
                   for(var obj in background.children) {
                       if((typeof background.children[obj].tick) === "function")
                           background.children[obj].tick()
                   }

                //spacecraft.tick()
               }
           }
        }
        Joystick {
            id:stick
            radius: units.gu(15)
            anchors { bottom: parent.bottom; right: parent.right; bottomMargin: 10; rightMargin:10;}
            //y:parent.height
            //x:parent.width
            onForceChanged: {joyF.update(force)}
            onDirectionChanged: {joyDir.update(direction)}
            onDxChanged: {joyX.update(dx)}
            onDyChanged: {joyY.update(dy);}
            /*Component.onCompleted: {stick.x = stick.parent.width - stick.width;
                stick.y = stick.parent.height - stick.height;
                console.log(stick.parent.height)}*/
        }
        Item {
             anchors { bottom: parent.bottom; left: parent.left; bottomMargin: 10; rightMargin:10;}
            height:units.gu(30)
            width:units.gu(30)
            Circle {
                id:button_a
                anchors { top: parent.top; left: parent.left;}
                radius:units.gu(5)
                border.color: "#ffffff"
                border.width: 1
                color: "transparent"
                text:"A"
                MultiPointTouchArea {
                    id: ba_click
                    anchors.fill: parent
                    onPressed: {console.log("a fired");

                        background.fire()
                    }
                }
            }
            Circle {
                id:button_b
                anchors { top: button_a.bottom; left: button_a.right;}
                radius:units.gu(5)
                border.color: "#ffffff"
                border.width: 1
                color: "transparent"
                text:"B"
                MultiPointTouchArea {
                    id: bb_click
                    anchors.fill: parent
                    onPressed: {console.log("b fired");spacecraft.color = "red";background.createSpriteObjects({"x":50, "y":50, "vy":10.0, "vx":100.4})}
                }
            }
        }







    }
}

