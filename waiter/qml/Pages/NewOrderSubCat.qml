import QtQuick 2.15

Item {
    id: root

    signal itemChoosed(int itemId, string name)

    Rectangle {
        x: 0
        y: 25
        z: 1
        width: 600
        height: 49
        color: "#ffffff"

        Text {
            anchors.centerIn: parent
            color: "#000000"
            text: "Изберете категорија:"
            font.pixelSize: 36
            font.family: "nunito"
        }
    }

    ListView {
        id: itemsList
        x: 15
        y: 125
        width: 570
        height: 900
        model: dbManager.items
        spacing: 5

        delegate: Rectangle
        {
            required property string modelData

            height: 110
            width: 570
            radius: 15
            color: "#D8D8D8"

            Text
            {
                id: itemText
                anchors.centerIn: parent
                text: parent.modelData
                font.pixelSize: 45
                font.family: "nunito";
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    itemChoosed(itemsList.indexAt(parent.x, parent.y), itemText.text)
                }
            }
        }
    }
}


