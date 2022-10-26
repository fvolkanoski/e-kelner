#include "dbmanager.h"

#include <QStandardPaths>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QDir>

DBManager::DBManager(QObject *parent)
    : QObject{parent}
{
    initDb();
}

const QStringList &DBManager::waiters() const
{
    return m_waiters;
}

void DBManager::setWaiters(const QStringList &newWaiters)
{
    if (m_waiters == newWaiters)
        return;
    m_waiters = newWaiters;
    emit waitersChanged();
}

int DBManager::waiterId() const
{
    return m_waiterId;
}

void DBManager::setWaiterId(int newWaiterId)
{
    if (m_waiterId == newWaiterId)
        return;

    m_waiterId = newWaiterId;
    emit waiterIdChanged();
}

void DBManager::readTables()
{
    QSqlQuery query(_waiterDB);

    if(!query.exec("SELECT * FROM tables"))
    {
        // Log error?
    }

    while (query.next())
    {
       emit addTable(query.value("id").toInt(), query.value("x").toInt(), query.value("y").toInt());
    }
}

void DBManager::readItemsFromCategory(int catId)
{
    QSqlQuery query(_menuDB);

    query.prepare("SELECT * FROM items WHERE cat_id=?");
    query.addBindValue(catId);

    if(!query.exec())
    {
        // Log error?
    }

    QStringList items;

    while (query.next())
    {
       items << query.value("name").toString();
    }

    this->setItems(items);
}

void DBManager::updateTablePos(int tableId, int x, int y)
{
    QSqlQuery query(_waiterDB);

    query.prepare("UPDATE tables SET x=?, y=? WHERE id=?");
    query.addBindValue(x);
    query.addBindValue(y);
    query.addBindValue(tableId);

    if(!query.exec())
    {
        // Log error?
        qDebug() << "NOK";
    }

}

void DBManager::appendNewDBTable(int tableId, int x, int y)
{
    QSqlQuery query(_waiterDB);

    qDebug() << tableId << x << y;

    query.prepare("INSERT INTO tables (id, x, y) VALUES (:id, :x, :y)");
    query.bindValue(":id", tableId);
    query.bindValue(":x", x);
    query.bindValue(":y", y);

    if(!query.exec())
    {
        // Log error?
        qDebug() << "NOK";
    }
}

void DBManager::deleteDBTable(int tableId)
{
    QSqlQuery query(_waiterDB);

    query.prepare("DELETE FROM tables WHERE id=?");
    query.addBindValue(tableId);

    if(!query.exec())
    {
        // Log error?
        qDebug() << "NOK";
        qDebug() << query.lastError();
    }
}

void DBManager::initDb()
{
    bool dbOK = QFile::exists(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/Waiter.db");

    qDebug() << "DB OK????" << dbOK;

    if(!dbOK)
    {
        QFile file(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/Waiter.db");
        file.open(QIODevice::WriteOnly); // Or QIODevice::ReadWrite
        file.close();
    }

    _waiterDB = QSqlDatabase::addDatabase("QSQLITE");
    _waiterDB.setDatabaseName(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/Waiter.db");

    if (!_waiterDB.open())
    {
        qDebug() << "Can't open waiters db." << _waiterDB.lastError() << QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    }
    else
    {
       bool dbStructOK = false;

       QSqlQuery q = _waiterDB.exec("SELECT name FROM sqlite_master WHERE type='table' AND name='{waiters}';");
       while(q.next())
       {
           dbStructOK = true;
       }

       qDebug() << "DB STRUCT OK??? " << dbStructOK;

       if(!dbStructOK)
       {
        _waiterDB.exec("CREATE TABLE IF NOT EXISTS \"waiters\" ("
                       "\"id\"	INTEGER NOT NULL UNIQUE,"
                       "\"name\"	INTEGER NOT NULL UNIQUE,"
                       "PRIMARY KEY(\"id\" AUTOINCREMENT)"
                       " );");

        _waiterDB.exec("INSERT INTO \"waiters\" VALUES (1,'Келнер1');");
         _waiterDB.exec("INSERT INTO \"waiters\" VALUES (2,'Келнер2');");

         _waiterDB.exec("CREATE TABLE IF NOT EXISTS \"tables\" ("
                      "\"id\"	INTEGER NOT NULL UNIQUE,"
                      "\"x\"	INTEGER NOT NULL,"
                      "\"y\"	INTEGER NOT NULL,"
                      "PRIMARY KEY(\"id\" AUTOINCREMENT));");

         _waiterDB.exec("INSERT INTO \"tables\" VALUES (1,0,0);");
         _waiterDB.exec("INSERT INTO \"tables\" VALUES (3,148,101);");
         _waiterDB.exec("INSERT INTO \"tables\" VALUES (4,48,307);");
         _waiterDB.exec("INSERT INTO \"tables\" VALUES (5,149,303);");
       }

        readWaiters();
        qDebug() << QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    }

    _menuDB = QSqlDatabase::addDatabase("QSQLITE", "conn2");
    _menuDB.setDatabaseName(QStandardPaths::locate(QStandardPaths::AppDataLocation, "Menu.db", QStandardPaths::LocateFile));

    if (!_menuDB.open())
        qDebug() << "Can't open menu db.";
    else
    {
        _menuDB.exec("CREATE TABLE IF NOT EXISTS \"categories\" ("
                     "\"id\"	INTEGER NOT NULL UNIQUE,"
                     "\"name\"	TEXT NOT NULL UNIQUE,"
                     "PRIMARY KEY(\"id\" AUTOINCREMENT)"
                 ");");

        _menuDB.exec("CREATE TABLE IF NOT EXISTS \"items\" ("
                     "\"id\"	INTEGER NOT NULL UNIQUE,"
                     "\"cat_id\"	INTEGER NOT NULL,"
                     "\"name\"	TEXT NOT NULL,"
                     "PRIMARY KEY(\"id\" AUTOINCREMENT)"
                 ");");


        _menuDB.exec("INSERT INTO \"categories\" VALUES (0,'КАФЕ');");
        _menuDB.exec("INSERT INTO \"categories\" VALUES (1,'АЛКОХОЛ');");
        _menuDB.exec("INSERT INTO \"categories\" VALUES (2,'СОК');");
        _menuDB.exec("INSERT INTO \"categories\" VALUES (3,'ПИЦИ');");
        _menuDB.exec("INSERT INTO \"categories\" VALUES (4,'ДОРУЧЕК');");
        _menuDB.exec("INSERT INTO \"items\" VALUES (0,0,'ЕСПРЕСО');");
        _menuDB.exec("INSERT INTO \"items\" VALUES (1,0,'МАКИЈАТО');");
        _menuDB.exec("INSERT INTO \"items\" VALUES (2,0,'КАПУЧИНО');");

        readCategories();
    }
}

void DBManager::readWaiters()
{
    QSqlQuery query(_waiterDB);

    if(!query.exec("SELECT * FROM waiters"))
    {
        qDebug() << query.lastError();
        // Log error?
    }

    QStringList waiters;

    while (query.next())
    {
       waiters << query.value("name").toString();
    }

    this->setWaiters(waiters);
}

void DBManager::readCategories()
{
    QSqlQuery query(_menuDB);

    if(!query.exec("SELECT * FROM categories"))
    {
        // Log error?
    }

    QStringList categories;

    while (query.next())
    {
       categories << query.value("name").toString();
    }

    this->setCategories(categories);
}

const QStringList &DBManager::categories() const
{
    return m_categories;
}

void DBManager::setCategories(const QStringList &newCategories)
{
    if (m_categories == newCategories)
        return;
    m_categories = newCategories;
    emit categoriesChanged();
}

const QStringList &DBManager::items() const
{
    return m_items;
}

void DBManager::setItems(const QStringList &newItems)
{
    if (m_items == newItems)
        return;
    m_items = newItems;
    emit itemsChanged();
}
