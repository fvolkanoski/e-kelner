import QtQuick 2.15

Item {
    id: root

    signal qtyChoosed(int qty)

    property int curQty: 1

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
            text: "Изберете количина:"
            font.pixelSize: 36
            font.family: "nunito"
        }
    }

    Item {
        x: parent.width / 2 - 200
        y: 145

        Rectangle {
            x: 0
            y: 0
            z: 2
            radius: 10
            width: 130
            height: 130
            color: "#D8D8D8"

            Text {
                anchors.centerIn: parent
                color: "#000000"
                text: "-"
                font.pixelSize: 36
                font.family: "nunito"
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if(curQty > 1)
                        curQty--;
                }
            }
        }

        Rectangle {
            x: 45
            y: 0
            z: 1
            radius: 10
            width: 306
            height: 130
            color: "#eeeeee"

            Text {
                anchors.centerIn: parent
                color: "#000000"
                text: curQty
                font.pixelSize: 36
                font.family: "nunito"
            }
        }

        Rectangle {
            x: 260
            y: 0
            z: 2
            radius: 10
            width: 130
            height: 130
            color: "#D8D8D8"

            Text {
                anchors.centerIn: parent
                color: "#000000"
                text: "+"
                font.pixelSize: 36
                font.family: "nunito"
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    curQty++;
                }
            }
        }
    }



    Rectangle {
        x: parent.width / 2 - (344/2)
        y: parent.height - 150
        radius: 10
        width: 344
        height: 130
        color: "#2ECC71"

        Text {
            anchors.centerIn: parent
            color: "#ffffff"
            text: "ДОДАЈ"
            font.pixelSize: 36
            font.family: "nunito"
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                qtyChoosed(curQty)
            }
        }
    }
}


