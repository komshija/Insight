import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtPositioning 5.15
import QtLocation 5.15
import com.user 1.0
import com.event 1.0

Window {
    id: rootWindow
    visible: true
    width: 840
    height: 760
    title: qsTr("Insight")


    property color backGroundColor : "#394454"
    property color mainAppColor: "#ff6666"
    property color mainTextCOlor: "#f0f0f0"
    property color popupBackGroundColorSuccess: "#44bb4e"
    property color popupBackGroundColorFailed: "#b44"

    property color popupTextColor: "#ffffff"

    property var clickedCoord;
    property var clickedEvent: [];


    FontLoader {
        id: fontAwesome
        name: "fontawesome"
        source: "qrc:/fontawesome-webfont.ttf"
    }

    StackView {
        id: stackView
        focus: true
        anchors.fill: parent
    }

    // Obavestenja
    Popup {
        id: popupBar
        property alias popMessage: message.text

        background: Rectangle {
            implicitWidth: rootWindow.width
            implicitHeight: 30
            color: popupBackGroundColorFailed
        }
        y: (rootWindow.height - 30)
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        Text {
            id: message
            anchors.centerIn: parent
            font.pointSize: 12
            color: popupTextColor
        }
        onOpened: popupClose.start()
    }

    Timer {
        id: popupClose
        interval: 2000
        onTriggered: popupBar.close()
    }

    //Manager za upravljanje korisnicima
    User {
        id: usermng
    }

    //Manager za upravljanje dogadjajima
    Event {
        id: eventmng
    }

    //Inicijalni pogled
    Component.onCompleted: {
         stackView.push("qrc:/Login.qml")
    }

    //Prebacivanje izmedju pogleda
    function toRegister() {
        stackView.replace("qrc:/Register.qml")
    }

    function toLogin() {
        stackView.replace("qrc:/Login.qml")
    }

    function toInsight() {
        if(usermng.isLogin()) {
            stackView.replace("qrc:/Insight.qml")
//            popupBar.popMessage = "Login succesful";
//            popupBar.open();
        }
        else {
            popupBar.popMessage = "Login failed"
            popupBar.open();
        }
    }

    function saveClickedCoord(coord) {
        clickedCoord = coord;
    }

    function getClickedCoord() {
        return clickedCoord;
    }

    function setClickedEvent(event) {
        clickedEvent = event;
    }

    function getClickedEvent() {
        return clickedEvent;
    }
}
