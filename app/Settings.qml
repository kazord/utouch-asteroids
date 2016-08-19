import QtQuick 2.0
import Ubuntu.Components 1.1
import Qt.labs.settings 1.0

Item {
    anchors.fill: parent



    SpaceBackground {
        SpaceCraft{ id:spacecraft}
        Timer {
            id:gameevent
            interval: 50; running: true; repeat: true
            onTriggered: spacecraft.tick()
        }
    }
    Controls { id: controls}

    Rectangle {
        id: flick
        clip:true
        //color: "#50ffffff"

        color:"transparent"
        radius:units.gu(2)
        border.color: "purple"
        border.width: 1
        width: parent.width*0.9; height: parent.height*0.7;
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter


        Flickable {
            id:flick_zone
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width; height: parent.height;
            contentWidth: cols.width; contentHeight: cols.height
            flickableDirection : Flickable.VerticalFlick
             leftMargin:units.gu(2)
            rightMargin:units.gu(2)

            Column {
                id:cols;
                spacing: units.gu(1)
                anchors {
                    margins: units.gu(2)
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                }

                Label {
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }
                    objectName: "Title"
                    font.pixelSize: units.gu(2.5)
                    font.family: exoFont.name
                    horizontalAlignment: Text.AlignHCenter
                    text: i18n.tr("Settings")
                    color: "#6CCD6A"
                    font.bold: true
                }
                Label { id: joyleftlabl
                    text: "Joystick on Left"
                    font.pixelSize: units.gu(1.5)
                    font.family: exoFont.name
                    color: "#6CCD6A"
                    Switch { anchors.left: joyleftlabl.right
                        anchors.leftMargin: units.gu(1)
                        checked: (controls.settings.joy_state === "LEFT")? true:false
                        onCheckedChanged: {
                            controls.settings.joy_state = (checked) ? "LEFT" : "RIGHT";
                            controls.settings.but_state = (checked) ? "RIGHT" : "LEFT";
                        }
                    }
                }
                Label { id: space_direction
                    text: "Control in direction"
                    font.pixelSize: units.gu(1.5)
                    font.family: exoFont.name
                    color: "#6CCD6A"
                    Switch { anchors.left: space_direction.right
                        anchors.leftMargin: units.gu(1)
                        checked: (controls.settings.space_direction === "DIR")? true:false
                        onCheckedChanged: {
                            controls.settings.space_direction = (checked) ? "DIR" : "REL";
                        }
                    }
                }
                Label { id: joy_linear
                    text: "linear controls"
                    font.pixelSize: units.gu(1.5)
                    font.family: exoFont.name
                    color: "#6CCD6A"
                    Switch { anchors.left: joy_linear.right
                        anchors.leftMargin: units.gu(1)
                        checked: (controls.settings.joy_linear === true)? true:false
                        onCheckedChanged: {
                            controls.settings.joy_linear = (checked) ? true : false;
                        }
                    }
                }
                Label { id: joySize
                    text: "Joystick Area Size"
                    font.pixelSize: units.gu(1.5)
                    font.family: exoFont.name
                    color: "#6CCD6A"

                }
                Slider {
                    minimumValue: 5
                    maximumValue: 50
                    //stepSize:1
                    value: controls.settings.joy_size
                    onValueChanged: {
                        controls.settings.joy_size = value.toFixed(0);
                    }



                }
                Label { id: stickRatio
                    text: "Joystick size (ratio of area)"
                    font.pixelSize: units.gu(1.5)
                    font.family: exoFont.name
                    color: "#6CCD6A"

                }
                Slider {
                    minimumValue: 5
                    maximumValue: 70
                    //stepSize:1
                    value: controls.settings.joy_stickSize*100
                    onValueChanged: {
                        controls.settings.joy_stickSize = value.toFixed(0)/100;
                    }
                }
                Label { id: joyMargin
                    text: "Joystick Bottom Marging"
                    font.pixelSize: units.gu(1.5)
                    font.family: exoFont.name
                    color: "#6CCD6A"

                }
                Slider {
                    minimumValue: 0
                    maximumValue: 12
                    //stepSize:1
                    value: controls.settings.joy_bottomMargin
                    onValueChanged: {
                        controls.settings.joy_bottomMargin = value;
                    }
                }
                Label { id: joysideMargin
                    text: "Joystick side Marging"
                    font.pixelSize: units.gu(1.5)
                    font.family: exoFont.name
                    color: "#6CCD6A"

                }
                Slider {
                    minimumValue: 0
                    maximumValue: 12
                    //stepSize:1
                    value: controls.settings.joy_sideMargin
                    onValueChanged: {
                        controls.settings.joy_sideMargin = value;
                    }
                }
                Label { id: butSize
                    text: "Buttons Size"
                    font.pixelSize: units.gu(1.5)
                    font.family: exoFont.name
                    color: "#6CCD6A"

                }
                Slider {
                    minimumValue: 0
                    maximumValue: 12
                    //stepSize:1
                    value: controls.settings.but_size
                    onValueChanged: {
                        controls.settings.but_size = value;
                    }
                }
                Label { id: butbotMargin
                    text: "Buttons Bottom Margin"
                    font.pixelSize: units.gu(1.5)
                    font.family: exoFont.name
                    color: "#6CCD6A"

                }
                Slider {
                    minimumValue: 0
                    maximumValue: 12
                    //stepSize:1
                    value: controls.settings.but_bottomMargin
                    onValueChanged: {
                        controls.settings.but_bottomMargin = value;
                    }
                }
                Label { id: butsideMargin
                    text: "Buttons Side Margin"
                    font.pixelSize: units.gu(1.5)
                    font.family: exoFont.name
                    color: "#6CCD6A"

                }
                Slider {
                    minimumValue: 0
                    maximumValue: 12
                    //stepSize:1
                    value: controls.settings.but_sideMargin
                    onValueChanged: {
                        controls.settings.but_sideMargin = value;
                    }
                }
                Label {
                    text: " "
                    font.pixelSize: units.gu(1.5)
                    font.family: exoFont.name
                    color: "#6CCD6A"

                }
            }
        }
        Scrollbar {
               flickableItem: flick_zone
               align: Qt.AlignTrailing
           }
    }

    MyButton {
        anchors.top: flick.bottom
        anchors.horizontalCenter: flick.horizontalCenter
        width: flick.width/2
        objectName: "buttonReturn"
        text: i18n.tr("Return")
        onClicked: stack.pop()
    }

}
