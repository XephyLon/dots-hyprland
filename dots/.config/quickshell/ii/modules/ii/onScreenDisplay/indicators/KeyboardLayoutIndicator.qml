import qs.services
import qs.modules.common
import qs.modules.common.widgets
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property real valueIndicatorVerticalPadding: 9
    property real valueIndicatorLeftPadding: 10
    property real valueIndicatorRightPadding: 20

    implicitWidth: Appearance.sizes.osdWidth + 2 * Appearance.sizes.elevationMargin
    implicitHeight: valueIndicator.implicitHeight + 2 * Appearance.sizes.elevationMargin

    StyledRectangularShadow {
        target: valueIndicator
    }
    Rectangle {
        id: valueIndicator
        anchors {
            fill: parent
            margins: Appearance.sizes.elevationMargin
        }
        radius: Appearance.rounding.full
        color: Appearance.colors.colLayer0

        implicitWidth: contentRow.implicitWidth
        implicitHeight: contentRow.implicitHeight

        RowLayout {
            id: contentRow
            anchors.fill: parent
            spacing: 10

            Item {
                implicitWidth: 30
                implicitHeight: 30
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: root.valueIndicatorLeftPadding
                Layout.topMargin: root.valueIndicatorVerticalPadding
                Layout.bottomMargin: root.valueIndicatorVerticalPadding

                MaterialSymbol {
                    anchors.centerIn: parent
                    color: Appearance.colors.colOnLayer0
                    text: "keyboard"
                    iconSize: 20
                }
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter
                Layout.rightMargin: root.valueIndicatorRightPadding
                spacing: 2

                StyledText {
                    color: Appearance.colors.colOnLayer0
                    font.pixelSize: Appearance.font.pixelSize.small
                    text: Translation.tr("Keyboard Layout")
                }

                StyledText {
                    color: Appearance.colors.colOnLayer0
                    font.pixelSize: Appearance.font.pixelSize.normal
                    font.weight: Font.Bold
                    animateChange: true
                    text: HyprlandXkb.currentLayoutName
                }
            }
        }
    }
}
