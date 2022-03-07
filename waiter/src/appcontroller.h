#pragma once

#include <QObject>
#include <QQmlEngine>

#include "dbmanager.h"

struct MenuItem {
    Q_GADGET

    Q_PROPERTY(int id MEMBER m_id READ id WRITE setId)
    Q_PROPERTY(QString name MEMBER m_name READ name WRITE setName)
    Q_PROPERTY(int qty MEMBER m_qty READ qty WRITE setQty)

public:
    MenuItem()
    {
        this->setId(0);
        this->setName("");
        this->setQty(0);
    }

    MenuItem(int id, QString name, int qty)
    {
        this->setId(id);
        this->setName(name);
        this->setQty(qty);
    }

    int id() const {
        return m_id;
    }
    void setId(int newId) {
        m_id = newId;
    }

    QString name() const {
        return m_name;
    }
    void setName(QString newName) {
        m_name = newName;
    }

    int qty() const {
        return m_qty;
    }
    void setQty(int newQty) {
        m_qty = newQty;
    }

private:
    int m_id;
    QString m_name;
    int m_qty;
};

struct Order {
    Q_GADGET

    Q_PROPERTY(int id MEMBER m_id READ id WRITE setId)
    Q_PROPERTY(int tableId MEMBER m_tableId READ tableId WRITE setTableId)
    Q_PROPERTY(QVector <MenuItem> items MEMBER m_items READ items WRITE setItems)

public:
    int id() const {
        return m_id;
    }
    void setId(int newId) {
        m_id = newId;
    }

    int tableId() const {
        return m_tableId;
    }
    void setTableId(int newId) {
        m_tableId = newId;
    }

    QVector <MenuItem> items() const {
        return m_items;
    }
    void setItems(QVector <MenuItem> newItems) {
        m_items = newItems;
    }

private:
    int m_id;
    int m_tableId;
    QVector <MenuItem> m_items;
};

Q_DECLARE_METATYPE(MenuItem);
Q_DECLARE_METATYPE(Order);

class AppController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(MenuItem currentMenuItem READ currentMenuItem WRITE setCurrentMenuItem NOTIFY currentMenuItemChanged)
    Q_PROPERTY(Order currentOrder READ currentOrder WRITE setCurrentOrder NOTIFY currentOrderChanged)
    Q_PROPERTY(QVector <Order> orders READ orders WRITE setOrders NOTIFY ordersChanged)

public:
    explicit AppController(QObject *parent = nullptr);

    Q_INVOKABLE void addMenuItemToOrder();
    Q_INVOKABLE void addOrder();

    void initializeQmlContext(QQmlEngine *engine);


    const Order &currentOrder() const;
    void setCurrentOrder(const Order &newCurrentOrder);

    const QVector<Order> &orders() const;
    void setOrders(const QVector<Order> &newOrders);

    const MenuItem &currentMenuItem() const;
    void setCurrentMenuItem(const MenuItem &newCurrentMenuItem);

signals:
    void currentOrderChanged();

    void ordersChanged();

    void currentMenuItemChanged();

private:
    QQmlEngine *_engine;
    DBManager *_dbManager;
    Order m_currentOrder;
    QVector<Order> m_orders;
    MenuItem m_currentMenuItem;
};
