import QtQuick 2.0
import Ubuntu.Components 1.1

Button {
   FontLoader { id: exoFont; source: "fonts/exolight.otf" }
   width: parent.width
   font.pixelSize: units.gu(2.5)
   font.family: exoFont.name
   gradient: Gradient {
           GradientStop {
               position: 0.0
               color: {
                       return "#6CCD6A"
               }
           }
           GradientStop { position: 1.0; color: "#1C7D1A" }
       }
    onClicked: {}
}
