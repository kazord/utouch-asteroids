import QtQuick 2.0

Circle {
    id:asteroids
    color: "black"
    radius:units.gu(0.5)

    property double vx: 0
    property double vy: 0
    signal tick()
    onTick: {
        x += vx
        y += vy
        if(centerX > parent.width) {
            centerX = 0;
        }
        if(centerY > parent.height) {
            centerY = 0;
        }
        if(centerX < 0) {
            centerX = parent.width
        }
        if(centerY < 0) {
             centerY = parent.height
        }
    }
}
