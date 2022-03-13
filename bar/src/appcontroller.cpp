#include <QQmlContext>

#include "appcontroller.h"

AppController::AppController(QObject *parent)
    : QObject{parent},
      _udpSocket(new QUdpSocket(this))
{
    qRegisterMetaType<MenuItem>();

    _udpSocket->bind(45454, QUdpSocket::ShareAddress);
    connect(_udpSocket, &QUdpSocket::readyRead, this, &AppController::processPendingDatagrams);

//    QVector <MenuItem> tempItems;
//    tempItems.push_back(MenuItem(0, "Test1", 2));
//    tempItems.push_back(MenuItem(1, "Test2", 1));

//    setItems(tempItems);
}

void AppController::initializeQmlContext(QQmlEngine *engine)
{
    if (!engine)
        return;

    _engine = engine;

    _engine->rootContext()->setContextProperty("appController", this);
}

const QVector<MenuItem> &AppController::items() const
{
    return m_items;
}

void AppController::setItems(const QVector<MenuItem> &newItems)
{
    m_items = newItems;
    emit itemsChanged();
}

void AppController::processPendingDatagrams()
{
    QByteArray datagram;

    while (_udpSocket->hasPendingDatagrams())
    {
        datagram.resize(int(_udpSocket->pendingDatagramSize()));

        _udpSocket->readDatagram(datagram.data(), datagram.size());

        qDebug() << datagram;

        QStringList itemSplit = QString(datagram).split(QLatin1Char(','));

        if(itemSplit.size() > 2)
        {
            QVector <MenuItem> tempItems = items();

            tempItems.push_back(MenuItem(itemSplit[0].toInt(), itemSplit[1], itemSplit[2].toInt()));

            setItems(tempItems);
        }
    }
}
