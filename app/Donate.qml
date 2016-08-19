import QtQuick 2.0
import Ubuntu.Components 1.1

Item {
    anchors.fill: parent

   SpaceBackground {}

   Column {
       spacing: units.gu(3)
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
           text: i18n.tr("Thanks for trying\n but not implemented yet")
           color: "#6CCD6A"
           font.bold: true
       }
       Label {
           id: blank
           objectName: "blank"

           text: " "
       }
       MyButton {
          objectName: "buttonReturn"
          text: i18n.tr("Return")
          onClicked: stack.pop()
       }
   }
}

