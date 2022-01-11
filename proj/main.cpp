#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>

#include <DatabaseManager.h>
#include <User.h>
#include <Event.h>


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;

    qmlRegisterSingletonInstance<DatabaseManager>("com.db", 1,0,"DatabaseManager", DatabaseManager::instance());

    User user;
    qmlRegisterType<User>("com.user", 1, 0, "User");

    Event event;
    qmlRegisterType<Event>("com.event", 1, 0, "Event");


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);
    app.setWindowIcon(QIcon(":/placeholder.png"));

    return app.exec();
}
