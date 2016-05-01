import QtQuick 2.0

SpaceObject {
    id:fire
    property int ttl: 20
    radius:units.gu(1)/4
    onTick: {
        ttl -= 1
        if(ttl == 0) {
            destroy()
        }
    }
    signal hit( var cible)
    onHit: {
        if((typeof cible.hit) === "function")//spacecraft or another fire
            return
        console.log("hit");
        cible.destroy()
        destroy()
        if(cible.radius > units.gu(4)/2/2) {
            background.createPlanet({"radius":cible.radius/2, "centerX": cible.centerX, "centerY": cible.centerY, "vx":cible.vx+units.gu(1)*Math.sin((rotation+30)*(Math.PI/180))/2, "vy":cible.vy-units.gu(1)*Math.cos((rotation+30)*(Math.PI/180))/2})
            background.createPlanet({"radius":cible.radius/2, "centerX": cible.centerX, "centerY": cible.centerY,  "vx":cible.vx+units.gu(1)*Math.sin((rotation-30)*(Math.PI/180))/2, "vy":cible.vy-units.gu(1)*Math.cos((rotation-30)*(Math.PI/180))/2})
        }

    }
}
