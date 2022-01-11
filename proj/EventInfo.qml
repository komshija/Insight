import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import com.db 1.0

Page {
    id: registerPage

    property real lan: 0
    property real lot: 0
    property var event;
    property bool owner;

    Component.onCompleted: {
        event = getClickedEvent();
        typepicker.model = DatabaseManager.getTypes();
        typepicker.currentIndex = event[4] - 1;
        //console.log(event);
        owner = usermng.getUserId() === event[5];
    }

    background: Rectangle {
        color: backGroundColor
    }

    Text {
        id: createEventText
        text: qsTr("Event info")
        font.pointSize: 24
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        color: mainTextCOlor
    }

    ColumnLayout {
        width: parent.width
        anchors.top: createEventText.bottom
        anchors.topMargin: 30
        spacing: 25

        TextField {
            id: eventCreateName
            placeholderText: "Name"//name
            Layout.preferredWidth: parent.width - 20
            Layout.alignment: Qt.AlignHCenter
            color: mainTextCOlor
            font.pointSize: 14
            font.family: "fontawesome"

            enabled: owner
            text: event[1]
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 50
                radius: implicitHeight / 2
                color: "transparent"

                Text {
                    text: "\uf5b7"
                    font.pointSize: 14
                    font.family: "fontawesome"
                    color: mainAppColor
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: 10
                }

                Rectangle {
                    width: parent.width - 10
                    height: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    color: mainAppColor
                }
            }
        }

        DatePicker {
            id: startDate
            icon: '\uf271'
            enabled: owner
            value: event[6]
        }

        DatePicker {
            id: endDate
            icon: '\uf272'
            enabled: owner
            value: event[7]
        }


        ComboBox {
            id: typepicker

            Layout.preferredWidth: parent.width - 20
            Layout.alignment: Qt.AlignHCenter
            enabled: owner
            leftPadding: 35

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 50
                radius: implicitHeight / 2
                color: "transparent"

                Text {
                    text: "\uf3c5"
                    font.pointSize: 14
                    font.family: "fontawesome"
                    color: mainAppColor
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: 10
                }

                Rectangle {
                    width: parent.width - 10
                    height: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    color: mainAppColor
                }
            }

            contentItem: Text {


                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: typepicker.displayText
                    font.pointSize: 14
                    font.family: "fontawesome"
                    color: mainTextCOlor
            }


            popup: Popup {
                   y: typepicker.height - 1
                   width: typepicker.width
                   implicitHeight: contentItem.implicitHeight
                   padding: 1

                   contentItem: ListView {
                       clip: true
                       implicitHeight: contentHeight
                       model: typepicker.popup.visible ? typepicker.delegateModel : null
                       currentIndex: typepicker.highlightedIndex

                       ScrollIndicator.vertical: ScrollIndicator { }
                   }

                   background: Rectangle {
                       color: mainAppColor
                   }
               }
        }

        Item {
            height: 20
        }

        CustomButton {
            height: 50
            Layout.preferredWidth: parent.width - 20
            Layout.alignment: Qt.AlignHCenter
            name: "Update event"
            baseColor: mainAppColor
            borderColor: mainAppColor
            visible: owner
            enabled: owner
            onClicked: {
                eventmng.updateEvent(event[0], eventCreateName.text, typepicker.currentIndex + 1, startDate.value, endDate.value);
                popupBar.popMessage = "Event updated"
                popupBar.open();
                stackView.pop()
            }
        }

        CustomButton {
            height: 50
            Layout.preferredWidth: parent.width - 20
            Layout.alignment: Qt.AlignHCenter
            name: "Remove event"
            baseColor: backGroundColor
            borderColor: mainAppColor
            visible: owner
            enabled: owner
            onClicked: {
                eventmng.removeEvent(event[0]);
                popupBar.popMessage = "Event removed"
                popupBar.open();
                stackView.pop()
            }
        }


        CustomButton {
            height: 50
            Layout.preferredWidth: parent.width - 20
            Layout.alignment: Qt.AlignHCenter
            name: "Cancel"
            baseColor: "transparent"
            borderColor: mainAppColor
            onClicked: stackView.pop()
        }
    }
}
