import QtQuick 2.0
import Ubuntu.Components 1.1

Column {
    visible:false
    spacing: units.gu(2)
    state:"paused"
    id: subcontainer
    width:parent.width*0.5
    anchors {
        margins: units.gu(2)
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }
    Label {
        anchors {
            horizontalCenter: parent.horizontalCenter
        }
        id: title
        objectName: "Title"
        font.pixelSize: units.gu(3.2)
        font.family: exoFont.name
        horizontalAlignment: Text.AlignHCenter
        text: i18n.tr("Paused")
        color: "#6CCD6A"
        font.bold: true
    }
    MyButton {
        id:action
       objectName: "buttonPlay"
       text: i18n.tr("Resume")
       onClicked: {subcontainer.visible = false;gameevent.start()}
    }
    Label {
        text:""
    }

    MyButton {
       objectName: "buttonLeave"
       text: i18n.tr("Return to menu")
       onClicked: {stack.pop()}
    }
    Label {
        text:""
    }
    MyButton {
       objectName: "buttonLeaveAll"
       text: i18n.tr("Leave game (Exit)")
       onClicked: Qt.quit()
    }

    states: [
        State {
            name: "paused"
             PropertyChanges {
                 target: title
                 text: i18n.tr("Paused")
             }
             PropertyChanges {
                 target: action
                 text: i18n.tr("Resume")
                 onClicked: {subcontainer.visible = false;gameevent.start()}
             }

        },
        State {
            name: "gameover"
            PropertyChanges {
                target: title
                text: i18n.tr("Game Over :-(")
            }
            PropertyChanges {
                target: action
                text: i18n.tr("Restart")
                onClicked: {subcontainer.visible = false;level.cleanup();level.start();gameevent.start()}
            }
        }
        ,
        State {
            name: "levelup"
            PropertyChanges {
                target: title
                text: i18n.tr("Level Up !")
            }
            PropertyChanges {
                target: action
                text: i18n.tr("I'm ready !")
                onClicked: {subcontainer.visible = false;gameevent.start()}
            }
        }
    ]
}
