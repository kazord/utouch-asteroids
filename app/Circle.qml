import QtQuick 2.0

Rectangle {
    property int centerX:0//in order to make circle fix during resize
    property int centerY:0//in order to make circle fix during resize
    x:0
    y:0
    property string text: ""
    property int textSize: 0
    onRadiusChanged: {
        width=radius*2
        height=radius*2
        if(x != 0 || y != 0) {
            //first position update
            xChanged()
            yChanged()
        }
        if(centerX != 0 || centerY != 0) {
            centerXChanged()
            centerYChanged()
        }


        //keep fix center

    }
    onCenterXChanged: {
        x = centerX - radius
         console.log("x")
       }
    onCenterYChanged: {
        y = centerY - radius
        console.log("y")
    }
    onXChanged: {
        centerX = x + radius
         console.log("cx")
    }
    onYChanged: {
        centerY = y + radius
         console.log("cy")
    }
    onTextChanged: {
        subtext.text = text
    }
    onTextSizeChanged: {
        subtext.font.pixelSize = textSize
    }

    Component.onCompleted: {console.log("new")}
    Text {
        id:subtext
        anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter;}
        font.pixelSize:  parent.textSize
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: parent.text
        color: parent.border.color
    }
}

