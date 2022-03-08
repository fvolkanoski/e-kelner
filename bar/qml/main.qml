import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 1024
    height: 600
    visible: true



    FontLoader {
        id: nunito;
        source: "qrc:/res/Fonts/Nunito-Regular.ttf";
    }

    FontLoader {
        id: nunito_bold;
        source: "qrc:/res/Fonts/Nunito-Bold.ttf";
    }

}
