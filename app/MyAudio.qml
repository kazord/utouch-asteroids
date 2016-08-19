import QtQuick 2.0
import QtMultimedia 5.4

import Qt.labs.settings 1.0

Image {
    id:img
    property alias fire: fireSound
    property alias hit: hitSound
    property alias over: overSound
    property alias lvlup: lvlupSound
    property alias jump: jumpSound
//    property alias rocket: rocketSound

        anchors {top:parent.top;topMargin:units.gu(1);right:parent.right;rightMargin: units.gu(1)}
        width:units.gu(2.5)
        height:units.gu(2.5)
         fillMode: Image.PreserveAspectFit
        source:"graphics/soundOn.png"
        MultiPointTouchArea {
            anchors.fill: parent
            onPressed: {
                soundsSettings.sound = !soundsSettings.sound
                if(soundsSettings.sound)
                    music.play()
                else
                    music.pause()
            }
        }

    Settings {
           id: soundsSettings
           category: "Sounds"
           property bool sound: true
    }

    Audio {
        id:music
        //autoPlay: soundsSettings.sound
        source: "sounds/background.ogg"
        loops: Audio.Infinite
        Component.onCompleted: {if(soundsSettings.sound)
                music.play()}
    }
    SoundEffect {
           id: fireSound
           source: "sounds/fire.wav"
       }
    SoundEffect {
           id: powerSound
           source: "sounds/fire.wav"
       }
    SoundEffect {
           id: hitSound
           source: "sounds/explosion.wav"
       }
    SoundEffect {
           id: overSound
           source: "sounds/gameover.wav"
       }
    SoundEffect {
           id: lvlupSound
           source: "sounds/lvlup.wav"
       }
    SoundEffect {
           id: jumpSound
           source: "sounds/jump.wav"
       }
//    SoundEffect {
//           id: rocketSound
//           //source: "sounds/rocket.wav"
//       }
    state:(soundsSettings.sound)?"PLAY":"MUTED"
    states: [
        State {
            name: "PLAY"
            PropertyChanges {
                target: img
                source:"graphics/soundOn.png"
            }
             PropertyChanges {
                 target: music
                 muted:false
             }
             PropertyChanges {
                 target: fireSound
                 muted:false
             }
             PropertyChanges {
                 target: powerSound
                 muted:false
             }
             PropertyChanges {
                 target: hitSound
                 muted:false
             }
             PropertyChanges {
                 target: overSound
                 muted:false
             }
             PropertyChanges {
                 target: lvlupSound
                 muted:false
             }
             PropertyChanges {
                 target: jumpSound
                 muted:false
             }
//             PropertyChanges {
//                 target: rocketSound
//                 muted:false
//             }
        },
        State {
            name: "MUTED"
            PropertyChanges {
                target: img
                source:"graphics/soundOff.png"
            }
            PropertyChanges {
                target: music
                muted:true
            }
            PropertyChanges {
                target: fireSound
                muted:true
            }
            PropertyChanges {
                target: powerSound
                muted:true
            }
            PropertyChanges {
                target: hitSound
                muted:true
            }
            PropertyChanges {
                target: overSound
                muted:true
            }
            PropertyChanges {
                target: lvlupSound
                muted:true
            }
            PropertyChanges {
                target: jumpSound
                muted:true
            }
//            PropertyChanges {
//                target: rocketSound
//                muted:true
//            }
        }
    ]
}

