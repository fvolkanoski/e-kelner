import QtQuick 2.15

import "../Components"

Item {
    id: root

    property int tableIndex: 1

    signal tableChoosed(int tableId)

    Text {
        id: tableChoose
        x: parent.width / 2 - (tableChoose.width / 2 + 40)
        y: 25
        color: "#000000"
        text: "Избор на маса: "
        font.pixelSize: 36
        font.family: "nunito"
    }

    Rectangle {
        x: tableChoose.x + tableChoose.width + 20
        y: 15
        width: 69
        height: 69
        color: "#27AE60"
        radius: 15

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 5
            font.family: "nunito"
            font.pixelSize: 36
            color: "#ffffff"
            text: "+"
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                tableIndex++;
                addNewTable(tableIndex, 25, 25)
                dbManager.appendNewDBTable(tableIndex, 25, 25)
            }
        }
    }

    Connections {
        target: dbManager

        function onAddTable(id, x, y)
        {
            addNewTable(id, x, y)
            tableIndex = id;
        }
    }

    function addNewTable(id, x, y)
    {
        var component;
        var sprite;
        component = Qt.createComponent("qrc:/qml/Components/Table.qml");
        sprite = component.createObject(root, {"x": x, "y": y, "tableId": id});
        sprite.tableClicked.connect(tableChoosed)
    }
}


