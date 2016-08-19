import QtQuick 2.0

MovingObject {
    id:fire
    property int ttl: 20
    property bool used: false
    radius:playground.width/200
    onTick: {
        ttl -= 1
        if(ttl == 0) {
            destroy()
            level.combo = 0
        }
    }
    signal hit( var cible)
    onHit: {
        if((typeof cible.hit) === "function" || used)//spacecraft or another fire
            return
        //console.log("hit");
        cible.destroy()
        destroy()
        sound.hit.play()
        used = true
        level.score += 100 + level.combo*10
        level.combo++
        //rotation = 0
        console.log(cible.divcount)
        if(cible.divcount > 0) {
            var newdivcount = cible.divcount - 1
//            playground.createPlanet({"radius":cible.radius/2, "image": cible.image, "centerX": cible.centerX, "centerY": cible.centerY, "vx":cible.vx+playground.width/80*Math.sin((rotation+45)*(Math.PI/180))/2, "vy":cible.vy+playground.width/80*Math.cos((rotation+45)*(Math.PI/180))/2})
//            playground.createPlanet({"radius":cible.radius/2, "image": cible.image, "centerX": cible.centerX, "centerY": cible.centerY,  "vx":cible.vx+playground.width/80*Math.sin((rotation-45)*(Math.PI/180))/2, "vy":cible.vy+playground.width/80*Math.cos((rotation-45)*(Math.PI/180))/2})
            playground.createPlanet({"divcount":newdivcount, "radius":cible.radius/2, "image": cible.image, "x": cible.centerX-cible.radius/2, "y": cible.centerY-cible.radius/2, "vx":cible.vx+playground.width/90*Math.sin((rotation+30)*(Math.PI/180))/2, "vy":cible.vy-playground.width/90*Math.cos((rotation+30)*(Math.PI/180))/2})
            playground.createPlanet({"divcount":newdivcount, "radius":cible.radius/2, "image": cible.image, "x": cible.centerX-cible.radius/2, "y": cible.centerY-cible.radius/2,  "vx":cible.vx+playground.width/90*Math.sin((rotation-30)*(Math.PI/180))/2, "vy":cible.vy-playground.width/90*Math.cos((rotation-30)*(Math.PI/180))/2})
        }

    }
}
