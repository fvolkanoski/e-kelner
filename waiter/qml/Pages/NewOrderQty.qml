import QtQuick 2.15

Item {
    id: root

    signal qtyChoosed(int qty)

    property int curQty: 1

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
            text: "Изберете количина:"
            font.pixelSize: 36
            font.family: "nunito"
        }
    }

    Rectangle {
        x: 46
        y: 145
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
        x: 144
        y: 145
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
        x: 424
        y: 145
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

    Rectangle {
        x: 128
        y: 843
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


