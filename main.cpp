#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlProperty>
#include "grid.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    Grid t;
    QQmlContext *root = engine.rootContext();
    root->setContextProperty("_grid",&t);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
