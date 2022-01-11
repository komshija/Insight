import QtQuick 2.0
import QtPositioning 5.12
import QtLocation 5.12

MapQuickItem {
    property int eventid: -1
    property string name: ""
    property real lat: 0
    property real lon: 0
    property int type: -1
    property int createdBy: -1
    property date startDate;
    property date endDate;
    //property string imgSource: "qrc:/placeholder.png"

    function getPicture(type) {
        var result;
        switch(type) {
        case 1:

            result = "qrc:/zurka.png"
            break;
        case 2:
            result = "qrc:/put.png"
            break;
        case 3:
            result = "qrc:/music.png"
            break;
        case 4:
            result = "qrc:/leaking.png"
            break;
        case 5:
            result = "qrc:/sport.png"
            break;
        default:
            result = "qrc:/placeholder.png"
            break;
        }
        return result;
    }


    id:placeholderEvent
    anchorPoint.x:image.width/2
    anchorPoint.y:image.height
    sourceItem: Image {
        id: image
        source: getPicture(type)
        height: 24
        width: 24
        MouseArea {
            id: placeholderArea
            anchors.fill: parent
            hoverEnabled: true
            onDoubleClicked:  {
                var event = [eventid, name, lat, lon, type, createdBy, startDate, endDate];
                setClickedEvent(event);
                console.log(event);
                stackView.push("qrc:/EventInfo.qml");
            }
        }
    }
    coordinate: QtPositioning.coordinate(lat,lon)
}
