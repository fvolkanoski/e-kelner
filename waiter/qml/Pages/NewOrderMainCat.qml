import QtQuick 2.15

Item {
    id: root

    signal categoryChoosed(int catId)

    property var colors: [ '#34495e', '#f1c40f', '#e58e26', '#1bb47d', '#e52676' ]
    property var darkColors: [ '#34495e', '#e58e26', '#e52676' ]
    property int itemIndex: 0

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
        id: categoriesList
        x: 15
        y: 125
        width: 570
        height: 900
        model: dbManager.categories
        spacing: 5

        delegate: Rectangle
        {
            required property string modelData

            height: 110
            width: 570
            radius: 15

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
                    categoryChoosed(categoriesList.indexAt(parent.x, parent.y))
                }
            }

            Component.onCompleted:
            {
                var clr = colors[itemIndex]
                color = clr

                if(darkColors.indexOf(clr) > -1)
                    itemText.color = "#ffffff"

                itemIndex++;
            }
        }
    }
}


