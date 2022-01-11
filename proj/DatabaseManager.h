#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlQuery>
#include <QSqlDatabase>
#include <QStringList>

class DatabaseManager : public QObject
{
    Q_OBJECT
private:
    explicit DatabaseManager(QObject *parent = nullptr);
    static DatabaseManager* _instance;
    QSqlDatabase db;
public:

    static DatabaseManager* instance();
    static void destroy();

public:
    bool Register(QString username, QString password, QString nickname);
    int Login(QString username, QString password);

    void InsertEvent(QString name, int type, QDateTime dateStart, QDateTime dateEnd, int createdBy, float lan, float lot);
    void UpdateEvent(int id, QString name, int type, QDateTime dateStart, QDateTime dateEnd);
    void RemoveEvent(int id);

    QString dateToString(QDateTime date);
private:
    //QML dostupne
public:
    Q_INVOKABLE QStringList getTypes();
    Q_INVOKABLE QStringList getEventsIds();
    Q_INVOKABLE QStringList getEvent(int id);



signals:

};

#endif // DATABASEMANAGER_H
