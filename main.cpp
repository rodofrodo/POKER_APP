#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "backend.h"
#include "SettingsManager.h"

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);

    SettingsManager settings;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("AppSettings", &settings);

    Backend backend;
    engine.rootContext()->setContextProperty("backend", &backend);

    const QUrl url(u"qrc:/PokerApp/resources/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject* obj, const QUrl& objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}