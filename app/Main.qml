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
            function createPlanet(myProp) {
                var component = Qt.createComponent("Planet.qml");
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
                                                        "rotation":spacecraft.rotation,
                                                        "color": "white"});
                if (sprite === null) {
                    // Error Handling
                    console.log("Error creating object");
                }
            }
            Planet {
                vx:Math.ceil(Math.random() * 8)-4
                vy:Math.ceil(Math.random() * 8)-4
            }
            Planet {
                vx:Math.ceil(Math.random() * 8)-4
                vy:Math.ceil(Math.random() * 8)-4
            }
            Planet {
                vx:Math.ceil(Math.random() * 8)-4
                vy:Math.ceil(Math.random() * 8)-4
            }


            SpaceCraft {
                id:spacecraft
                color:"transparent"
                centerY:background.width/2
                centerX:background.height/2
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
                id:game
               interval: 50; running: true; repeat: true
               onTriggered: {
                //asteroids.tick()
                   for(var obj in background.children) {
                       if((typeof background.children[obj].tick) === "function") {
                           background.children[obj].tick()
                           if((typeof background.children[obj].hit) === "function") {
                                for(var obj2 in background.children) {
                                    if((typeof background.children[obj2].centerX) !== "undefined" && obj !== obj2) {
                                        if(Math.sqrt(
                                                (background.children[obj].centerX-background.children[obj2].centerX) * (background.children[obj].centerX-background.children[obj2].centerX)
                                                +(background.children[obj].centerY-background.children[obj2].centerY) * (background.children[obj].centerY-background.children[obj2].centerY))
                                            - background.children[obj].radius - background.children[obj2].radius <= 0)
                                        background.children[obj].hit(background.children[obj2])
                                    }
                               }
                           }
                       }
                   }


                stick.tick()
               }
           }
        }
        Joystick {
            id:stick
            radius: units.gu(15)
            anchors { bottom: parent.bottom; right: parent.right; bottomMargin: 10; rightMargin:10;}
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
                    onPressed: {
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
                    onPressed: {
                        spacecraft.centerX = Math.ceil(Math.random() * background.width)
                        spacecraft.centerY = Math.ceil(Math.random() * background.height)
                    }
                }
            }
        }







    }
}

