import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtPositioning 5.2
import QtLocation 5.2
import com.db 1.0

Item {
    Map {
        id: osmMap
        Plugin {
            id: mapPlugin
            name: "osm" // Open Street Maps
        }

        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(43.3218, 21.8937) // Nis
        zoomLevel: 15
        copyrightsVisible: false

        Component.onCompleted: {
            loadItems();
            updateTimer.start();
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            acceptedButtons:  Qt.RightButton

            onClicked: {
                saveClickedCoord( osmMap.toCoordinate(Qt.point(mouse.x, mouse.y)) );
                contextMenu.x= mouse.x;
                contextMenu.y = mouse.y;
                contextMenu.open();
            }
        }

        Menu {
            id: contextMenu

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 40
                color: backGroundColor
            }

            delegate: MenuItem {
                id: menuItem
                contentItem: Text {
                            leftPadding: menuItem.indicator.width
                            rightPadding: menuItem.arrow.width
                            text: menuItem.text
                            font: menuItem.font
                            opacity: enabled ? 1.0 : 0.3
                            color: mainTextCOlor
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }

                        background: Rectangle {
                            implicitWidth: 200
                            implicitHeight: 40
                            opacity: enabled ? 1 : 0.3
                            color: menuItem.highlighted ? mainAppColor : "transparent"
                        }
            }

            Action {
                id: insertEvent
                text: 'Insert Event'

                onTriggered: {
                    stackView.push("qrc:/EventWrite.qml");
                }
            }

            Action {
                id: logout
                text: 'Logout'

                onTriggered: {
                    usermng.logout();
                    toLogin();
                }
            }
        }


        Timer {
            id: updateTimer
            interval: 1000
            repeat: true
            onTriggered: {
                osmMap.loadItems();
            }
        }


        function loadItems() {
            osmMap.clearMapItems();
            var allItemsIds = DatabaseManager.getEventsIds();

            for(var i = 0 ; i < allItemsIds.length ; i++)
            {
                var item = DatabaseManager.getEvent(allItemsIds[i]);

                var component = Qt.createComponent("EventPlaceholder.qml");
                var placeholder = component.createObject(osmMap, {eventid: item[0],name: item[1], type: item[2], lat: item[3], lon:item[4], createdBy:item[5], startDate: item[6], endDate: item[7]});
                osmMap.addMapItem(placeholder);
            }

        }
    }
}
