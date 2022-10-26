#ifndef DBMANAGER_H
#define DBMANAGER_H

#include <QObject>
#include <QSqlDatabase>

#if defined(Q_OS_IOS)
#include <QtPlugin>
#endif

class DBManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList waiters READ waiters WRITE setWaiters NOTIFY waitersChanged)
    Q_PROPERTY(QStringList categories READ categories WRITE setCategories NOTIFY categoriesChanged)
    Q_PROPERTY(QStringList items READ items WRITE setItems NOTIFY itemsChanged)
    Q_PROPERTY(int waiterId READ waiterId WRITE setWaiterId NOTIFY waiterIdChanged)

public:
    explicit DBManager(QObject *parent = nullptr);

    Q_INVOKABLE void readTables();
    Q_INVOKABLE void readItemsFromCategory(int catId);
    Q_INVOKABLE void updateTablePos(int tableId, int x, int y);
    Q_INVOKABLE void appendNewDBTable(int tableId, int x, int y);
    Q_INVOKABLE void deleteDBTable(int tableId);

    const QStringList &waiters() const;
    void setWaiters(const QStringList &newWaiters);
    int waiterId() const;
    void setWaiterId(int newWaiterId);
    const QStringList &categories() const;
    void setCategories(const QStringList &newCategories);
    const QStringList &items() const;
    void setItems(const QStringList &newItems);

signals:
    void addTable(int id, int x, int y);

    void waitersChanged();
    void waiterIdChanged();
    void categoriesChanged();
    void itemsChanged();

private:
    void initDb();
    void readWaiters();
    void readCategories();

    QSqlDatabase _waiterDB;
    QSqlDatabase _menuDB;

    QStringList m_waiters;
    int m_waiterId;
    QStringList m_categories;
    QStringList m_items;
};

#endif // DBMANAGER_H
