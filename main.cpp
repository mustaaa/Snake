#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include "snakemodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    //SnakeModel snake;
    QQuickView view;

    qmlRegisterType<SnakeModel>("mustafa.bedri.sen", 1, 0, "SnakeModel");
    //view.engine()->rootContext()->setContextProperty("snake", &snake);
    view.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    view.show();

    return app.exec();
//    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    return app.exec();
}
