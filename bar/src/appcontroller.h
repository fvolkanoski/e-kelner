#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QUdpSocket>

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

Q_DECLARE_METATYPE(MenuItem);

class AppController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector <MenuItem> items READ items WRITE setItems NOTIFY itemsChanged)

public:
    explicit AppController(QObject *parent = nullptr);

    void initializeQmlContext(QQmlEngine *engine);

    const QVector<MenuItem> &items() const;
    void setItems(const QVector<MenuItem> &newItems);

signals:
    void itemsChanged();

private slots:
    void processPendingDatagrams();

private:
    QQmlEngine *_engine;
    QUdpSocket *_udpSocket;

    QVector<MenuItem> m_items;
};
