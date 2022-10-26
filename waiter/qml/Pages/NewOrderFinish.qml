import QtQuick 2.15

Item {
    id: root

    signal addItemClicked()
    signal finishOrder()

    Rectangle {
        x: 0
        y: 0
        z: 1
        width: 600
        height: 49
        color: "#ffffff"

        Text {
            x: 42
            y: 25
            color: "#000000"
            text: "Ставки:"
            font.pixelSize: 36
            font.family: "nunito"
        }
    }

    Rectangle
    {
        x: 205
        y: 14
        height: 72
        width: parent.width - 300
        color: "#2ECC71"
        radius: 10
        z: 1

        Text
        {
            anchors.centerIn: parent
            text: "ДОДАЈ СТАВКА"
            font.pixelSize: 30
            font.family: "nunito";
            color: "#ffffff"
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                addItemClicked()
            }
        }
    }

    ListView {
        id: waiterList
        x: 43
        y: 120
        width: parent.width - 43
        height: parent.height - 50
        model: appController.currentOrder.items
        spacing: 5

        delegate: Item {
            id: itemModel
            height: 90
            width: parent.width - 50
            required property var modelData

            Rectangle
            {
                x: 0
                y: 0
                height: 90
                width: parent.width - 100
                color: "#34495E"
                radius: 10

                Text
                {
                    anchors.centerIn: parent
                    text: itemModel.modelData.name
                    font.pixelSize: 36
                    font.family: "nunito";
                    color: "#ffffff"
                }

                Rectangle {
                    x: parent.width - 15
                    y: 0
                    width: 90
                    height: 90
                    border.color: "#34495E"
                    border.width: 3
                    radius: 10

                    Text
                    {
                        anchors.centerIn: parent
                        text: itemModel.modelData.qty
                        font.pixelSize: 36
                        font.family: "nunito";
                        color: "#34495E"
                    }
                }
            }
        }
    }

    Rectangle {
        x: 42
        y: parent.height - 150
        radius: 10
        width: parent.width - 84
        height: 90
        color: "#27AE60"

        Text {
            anchors.centerIn: parent
            color: "#ffffff"
            text: "ЗАВРШИ"
            font.pixelSize: 36
            font.family: "nunito_bold"
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                finishOrder()
            }
        }
    }
}


