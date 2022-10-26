import QtQuick 2.15

Item {
    id: root
    signal waiterChoosed(int waiterId)

    Rectangle {
        x: 0
        y: 25
        z: 1
        width: parent.width
        height: 49
        color: "#ffffff"

        Text {
            anchors.centerIn: parent
            color: "#000000"
            text: "Избор на вработен: "
            font.pixelSize: 36
        }
    }

    ListView {
        id: waiterList
        x: 43
        y: 103
        width: parent.width - 50
        height: parent.height - 100
        model: dbManager.waiters
        spacing: 5

        delegate: Rectangle
        {
            required property string modelData

            height: 81
            width: parent.width - 50
            color: "#d8d8d8"
            radius: 10

            Text
            {
                anchors.centerIn: parent
                text: parent.modelData
                font.pixelSize: 36
                font.family: "nunito";
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    root.waiterChoosed(waiterList.indexAt(parent.x, parent.y));
                }
            }
        }
    }
}
