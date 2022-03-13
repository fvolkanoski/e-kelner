import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 1024
    height: 600
    visible: true

    ListView {
        id: itemList
        x: 37
        y: 20
        width: 950
        height: 560
        model: appController.items
        spacing: 5

        delegate: Item {
            required property var modelData

            id: itemContainer
            height: 100
            width: 950
            anchors.right: parent.right

            Rectangle
            {
                id: itemRect
                height: 100
                width: 950
                color: "#34495E"
                radius: 10
                anchors.right: parent.right

                Rectangle {
                    id: qtyRect
                    anchors.right: parent.right
                    height: 100
                    width: 100
                    color: "#ffffff"
                    border.color: "#34495E"
                    border.width: 3
                    radius: 10

                    Text
                    {
                        anchors.centerIn: parent
                        text: itemContainer.modelData.qty
                        font.pixelSize: 70
                        font.family: "nunito";
                        color: "#34495E"
                    }
                }

                Text
                {
                    x: 25
                    y: 0
                    text: itemContainer.modelData.name
                    font.pixelSize: 70
                    font.family: "nunito";
                    color: "#ffffff"
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        //
                    }
                }

                Flickable {
                    id: swipeArea
                    anchors.fill: parent
                    flickableDirection: Flickable.HorizontalFlick

                    onFlickStarted: {
                        if (horizontalVelocity < 0) {
                            console.log("swiped right")

                            itemReduceWidth.running = true
                            itemResetWidthTimer.start()
                        }
                        if (horizontalVelocity > 0) {
                            console.log("swiped left")
                        }
                    }
                    boundsMovement: Flickable.StopAtBounds
                    pressDelay: 0
                }

                PropertyAnimation {
                    id: itemReduceWidth
                    target: itemRect
                    property: "width"
                    to: 750
                    duration: 100
                }

                PropertyAnimation {
                    id: itemResetWidth
                    target: itemRect
                    property: "width"
                    to: 950
                    duration: 100
                }

                Timer {
                    id: itemResetWidthTimer
                    running: false
                    repeat: false
                    interval: 5000

                    onTriggered: {
                        itemResetWidth.running = true
                    }
                }
            }

            Rectangle {
                id: deleteItemBtn
                x: 0
                y: 0
                z: -1
                width: 250
                height: 100
                radius: 10
                color: "#E74C3C"
            }

        }

        addDisplaced: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 200 }
            NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 200 }
        }
    }

    FontLoader {
        id: nunito;
        source: "qrc:/res/Fonts/Nunito-Regular.ttf";
    }

    FontLoader {
        id: nunito_bold;
        source: "qrc:/res/Fonts/Nunito-Bold.ttf";
    }

}
