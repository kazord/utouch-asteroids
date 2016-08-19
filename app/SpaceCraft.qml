import QtQuick 2.0

MovingObject {
    id:spacecraft
   // property double minspeed: units.gu(1)
    property double speed: parent.width/50
   // property double maxspeed: units.gu(1)*8
    property double sizeRatio: 0.022
    property double ammo: 1
    property bool linear: true
    signal hit(var cible)
    onHit: {
        if((typeof cible.hit) === "function")//spacecraft or another fire
            return
        sound.over.play()
        level.over();


        //restart_msg.text = "Game Over\nRestart ?"
        //restart_msg.visible = true

    }
    state: controls.settings.space_direction

    radius:(parent.width < parent.height)? parent.width*sizeRatio : parent.height*sizeRatio

   /* signal hit(var cible)
    onHit: {
        if((typeof cible.hit) === "function")//spacecraft or another fire
            return
        console.log("gotcha");
        gameevent.stop()
        restart_msg.text = "Game Over\nRestart ?"
        restart_msg.visible = true

    }*/
    function moveAbs() {
        //vx = Math.sin(controls.direction)*speed*controls.force*controls.force
        //vy = -1* Math.cos(controls.direction)*speed*controls.force*controls.force
        if(linear) {
            vx = Math.sin(controls.direction)*speed*controls.force
            vy = -1* Math.cos(controls.direction)*speed*controls.force
            if(controls.force !== 0) {
                rotation = controls.direction*(180/Math.PI)
            }

            spacecraft_img_moving.opacity = controls.force
        }
        else {
            var newforce = (Math.max(controls.force-0.33,0))*3/2
            vx = Math.sin(controls.direction)*speed*newforce
            vy = -1* Math.cos(controls.direction)*speed*newforce
            if(controls.force !== 0) {
                rotation = controls.direction*(180/Math.PI)
            }

            spacecraft_img_moving.opacity = newforce
        }
    }
    function moveRel() {
        var correlation = 1
        if(!linear)
            correlation = (1+controls.ry*controls.ry)/(1+controls.rx*controls.rx)
        rotation += controls.rx*15*Math.min(1/correlation,1)
//        vx = -1*Math.sin(rotation*Math.PI/180)*speed*controls.ry*controls.ry*controls.ry
//        vy =  Math.cos(rotation*Math.PI/180)*speed*controls.ry*controls.ry*controls.ry
        vx = -1*Math.sin(rotation*Math.PI/180)*speed*controls.ry*Math.min(correlation,1)
        vy =  Math.cos(rotation*Math.PI/180)*speed*controls.ry*Math.min(correlation,1)
        if(controls.rx < 0) {
            vx=vx/2
            vy=vy/2
        }

        spacecraft_img_moving.opacity = controls.ry*controls.ry*Math.min(correlation,1)
    }
    function move() {
        if(state === "DIR")
            moveAbs()
        else
            moveRel()
    }

    //onTick: moveAbs()
    onTick: {move()
        if(ammo < 1)
            ammo+=10/50
       // sound.rocket.volume = controls.force
        //sound.rocket.play()
    }



       /* else {
        }
        if(speed < minspeed) speed=minspeed
        speed*=1.005*stick.force
        if(speed > maxspeed) speed=maxspeed
        speed = stick.force*maxspeed*2/3

        spacecraft_img_moving.opacity = stick.force
    }*/

    Circle {
        radius:parent.radius*1.5
        anchors.top: parent.Top
        anchors.horizontalCenter: parent.horizontalCenter
        color:"transparent"
        Image {
            id:spacecraft_img
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            //width: parent.width;
            clip:false
            source: "graphics/spaceship.png"
        }
        Image {
            id:spacecraft_img_moving
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            opacity: 0
            width: parent.width;
            source: "graphics/spaceship_moving.png"
        }
    }

}
