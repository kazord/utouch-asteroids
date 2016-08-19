import QtQuick 2.0
import Ubuntu.Components 1.1
import QtQuick.Window 2.1
import Qt.labs.settings 1.0
/*!
    \brief MainView with Tabs element.
           First Tab has a single Label and
           second Tab has a single ToolbarAction.
*/
/*Window {
    visible: true
    //visibility: (windowsSettings.win_fullscren)? Window.FullScreen : Window.Maximized
    Settings {
           id: windowsSettings
           category: "Constrols"
           property bool win_fullscren: true
    }*/
MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "asteroids.kazord"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    //width: parent.width
    //height: parent.height
    //backgroundColor: "#000000"
    PageStack {
        function open(qmlurl) {
                    if(stack.depth < 1)
                        stack.push(Qt.resolvedUrl(qmlurl))
        }

        id: stack
        //title: i18n.tr("Asteroids")
        FontLoader { id: exoFont; source: "fonts/exolight.otf" }
        SpaceBackground {}

        Column {
            spacing: (Screen.primaryOrientation === Qt.PortraitOrientation || Screen.primaryOrientation === Qt.InvertedPortraitOrientation)? units.gu(3):units.gu(1)
            id: container
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
                text: i18n.tr("Asteroids")
                color: "#6CCD6A"
                font.bold: true
            }
            Label {
                text: (Screen.primaryOrientation === Qt.PortraitOrientation || Screen.primaryOrientation === Qt.InvertedPortraitOrientation)? " ":""
            }
            MyButton {
               objectName: "buttonPlay"
               text: i18n.tr("Play !")
               onClicked: stack.open("Game.qml")
            }
            MyButton {
               objectName: "buttonHighscores"
               text: i18n.tr("Highscores")
               onClicked: stack.open("Highscores.qml")
            }
            MyButton {
               objectName: "buttonSettings"
               text: i18n.tr("Settings")
               onClicked: stack.open("Settings.qml")
            }
            MyButton {
               objectName: "buttonDonate"
               text: i18n.tr("Donate")
               onClicked: stack.open("Donate.qml")
            }
            MyButton {
               objectName: "buttonExit"
               text: i18n.tr("Exit")
               onClicked: Qt.quit()
            }

            Label {
                text: (Screen.primaryOrientation === Qt.PortraitOrientation || Screen.primaryOrientation === Qt.InvertedPortraitOrientation)? " ":""
            }
            Label {
                text: " "
            }

        }
    }
    states: [
                State {
                    name: "wide text"
                    when: container.parent.width > units.gu(70)
                    PropertyChanges {
                        target: container
                        width: units.gu(70)
                    }
                },
                State {
                    name: "not wide text"
                    when: container.parent.width <= units.gu(70)
                    PropertyChanges {
                        target: container
                        width: container.parent.width-2*units.gu(2)
                    }
                }
            ]
}
//}

