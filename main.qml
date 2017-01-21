import QtQuick 2.5
import QtQuick.Window 2.2
import mustafa.bedri.sen 1.0

Rectangle {
    property bool paused:false;
    id: root
    width: 800
    height: 800

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
