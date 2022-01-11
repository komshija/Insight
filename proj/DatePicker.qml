import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.15


Item {
    id: root

    property alias value: datePicker.value
    property alias min: datePicker.min
    property alias max: datePicker.max

    property string icon: "\uf271"

    property string dateFormat: "dd.MM.yyyy HH:mm"

    signal valueUpdated(var value)

    Layout.alignment: Qt.AlignHCenter
    implicitWidth: parent.width - 20
    implicitHeight: inputField.implicitHeight

    TextField {
        id: inputField

        implicitWidth: root.implicitWidth
        readOnly: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color: mainTextCOlor

        text: datePicker.value.toLocaleString(Qt.locale(), root.dateFormat)

        onPressed: datePicker.open()

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 50
            radius: implicitHeight / 2
            color: "transparent"

            Text {
                text: icon
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

    Popup {
        id: datePicker

        property date value: new Date()
        property date min: new Date(1970, 0, 1)
        property date max: new Date(2037, 11, 31)
        property int fontSize: 16

        signal valueUpdated(var value)

        modal: true
        focus: true
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        rightPadding: 20
        leftPadding: 20

        onOpened: {
            yearTumbler.currentIndex = datePicker.value.getFullYear() - datePicker.min.getFullYear()

            if(datePicker.isMinYear()) {
                monthTumbler.currentIndex = (datePicker.value.getMonth() - datePicker.min.getMonth())
            } else {
                monthTumbler.currentIndex = datePicker.value.getMonth()
            }

            if(datePicker.isMinYear() && datePicker.isMinMonth()) {
                dayTumbler.currentIndex = (datePicker.value.getDate() - datePicker.min.getDate())
            } else {
                dayTumbler.currentIndex = datePicker.value.getDate() - 1
            }
            hourTumbler.currentIndex = datePicker.value.getHours() - 1;
            minuteTumbler.currentIndex = datePicker.value.getMinutes();

        }

        onClosed: {
            datePicker.value = new Date(datePicker.currentYear(yearTumbler.currentIndex),
                                        datePicker.currentMonth(monthTumbler.currentIndex),
                                        datePicker.currentDay(dayTumbler.currentIndex),
                                        hourTumbler.currentItem.text ,
                                        minuteTumbler.currentItem.text
                                        );
            datePicker.valueUpdated(datePicker.value);
        }

        background: Rectangle {
            color: mainAppColor
        }



        Row {
            spacing: 10

            Tumbler {
                id: yearTumbler

                model: datePicker.max.getFullYear() - datePicker.min.getFullYear() + 1

                delegate: Label {
                    opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)

                    text: datePicker.currentYear(modelData)
                    font.pointSize: datePicker.fontSize
                    color: mainTextCOlor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    function displacementItemOpacity(displacement, visibleItemCount) {
                        return 1.0 - Math.abs(displacement) / (visibleItemCount / 2)
                    }
                }


            }

            Tumbler {
                id: monthTumbler

                width: 100

                model: {
                    var months = 12

                    if(datePicker.isMaxYear()) {
                        months = datePicker.max.getMonth() + 1
                    }

                    if(datePicker.isMinYear()) {
                        months -= datePicker.min.getMonth()
                    }

                    return months
                }

                delegate: Label {
                    opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)

                    text: Qt.locale().standaloneMonthName(datePicker.currentMonth(modelData))
                    font {
                        capitalization: Font.Capitalize
                        pointSize: datePicker.fontSize
                    }

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: mainTextCOlor

                    function displacementItemOpacity(displacement, visibleItemCount) {
                        return 1.0 - Math.abs(displacement) / (visibleItemCount / 2)
                    }
                }
           }

            Tumbler {
                id: dayTumbler

                model: {
                    var days = datePicker.daysInMonth(datePicker.currentYear(yearTumbler.currentIndex),
                                           datePicker.currentMonth(monthTumbler.currentIndex))

                    if(datePicker.isMaxYear() && datePicker.isMaxMonth()) {
                        days = datePicker.max.getDate()
                    }

                    if(datePicker.isMinYear() && datePicker.isMinMonth()) {
                        days -= (datePicker.min.getDate() - 1)
                    }

                    return days
                }

                delegate: Label {
                    opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)

                    text: datePicker.currentDay(modelData)
                    font.pointSize: datePicker.fontSize
                    color: mainTextCOlor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    function displacementItemOpacity(displacement, visibleItemCount) {
                        return 1.0 - Math.abs(displacement) / (visibleItemCount / 2)
                    }
                }
            }

            Tumbler {
                id: hourTumbler

                model: 24;

                delegate: Label {
                    opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)

                    text: datePicker.formatText(hourTumbler.count, modelData)
                    font.pointSize: datePicker.fontSize
                    color: mainTextCOlor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    function displacementItemOpacity(displacement, visibleItemCount) {
                        return 1.0 - Math.abs(displacement) / (visibleItemCount / 2)
                    }
                }
            }

            Tumbler {
                id: minuteTumbler

                model: 60

                delegate: Label {
                    opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)

                    text: datePicker.formatText(minuteTumbler.count, modelData)
                    font.pointSize: datePicker.fontSize
                    color: mainTextCOlor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    function displacementItemOpacity(displacement, visibleItemCount) {
                        return 1.0 - Math.abs(displacement) / (visibleItemCount / 2)
                    }
                }
            }



        }

        function formatText(count, modelData) {
            var data = count === 24 ? modelData + 1 : modelData;
            return data.toString().length < 2 ? "0" + data : data;
        }

        function isMinYear() {
            return yearTumbler.currentIndex === 0
        }

        function isMaxYear() {
            return yearTumbler.currentIndex === (yearTumbler.model - 1)
        }

        function isMinMonth() {
            return monthTumbler.currentIndex === 0
        }

        function isMaxMonth() {
            return monthTumbler.currentIndex === (monthTumbler.model - 1)
        }

        function currentYear(yearIdx) {
            return yearIdx + root.min.getFullYear()
        }

        function currentMonth(monthIdx) {
            if(yearTumbler.currentIndex === 0) {
                return monthIdx + root.min.getMonth()
            } else {
                return monthIdx
            }
        }

        function currentDay(dayIdx) {
            if(yearTumbler.currentIndex === 0 && monthTumbler.currentIndex === 0) {
                return dayIdx + root.min.getDate()
            } else {
                return dayIdx + 1
            }
        }

        function daysInMonth(year, month) {
            return new Date(year, month + 1, 0).getDate();
        }
    }


}



