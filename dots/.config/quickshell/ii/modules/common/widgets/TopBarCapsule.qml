import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions

Rectangle {
    id: root

    default property alias items: layout.children
    property alias layoutDirection: layout.layoutDirection

    property bool showBackground: Config.options.bar.showBackground
    property bool outlineOnly: false

    radius: height / 2
    color: showBackground && !outlineOnly ? Appearance.colors.colLayer0 : "transparent"
    border.width: outlineOnly ? 1 : (showBackground && Config.options.bar.cornerStyle === 1 ? 1 : 0)
    border.color: outlineOnly ? Appearance.colors.colOnLayer1 : Appearance.colors.colLayer0Border

    implicitWidth: layout.implicitWidth + height // padding matches radius on both sides
    implicitHeight: Appearance.sizes.baseBarHeight - (Config.options.bar.cornerStyle === 1 ? 0 : 8)

    // Add shadow
    Loader {
        active: showBackground && Config.options.bar.cornerStyle === 1 && Config.options.bar.floatStyleShadow
        anchors.fill: root
        z: -1
        sourceComponent: StyledRectangularShadow {
            anchors.fill: undefined
            target: root
        }
    }

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 8
    }
}
