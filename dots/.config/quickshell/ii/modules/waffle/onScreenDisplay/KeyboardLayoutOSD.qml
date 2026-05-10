import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

WBarAttachedPanelContent {
    id: root

    property Timer timer: Timer {
        id: autoCloseTimer
        running: true
        interval: Config.options.osd.timeout
        repeat: false
        onTriggered: {
            root.close();
        }
    }

    Connections {
        target: HyprlandXkb
        function onCurrentLayoutNameChanged() {
            root.timer.restart();
        }
    }

    contentItem: WPane {
        anchors.centerIn: parent
        borderColor: Looks.colors.ambientShadow

        contentItem: Item {
            implicitWidth: 192
            implicitHeight: 46

            RowLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 12

                FluentIcon {
                    Layout.alignment: Qt.AlignVCenter
                    icon: "keyboard"
                    implicitSize: 18
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 0

                    WText {
                        Layout.fillWidth: true
                        text: qsTr("Keyboard Layout")
                        font.pixelSize: Looks.font.pixelSize.normal * 0.85
                        color: Looks.colors.subfg
                        elide: Text.ElideRight
                    }

                    WText {
                        Layout.fillWidth: true
                        text: HyprlandXkb.currentLayoutName
                        font.pixelSize: Looks.font.pixelSize.normal
                        font.weight: Looks.font.weight.strong
                        elide: Text.ElideRight
                    }
                }
            }
        }
    }
}
