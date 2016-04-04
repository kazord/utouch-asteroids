import QtQuick 2.0

Rectangle {
    property int centerX:0//in order to make circle fix during resize
    property int centerY:0//in order to make circle fix during resize
    onRadiusChanged: {
        if(width == 0) {
            //first position update
            xChanged()
            yChanged()
        }

        width=radius*2
        height=radius*2
        //keep fix center
        centerXChanged()
        centerYChanged()
    }
    onCenterXChanged: {
        x = centerX - radius
       }
    onCenterYChanged: {
        y = centerY - radius
    }
    onXChanged: {
        centerX = x + radius
    }
    onYChanged: {
        centerY = y + radius
    }
    Component.onCompleted: {console.log(x)}
}

