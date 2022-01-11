#ifndef USER_H
#define USER_H

#include <QObject>

class User : public QObject
{
    Q_OBJECT
public:

    explicit User(QObject *parent = nullptr);

    Q_INVOKABLE bool isLogin() {return m_bIsLogin;}
    Q_INVOKABLE void logout() {m_bIsLogin = false;}
    Q_INVOKABLE void loginUser(QString username, QString password);
    Q_INVOKABLE void registerUser(QString username, QString nick, QString password);
    Q_INVOKABLE int getUserId() { return m_Id; }
private:

    int m_Id;
    QString m_Username;
    QString m_Nick;

    bool m_bIsLogin;

signals:

};

#endif // USER_H
