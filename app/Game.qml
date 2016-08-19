import QtQuick 2.4
import Ubuntu.Components 1.1
import QtMultimedia 5.4

Rectangle {
    anchors.fill: parent
    color: "#282828"

    MultiPointTouchArea {
        anchors.fill: parent
        //here to avoid menu clics
    }


    Rectangle {
        id:playground
        clip:true
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width:(parent.width <= parent.height)? parent.width:parent.height
        height:(parent.width <= parent.height)? parent.width:parent.height
        function createSpriteObjects(myProp) {
            var component = Qt.createComponent("SpaceObject.qml");
            var sprite = component.createObject(playground, myProp);
            if (sprite === null) {
                // Error Handling
                console.log("Error creating object");
            }
        }
        function createPlanet(myProp) {
            var component = Qt.createComponent("Planet.qml");
            var sprite = component.createObject(playground, myProp);
            if (sprite === null) {
                // Error Handling
                console.log("Error creating object");
            }
        }
        function fire() {
            if(spacecraft.ammo < 1)
                return
            else
                spacecraft.ammo -= 1
            sound.fire.play()
            var fire_speed = spacecraft.speed
            var component = Qt.createComponent("FireObject.qml");
            var sprite = component.createObject(playground, {"centerX":spacecraft.centerX+spacecraft.radius*Math.sin(spacecraft.rotation*(Math.PI/180)),
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
        SpaceBackground {}
        SpaceCraft{ id:spacecraft; linear: controls.settings.joy_linear}
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
        Timer {
            id:gameevent
            interval: 50; running: true; repeat: true
            onTriggered: {
                if(Qt.application.state !== Qt.ApplicationActive) {
                    gameevent.stop()
                    gamemenu.state = "pause";
                    gamemenu.visible=true
                    return;
                }

                //asteroids.tick()
                var levelfinish = true;
                for(var obj in playground.children) {
                    if((typeof playground.children[obj].tick) === "function") {

                        if((typeof playground.children[obj].hit) === "function") {
                            playground.children[obj].tick()
                            for(var obj2 in playground.children) {
                                if((typeof playground.children[obj2].centerX) !== "undefined" && obj !== obj2) {
                                    if(Math.sqrt(
                                                (playground.children[obj].centerX-playground.children[obj2].centerX) * (playground.children[obj].centerX-playground.children[obj2].centerX)
                                                +(playground.children[obj].centerY-playground.children[obj2].centerY) * (playground.children[obj].centerY-playground.children[obj2].centerY))
                                            - playground.children[obj].radius - playground.children[obj2].radius <= 0)
                                        playground.children[obj].hit(playground.children[obj2])
                                }
                            }
                        }
                        else {//no planet
                            levelfinish = false;
                        }
                    }
                }
                //planet move in 2nd

                if(controls.buttonB_repeat)
                    playground.fire()

                if(levelfinish) {
                    console.log("levelfinish")
                    sound.lvlup.play()
                    level.nextlevel()
                    gameevent.stop();gamemenu.state = "levelup";gamemenu.visible = true
                }
                else
                {
                    for(var obj in playground.children) {
                        if((typeof playground.children[obj].tick) === "function" && (typeof playground.children[obj].hit) !== "function")
                            playground.children[obj].tick()
                    }
                }

            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: { if(!gamemenu.visible) {gameevent.stop();gamemenu.state = "paused";gamemenu.visible = true}}
        }
    }
    Controls {id:controls
        onButtonBFired: if(gameevent.running) playground.fire()
        onButtonAFired: {if(gameevent.running) {
            sound.jump.play()
            spacecraft.centerX = Math.ceil(Math.random() * playground.width)
            spacecraft.centerY = Math.ceil(Math.random() * playground.height)}}
    }
    GameMenu {id:gamemenu}
    LevelHandler {id:level}
    Label {
        anchors {
            right: parent.horizontalCenter
            top:parent.top
        }
        id: score
        objectName: "score"
        font.pixelSize: units.gu(2)
        font.family: exoFont.name
        horizontalAlignment: Text.AlignHCenter
        text: level.score
        color: "#6CCD6A"
        font.bold: true
    }
    Label {
        anchors {
            right: score.left
            top:parent.top
        }
        id: scoreTxt
        objectName: "score"
        font.pixelSize: units.gu(2)
        font.family: exoFont.name
        horizontalAlignment: Text.AlignHCenter
        text: i18n.tr("Score: ")
        color: "#6CCD6A"
        font.bold: true
    }
    Label {
        anchors {
            left: comboTxt.right
            top:parent.top
        }
        id: combo
        objectName: "score"
        font.pixelSize: units.gu(2)
        font.family: exoFont.name
        horizontalAlignment: Text.AlignHCenter
        text: level.combo
        color: "#6CCD6A"
        font.bold: true
    }
    Label {
        anchors {
            left: parent.horizontalCenter
            top:parent.top
        }
        id: comboTxt
        objectName: "score"
        font.pixelSize: units.gu(2)
        font.family: exoFont.name
        horizontalAlignment: Text.AlignHCenter
        text: i18n.tr("  Combo: ")
        color: "#6CCD6A"
        font.bold: true
    }
    MyAudio {id: sound}
    Component.onCompleted: {level.start();}
}

