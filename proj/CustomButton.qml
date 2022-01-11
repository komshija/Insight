import QtQuick 2.6
import QtQuick.Controls 2.0

Button {
    id: control
    text: qsTr("Log In")
    font.pointSize: 16

    property alias name: control.text
    property color baseColor
    property color borderColor

    onPressed: control.state = "PRESSED"
    onReleased: control.state = ""

    state: ""

    states: [
        State {
            name: ""
        },
        State {
            name: "PRESSED"
            PropertyChanges {
                target: control;
                baseColor: control.baseColor == mainAppColor ? backGroundColor : mainAppColor
            }
        }
    ]

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.down ? "#ffffff" : "#ffffff"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        id: bgrect
        implicitWidth: 100
        implicitHeight: 50
        color: baseColor
        opacity: 1
        radius: height/2
        border.color: borderColor
    }
}
