import QtQuick 2.5
import QtQuick.Window 2.2
import mustafa.bedri.sen 1.0

Rectangle {
    property bool paused:false;
    id: root
    width: 800
    height: 800
    //anchors.fill: parent
    visible: true
    focus: true
    Keys.onUpPressed: {
        snake.onUserInput(0, -1);
        snakeTimer.restart();
    }
    Keys.onDownPressed: {
        snake.onUserInput(0, 1);
        snakeTimer.restart();
    }
    Keys.onRightPressed: {
        snake.onUserInput(1, 0);
        snakeTimer.restart();
    }
    Keys.onLeftPressed: {
        snake.onUserInput(-1, 0);
        snakeTimer.restart();
    }
    Keys.onSpacePressed: {
        if (paused)
        {
            snakeTimer.restart();
            paused = false;
        }
        else
        {
            snakeTimer.stop();
            paused = true;
        }
    }

    Component.onCompleted: {
        snake.onStart();
    }

    SnakeModel {
        id: snake
        onTileColorChanged:{
            myRepeater.itemAt(row*40 + col).color = color;
        }
    }

    Grid {
        id: myGrid;
        anchors.fill: parent
        rows: 40
        Repeater {
            anchors.fill: parent
            id: myRepeater

            model: 1600

            Rectangle {
                id: rect
                width: root.width / 40;
                height: root.height / 40;
                border.width: 1
                border.color: "white"
                color: "yellow"
                //                color: Positioner.isFirstItem ? "yellow" : "lightsteelblue"

//                Text { text: rect.Positioner.index }
            }
        }
    }
    Timer {
        id: snakeTimer

        interval: 150
        running: true;
        repeat: true;
        onTriggered: {
            snake.onTimer();
        }
    }
}
//Window {
//    id: root

//    property int speedx: 1
//    property int speedy: 0
//    property var snake:[];
//    property var apple;
//    property int growingTill:0
//    property int headx:-20
//    property int heady:0
//    property int applex:0
//    property int appley:0

//    function createNewApple() {
//        apple = Qt.createQmlObject('import QtQuick 2.0; Rectangle {color: "red"; width: 20; height: 20}',
//                                     root,
//                                     "");
//        var tryAgain = false;
//        do
//        {
//            applex = Math.floor((Math.random() * 799)/20)*20;
//            appley = Math.floor((Math.random() * 799)/20)*20;
//            console.log("in the loop");
//            snake.forEach(function(element) {
//                if ( element.x === applex && element.y === appley )
//                {
//                    tryAgain = true;
//                }
//            });
//        }while (tryAgain === true);

//        apple.x = applex;
//        apple.y = appley;
//        console.log("create new apple called apple.x:"+ apple.x + " apple.y:" + apple.y);
//    }
////    Component.onCompleted: {
////        createNewApple();
////    }

//    visible: true
//    width: 800
//    height: 800
//    title: qsTr("Snake!")

//    Rectangle {
//        anchors.fill: parent
//        focus: true;

//        Keys.onUpPressed: {
//            if (speedx === 0 && speedy === 1){
//            }
//            else {
//                speedx=0;
//                speedy=-1;
//            }
//        }
//        Keys.onDownPressed: {
//            if (speedx === 0 && speedy === -1) {
//            }
//            else {
//                speedx=0;
//                speedy=1;
//            }
//        }
//        Keys.onRightPressed: {
//            if (speedx === -1 && speedy === 0) {
//            }
//            else {
//                speedx=1;
//                speedy=0;
//            }
//        }
//        Keys.onLeftPressed: {
//            if (speedx === 1 && speedy === 0) {
//            }
//            else {
//                speedx=-1;
//                speedy=0;
//            }
//        }

//        Timer {
//            id: snakeTimer

//            interval: 100
//            running: true;
//            repeat: true;

//            onTriggered: {
//                headx = headx + speedx*20
//                heady = heady + speedy*20

//                var died = false;
//                snake.forEach(function(element) {
//                    if ( (element.x === headx && element.y === heady) ||
//                            ((headx < 0) || (headx > 800) || (heady < 0) || (heady > 800)))
//                    {
//                        console.log("DIE!!");
//                        died = true;
//                    }
//                });

//                if (died)
//                {
//                    snake.forEach(function(element){
//                        element.destroy();
//                    });
//                    headx = 0;
//                    heady = 0;
//                    speedx = 1;
//                    speedy = 0;
//                    growingTill = 5;
//                    if (undefined !== apple)
//                    {
//                        apple.destroy();
//                    }
//                    root.createNewApple();
//                    snake = [];
//                }
//                else
//                {
//                    if (headx === applex && heady === appley)
//                    {
//                        console.log("apllex and appley are the same")
//                        if (undefined !== apple)
//                        {
//                            apple.destroy();
//                        }
//                        growingTill += 5;
//                        root.createNewApple();
//                    }
//                    var newObject = Qt.createQmlObject('import QtQuick 2.0; Rectangle {color: "green"; width: 20; height: 20}',
//                                                       parent,
//                                                       "");
//                    newObject.x = headx;
//                    newObject.y = heady;
//                    snake.push(newObject);
//                    if (growingTill === 0)
//                    {
//                        var removed = snake.shift();
//                        removed.color = "white"
//                        removed.destroy();
//                    }
//                    else
//                    {
//                        growingTill--;
//                    }
//                }
//            }
//        }
//    }
//}
