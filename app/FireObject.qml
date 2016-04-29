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
}
