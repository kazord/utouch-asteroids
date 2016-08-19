import QtQuick 2.0
import Qt.labs.settings 1.0

Item {
    id:gamebase
    Settings {
           id: highscoresSettings
           category: "Highscores"
           property int top1: 0
           property int top2: 0
           property int top3: 0
    }
    property alias highscores: highscoresSettings
    property int score: 0
    property int level: 0
    property int combo: 0
    property var img: ["graphics/planet2_420_525.png", "graphics/planet4_300_375.png",  "graphics/planet3_265_331.png", "graphics/planet1_400_500.png"]
    signal start()
    signal nextlevel()
    signal cleanup()
    signal over()
    onStart: {
         cleanup()
         spacecraft.centerX = playground.width/2
         spacecraft.centerY = playground.height/2
        level = 0
        score = 0
        combo =0
        nextlevel()
    }
    onNextlevel: {
        cleanup()
        spacecraft.centerX = playground.width/2
        spacecraft.centerY = playground.height/2
         level= level+1
        if(level === 5) {
            gameevent.stop()
            //restart_msg.text  = "You win !\nRestart ?"
            //restart_msg.visible = true
             return;
        }
        var speed
        speed = playground.width/250+playground.width/250*level
        for(var i = 0 ; i < 2+level ; i+=1) {
             playground.createPlanet({"radius":playground.width/12, "centerX": Math.ceil(Math.random() * playground.width), "centerY": 0,
                                     "image": img[level-1],
                                     "vx":Math.ceil(Math.random() * speed)-speed/2,
                                     "vy":Math.ceil(Math.random() * speed)-speed/2})
        }
    }
    onCleanup: {
        for(var obj in playground.children) {
            //planet cleanup()
            if((typeof playground.children[obj].tick) === "function" && (typeof playground.children[obj].hit) !== "function") {
                playground.children[obj].destroy()
             }
            //other lifeitem cleanup
            if((typeof playground.children[obj].tick) === "function" && (typeof playground.children[obj].ttl)  !== "undefined") {
                playground.children[obj].destroy()
             }
        }
    }
    onOver: {
        console.log("gotcha");
        gameevent.stop()
        if(highscoresSettings.top1 < score) {
            highscoresSettings.top3 = highscoresSettings.top2
            highscoresSettings.top2 = highscoresSettings.top1
            highscoresSettings.top1 = score
        }
        else if(highscoresSettings.top2 < score) {
            highscoresSettings.top3 = highscoresSettings.top2
            highscoresSettings.top2 = score
        }
        else if(highscoresSettings.top3 < score) {
            highscoresSettings.top3 =  score
        }

        gamemenu.state = "gameover"
        gamemenu.visible = true
    }
}

