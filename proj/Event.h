#ifndef EVENT_H
#define EVENT_H

#include <QObject>
#include <QDateTime>

class Event : public QObject
{
    Q_OBJECT
public:
    explicit Event(QObject *parent = nullptr);

    Q_INVOKABLE void insertEvent(QString name, quint8 type, QDateTime ds, QDateTime de, int userId, float lan, float lot);

    Q_INVOKABLE void updateEvent(int id, QString name, quint8 type, QDateTime ds, QDateTime de);

    Q_INVOKABLE void removeEvent(int id);

private:
    QString name;
    int type;
    QDateTime dateStart;
    QDateTime dateEnd;
    int userId;

signals:

};

#endif // EVENT_H
