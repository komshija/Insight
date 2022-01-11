#include "User.h"
#include <DatabaseManager.h>

User::User(QObject *parent)
    : QObject{parent}
{
    m_bIsLogin = false;
}

void User::loginUser(QString username, QString password)
{
    m_Id = DatabaseManager::instance()->Login(username, password);
    if(m_Id == -1)
        m_bIsLogin = false;
    else
        m_bIsLogin = true;
}

void User::registerUser(QString username, QString nick, QString password)
{
    if(DatabaseManager::instance()->Register(username, nick, password))
    {
        m_bIsLogin = true;
        m_Nick = nick;
    }
}
