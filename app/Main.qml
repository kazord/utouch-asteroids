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
    backgroundColor: "#282828"

    Item {
        anchors.fill:parent
        //title: i18n.tr("Asteroids")

        Rectangle {
            id: background
            anchors.horizontalCenter: parent.horizontalCenter
            clip:true
            color: "#000000"
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
            Image {
                    anchors.fill: parent
                    fillMode: Image.Tile
                    source: "../../../graphics/background.png"
            }

         /*   Planet {
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
                image:"../../../graphics/planet2_420_525.png"
            }*/


            SpaceCraft {
                id:spacecraft
                color:"transparent"
                x:background.width/2-units.gu(2)
                y:background.height/2-units.gu(2)
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
                    y = spacecraft.y
                }
            }
            SpaceCraft {
                id:spacecraft_shade_mx
                color:"transparent"
                x:spacecraft.x-parent.height
                y:spacecraft.y
                onTick: {
                    x = spacecraft.x-parent.height
                    y = spacecraft.y
                }
            }
            SpaceCraft {
                id:spacecraft_shade_py
                color:"transparent"
                x:spacecraft.x
                y:spacecraft.y+parent.width
                onTick: {
                    x = spacecraft.x
                    y = spacecraft.y+parent.width
                }
            }
            SpaceCraft {
                id:spacecraft_shade_my
                color:"transparent"
                x:spacecraft.x
                y:spacecraft.y-parent.width
                onTick: {
                    x = spacecraft.x
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
               id:gameevent
               interval: 50; running: false; repeat: true
               onTriggered: {
                //asteroids.tick()
                   var levelfinish = true;
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
                           else {//no planet
                               levelfinish = false;
                           }
                       }
                   }


                stick.tick()
                if(levelfinish) {
                    console.log("levelfinish")
                    gamebase.nextlevel()
                }
               }
            }
               Item {
                   id:gamebase
                   property int score: 0
                   property int level: 0
                   property var img: ["../../../graphics/planet1_400_500.png", "../../../graphics/planet2_420_525.png", "../../../graphics/planet3_265_331.png", "../../../graphics/planet4_300_375.png"]
                   signal start()
                   signal nextlevel()
                   signal cleanup()
                   onStart: {
                        cleanup()
                        spacecraft.centerX = background.width/2
                        spacecraft.centerY = background.height/2
                       level = 0
                       nextlevel()
                   }
                   onNextlevel: {
                       spacecraft.centerX = background.width/2
                       spacecraft.centerY = background.height/2
                        level= level+1
                       if(level === 5) {
                           gameevent.stop()
                           restart_msg.text  = "You win !\nRestart ?"
                           restart_msg.visible = true
                            return;
                       }
                       var speed
                       speed = 4+4*level
                       for(var i = 0 ; i < 2+level ; i+=1) {
                            background.createPlanet({"radius":units.gu(4), "centerX": Math.ceil(Math.random() * background.width), "centerY": 0,
                                                    "image": img[level-1],
                                                    "vx":Math.ceil(Math.random() * speed)-speed/2,
                                                    "vy":Math.ceil(Math.random() * speed)-speed/2})
                       }
                   }
                   onCleanup: {
                       for(var obj in background.children) {
                           if((typeof background.children[obj].tick) === "function" && (typeof background.children[obj].hit) !== "function") {
                               background.children[obj].destroy()
                            }
                       }
                   }
               }
        }
        Text {
            id:start_msg
            anchors { top: parent.top; horizontalCenter: parent.horizontalCenter; topMargin:units.gu(20);}
            color: "#ffffff"
            text: "Start"
            scale: 2

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width:parent.width*1.5
                height:parent.height*1.5
                border.width: 1
                border.color: "#ffffff"
                color: "transparent"
                MultiPointTouchArea {
                    anchors.fill: parent
                    onPressed: {
                        start_msg.visible=false
                        gamebase.start()
                        gameevent.start()
                    }
                }
            }
        }
        Text {
            id:restart_msg
            anchors { top: parent.top; horizontalCenter: parent.horizontalCenter; topMargin:units.gu(20);}
            color: "#ffffff"
            text: "Game Over\nRestart ?"
            scale: 2
            visible: false
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width:parent.width*1.5
                height:parent.height*1.5
                border.width: 1
                border.color: "#ffffff"
                color: "transparent"
                MultiPointTouchArea {
                    anchors.fill: parent
                    onPressed: {
                        restart_msg.visible=false
                        gamebase.start()
                        gameevent.start()
                    }
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
                text:"Jmp"
                MultiPointTouchArea {
                    id: ba_click
                    anchors.fill: parent
                    onPressed: {
                        spacecraft.centerX = Math.ceil(Math.random() * background.width)
                        spacecraft.centerY = Math.ceil(Math.random() * background.height)
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
                text:"Fire"
                MultiPointTouchArea {
                    id: bb_click
                    anchors.fill: parent
                    onPressed: {
                        background.fire()

                    }
                }
            }
        }







    }
}

