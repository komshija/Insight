#include "Event.h"
#include "DatabaseManager.h"

Event::Event(QObject *parent)
    : QObject{parent}
{

}

void Event::insertEvent(QString name, quint8 type, QDateTime ds, QDateTime de, int userId, float lan, float lot)
{
    DatabaseManager::instance()->InsertEvent(name, type, ds, de, userId, lan, lot);
}

void Event::updateEvent(int id, QString name, quint8 type, QDateTime ds, QDateTime de)
{
    DatabaseManager::instance()->UpdateEvent(id, name, type, ds, de);
}

void Event::removeEvent(int id)
{
    DatabaseManager::instance()->RemoveEvent(id);
}
