import QtQuick 2.0
import Ubuntu.Components 1.1

Item {
    anchors.fill: parent

   SpaceBackground {}
    LevelHandler{id:level}
   Column {
       spacing: units.gu(1.5)
       anchors {
           margins: units.gu(2)
           horizontalCenter: parent.horizontalCenter
           verticalCenter: parent.verticalCenter
       }

       Label {
           anchors {
               horizontalCenter: parent.horizontalCenter
           }
           objectName: "Title"
           font.pixelSize: units.gu(2.5)
           font.family: exoFont.name
           horizontalAlignment: Text.AlignHCenter
           text: i18n.tr("Highscores :")
           color: "#6CCD6A"
           font.bold: true
       }
       Label {
           objectName: "blank"

           text: " "
       }
       Repeater {
            model: [level.highscores.top1,level.highscores.top2,level.highscores.top3]
           Label {
               font.pixelSize: units.gu(2)
               color: "white"
               font.family: exoFont.name
               text: modelData
           }
       }
       Label {
           text: " "
       }
       MyButton {
          objectName: "buttonReturn"
          text: i18n.tr("Return")
          onClicked: stack.pop()
       }
   }
}

