import QtQuick 2.15

Item
{
    id: root
    signal newOrder(int orderId)

    property int orderId: 0

    Rectangle
    {
        x: 42
        y: 23
        height: 81
        width: parent.width - 100
        color: "#3498DB"
        radius: 10

        Text
        {
            anchors.centerIn: parent
            text: "НОВА НАРАЧКА"
            font.pixelSize: 36
            font.family: "nunito"
            color: "#ffffff"
        }

        MouseArea
        {
            anchors.fill: parent

            onClicked: {
                root.newOrder(orderId)
                orderId++;
            }
        }
    }

    ListView {
        id: orderList
        x: 43
        y: 120
        z: -1
        width: parent.width - 50
        height: parent.height - 50
        model: appController.orders
        spacing: 10

        delegate: Rectangle {
            required property var modelData

            height: 430
            width: 515
            color: "#d8d8d8"
            radius: 10

            Rectangle {
                x: 0
                y: 0
                width: parent.width
                height: 51
                color: "#27AE60"
                radius: 10
            }

            ListView {
                x: 30
                y: 70
                z: 1
                width: parent.width
                height: parent.height - 50
                model: parent.modelData.items
                spacing: 5

                delegate: Rectangle {
                    required property var modelData

                    height: 63
                    width: 463
                    color: "#34495E"
                    radius: 10

                    Rectangle {
                        anchors.right: parent.right
                        width: 81
                        height: 63
                        color: "#ffffff"
                        radius: 10
                        border.color: "#34495E"
                        border.width: 3
                    }

                    Text
                    {
                        x: 15
                        y: 5
                        text: parent.modelData.name
                        font.pixelSize: 36
                        font.family: "nunito";
                        color: "#ffffff"
                    }

                    Text
                    {
                        x: 413
                        y: 5
                        text: parent.modelData.qty
                        font.pixelSize: 36
                        font.family: "nunito";
                        color: "#34495E"
                    }
                }
            }

            Text
            {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "МАСА: " + parent.modelData.tableId
                font.pixelSize: 36
                font.family: "nunito";
                color: "#ffffff"
            }

            Rectangle {
                x: 25
                y: parent.height - 80
                width: 464
                height: 63
                color: "#27AE60"
                radius: 10

                Text
                {
                    anchors.centerIn: parent
                    text: "ЗАТВОРИ"
                    font.pixelSize: 36
                    font.family: "nunito_bold";
                    color: "#ffffff"
                }
            }
        }
    }
}
