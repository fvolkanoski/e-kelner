import QtQuick 2.15

Item {
    id: root
    property int tableId
    signal tableClicked(int tableId)

    Rectangle {
        id: tableRect
        width: 90
        height: 90
        color: "#27AE60"
        radius: 15

        RotationAnimation on rotation {
            id: tableRectAnim
            loops: 1
            from: -2
            to: 2
            running: false
            duration: 150
            alwaysRunToEnd: false

            onFinished: {
                if(from === -2)
                    from = 2
                else
                    from = -2

                if(to === 2)
                    to = -2
                else
                    to = 2

                start()
            }
        }

        Rectangle {
            id: deleteBtn
            x: 65
            y: -10
            z: 1
            width: 46
            height: 46
            color: "#E74C3C"
            radius: 50
            visible: false
            enabled: false

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                y: -5
                text: "-"
                font.family: "nunito"
                font.pixelSize: 36
                color: "#ffffff"
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    dbManager.deleteDBTable(tableId);
                    root.destroy()
                }
            }
        }

        Text {
            anchors.centerIn: parent
            font.family: "nunito"
            font.pixelSize: 36
            color: "#ffffff"
            text: tableId
        }

        Drag.active: dragArea.drag.active
        Drag.hotSpot.x: 10
        Drag.hotSpot.y: 10

        MouseArea {
            id: dragArea
            anchors.fill: parent

            drag.target: parent

            onClicked: {
                root.tableClicked(tableId)
            }

            onPressAndHold: {
                deleteBtn.visible = true
                deleteBtn.enabled = true
                deleteBtnInterval.start()
                tableRectAnim.start()
            }

            onReleased: {
                var globalCoordinates = tableRect.mapToItem(tableRect.parent.parent, 0, 0)
                 console.log(tableId + " " + globalCoordinates.x + " " + globalCoordinates.y)
                dbManager.updateTablePos(tableId, globalCoordinates.x, globalCoordinates.y)
            }
        }
    }

    Timer {
        id: deleteBtnInterval
        interval: 5000
        running: false
        repeat: false

        onTriggered: {
            deleteBtn.visible = false
            deleteBtn.enabled = false
            tableRectAnim.stop()
            tableRect.rotation = 0
        }
    }
}
