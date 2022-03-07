import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import "Pages"

Window {
    width: 600
    height: 1024
    visible: true

    SwipeView {
        id: swipeView
        interactive: false
        anchors.fill: parent

        WaiterChoose {
            onWaiterChoosed: {
                dbManager.waiterId = waiterId

                swipeView.setCurrentIndex(1)
            }
        }

        StartPage {
            onNewOrder: {
                dbManager.readTables()
                appController.currentOrder.id = orderId;

                swipeView.setCurrentIndex(2)
            }
        }

        NewOrder {
            onTableChoosed: {
                appController.currentOrder.tableId = tableId;

                swipeView.setCurrentIndex(3)
            }
        }

        NewOrderMainCat {
            onCategoryChoosed: {
                dbManager.readItemsFromCategory(catId)

                swipeView.setCurrentIndex(4)
            }
        }

        NewOrderSubCat {
            onItemChoosed: {
                appController.currentMenuItem.id = itemId;
                appController.currentMenuItem.name = name;

                swipeView.setCurrentIndex(5)
            }
        }

        NewOrderQty {
            onQtyChoosed: {
                appController.currentMenuItem.qty = qty;
                appController.addMenuItemToOrder()

                swipeView.setCurrentIndex(6)

                curQty = 1
            }
        }

        NewOrderFinish {
            onAddItemClicked: {
                swipeView.setCurrentIndex(3)
            }

            onFinishOrder: {
                appController.addOrder()
                swipeView.setCurrentIndex(1)
            }
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
