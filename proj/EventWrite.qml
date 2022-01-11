import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import com.db 1.0

Page {
    id: registerPage

    property real lan: 0
    property real lot: 0


    Component.onCompleted: {
        //Citaj iz baze imena
        typepicker.model = DatabaseManager.getTypes();
        lan = getClickedCoord().latitude
        lot = getClickedCoord().longitude
    }


    background: Rectangle {
        color: backGroundColor
    }

    Text {
        id: createEventText
        text: qsTr("Create event")
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
            placeholderText: qsTr("Name")
            Layout.preferredWidth: parent.width - 20
            Layout.alignment: Qt.AlignHCenter
            color: mainTextCOlor
            font.pointSize: 14
            font.family: "fontawesome"

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
        }

        DatePicker {
            id: endDate
            icon: '\uf272'
        }


        ComboBox {
            id: typepicker

            Layout.preferredWidth: parent.width - 20
            Layout.alignment: Qt.AlignHCenter


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
            name: "Create event"
            baseColor: mainAppColor
            borderColor: mainAppColor
            onClicked: {
                eventmng.insertEvent(eventCreateName.text, typepicker.currentIndex + 1, startDate.value, endDate.value, usermng.getUserId(), lan, lot);
                popupBar.popMessage = "Event created"
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
