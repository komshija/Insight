#include "DatabaseManager.h"
#include <QDebug>
#include <QSqlError>
#include <QDateTime>
#include <QSqlRecord>

DatabaseManager* DatabaseManager::_instance = nullptr;

DatabaseManager::DatabaseManager(QObject *parent)
    : QObject{parent}
{
    db = QSqlDatabase::addDatabase("QODBC3");

    QString connectString = "Driver={SQL Server};";
    connectString.append("Server=127.0.0.1, 1433;");
    connectString.append("Database=insight;");
    connectString.append("Uid=milan;");
    connectString.append("Pwd=admin;");

    db.setDatabaseName(connectString);

    if( !db.open() )
        qDebug() << db.lastError().text();
    else
        qDebug() << "Uspesno konektovano na bazu!";

}

DatabaseManager *DatabaseManager::instance()
{
    if(_instance == nullptr)
        _instance = new DatabaseManager();
    return _instance;

}

void DatabaseManager::destroy()
{
    if(_instance != nullptr)
        delete _instance;
    _instance = nullptr;
}

bool DatabaseManager::Register(QString username, QString password, QString nickname)
{
    QSqlQuery q(db);
    q.prepare("EXEC sp_register " + username + ", " +password + ", " + nickname + ";");

    q.exec();
    q.next();

    bool res = q.value(0).toInt() ? true : false;

    return res;
}

int DatabaseManager::Login(QString username, QString password)
{
    QSqlQuery q(db);

    q.prepare("EXEC sp_login " + username + ", " +password + ";");
    q.exec();

    bool res = q.next();
    if(!res)
        return -1;
    else
        return q.record().value(0).toInt();
}

void DatabaseManager::InsertEvent(QString name, int type, QDateTime dateStart, QDateTime dateEnd, int createdBy, float lan, float lot)
{

    const QString upit = "EXEC sp_insert_event '"
            + name + "', "
            + QString::number(type) +  ", "
            + "'" + dateStart.toString("yyyy-MM-dd HH:mm:00.000") + "'" + ", "
            + "'" + dateEnd.toString("yyyy-MM-dd HH:mm:00.000") + "'" + ", "
            + QString::number(createdBy) + ", "
            + QString::number(lan) + ", "
            + QString::number(lot) + ";";

    QSqlQuery q;
    q.prepare(upit);
    q.exec();
//    qDebug() << q.executedQuery();

}

void DatabaseManager::UpdateEvent(int id, QString name, int type, QDateTime dateStart, QDateTime dateEnd)
{
    const QString upit = "EXEC sp_updateEvent "
            + QString::number(id) + ", "
            + name + ", "
            + QString::number(type) +  ", "
            + "'" + dateStart.toString("yyyy-MM-dd HH:mm:00.000") + "'" + ", "
            + "'" + dateEnd.toString("yyyy-MM-dd HH:mm:00.000") + "'" + ";";


    QSqlQuery q;
    q.prepare(upit);
    q.exec();

}

void DatabaseManager::RemoveEvent(int id)
{
    const QString upit = "EXEC sp_removeEvent "
            + QString::number(id) + ";";
    QSqlQuery q;
    q.prepare(upit);
    q.exec();
}

QString DatabaseManager::dateToString(QDateTime date)
{
    int year,month,day;
    date.date().getDate(&year,&month,&day);
    int hour,minute;
    hour = date.time().hour();
    minute = date.time().minute();
    QString result = "'%0-%1-%2 %3:%4:00.000'";
    result = result.arg(year).arg(month).arg(day).arg(hour).arg(minute);
    return result;
}

QStringList DatabaseManager::getTypes()
{
    QSqlQuery q(db);
    q.prepare("EXEC sp_getTypes;");
    q.exec();
    QStringList result;
    while(q.next())
        result << q.record().value(0).toString().trimmed();
    return result;
}

QStringList DatabaseManager::getEventsIds()
{
    QSqlQuery q(db);
    q.prepare("EXEC sp_getEvents;");
    q.exec();
    QStringList item;
    while(q.next())
        item << q.record().value(0).toString();
    return item;
}

QStringList DatabaseManager::getEvent(int id)
{
    QSqlQuery q(db);
    q.prepare("EXEC sp_getEvents;");
    q.exec();
    QStringList item;
    while(q.next())
       if(id ==  q.record().value(0).toInt())
       {
           item << q.record().value(0).toString().trimmed()//id
                << q.record().value(1).toString().trimmed()//ime
                << q.record().value(2).toString().trimmed()//tip
                << q.record().value(6).toString().trimmed()//lan
                << q.record().value(7).toString().trimmed()//lot
                << q.record().value(5).toString().trimmed()//createdById
                << q.record().value(3).toString().trimmed()//dateStart
                << q.record().value(4).toString().trimmed()//dateEnd
                   ;
           return item;
       }
    return item;
}
