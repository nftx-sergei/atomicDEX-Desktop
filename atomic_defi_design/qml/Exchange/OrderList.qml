import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import "../Components"
import "../Constants"
import ".."

InnerBackground {
    property string title
    property var items
    property alias empty_text: no_orders.text_value
    property bool is_history: false

    Layout.fillWidth: true
    Layout.fillHeight: true

    ColumnLayout {
        width: parent.width
        height: parent.height

        DefaultText {
            text_value: title + " (" + items.length + ")"

            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.topMargin: 10

            font.pixelSize: Style.textSize2
        }

        HorizontalLine {
            Layout.fillWidth: true
            color: Style.colorWhite8
        }

        // No orders
        DefaultText {
            id: no_orders
            wrapMode: Text.Wrap
            visible: items.length === 0
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 20
            color: Style.colorWhite5

            text_value: qsTr("You don't have any orders.")
        }

        // List
        DefaultListView {
            id: list
            Layout.fillWidth: true
            Layout.fillHeight: true

            model: items.orders_proxy_mdl

            // Row
            delegate: OrderLine {
                details: model
            }
        }

        // Pagination
        Pagination {
            visible: is_history
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 10
            Layout.bottomMargin: Layout.topMargin
        }
    }

    DefaultBusyIndicator {
        id: loading
        visible: is_history && API.app.orders_mdl.fetching_busy

        anchors.centerIn: parent
    }
}
