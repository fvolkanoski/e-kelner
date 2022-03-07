#include "appcontroller.h"

#include <QQmlContext>
#include <QDebug>

AppController::AppController(QObject *parent)
    : QObject{parent},
      _engine(new QQmlEngine(this)),
      _dbManager(new DBManager(this))
{
    qRegisterMetaType<MenuItem>();
    qRegisterMetaType<Order>();

//    Order o;
//    o.setId(0);
//    o.setTableId(0);

//    QVector <MenuItem> m;
//    m.push_back(MenuItem(0, "TEST", 2));
//    m.push_back(MenuItem(1, "TEST2", 3));

//    o.setItems(m);
//    m_orders.push_back(o);
//    m_orders.push_back(o);
}

void AppController::addMenuItemToOrder()
{
    Order tempOrd = currentOrder();
    QVector <MenuItem> tempItems = tempOrd.items();

    tempItems.push_back(currentMenuItem());

    tempOrd.setItems(tempItems);

    setCurrentOrder(tempOrd);
}

void AppController::addOrder()
{
    QVector <Order> tempOrders = orders();

    tempOrders.push_back(currentOrder());

    setOrders(tempOrders);

    Order ord;
    setCurrentOrder(ord);
}

void AppController::initializeQmlContext(QQmlEngine *engine)
{
    if (!engine)
        return;

    _engine = engine;

    _engine->rootContext()->setContextProperty("appController", this);
    _engine->rootContext()->setContextProperty("dbManager", _dbManager);  
}

const Order &AppController::currentOrder() const
{
    return m_currentOrder;
}

void AppController::setCurrentOrder(const Order &newCurrentOrder)
{
    m_currentOrder = newCurrentOrder;
    emit currentOrderChanged();
}

const QVector<Order> &AppController::orders() const
{
    return m_orders;
}

void AppController::setOrders(const QVector<Order> &newOrders)
{
    m_orders = newOrders;
    emit ordersChanged();
}

const MenuItem &AppController::currentMenuItem() const
{
    return m_currentMenuItem;
}

void AppController::setCurrentMenuItem(const MenuItem &newCurrentMenuItem)
{
    m_currentMenuItem = newCurrentMenuItem;
    emit currentMenuItemChanged();
}
