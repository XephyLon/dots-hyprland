import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets
import qs.services

ContentPage {
    forceWidth: true
    property string disabledPluginsDraft: Config.options.plugins.disabled.join(", ")

    ContentSection {
        icon: "extension"
        title: Translation.tr("Plugins")

        ConfigSwitch {
            text: Translation.tr("Enable third-party plugins")
            checked: Config.options.plugins.enable
            onCheckedChanged: {
                Config.options.plugins.enable = checked;
            }
        }

        MaterialTextArea {
            Layout.fillWidth: true
            placeholderText: Translation.tr("Disabled plugin IDs (comma-separated)")
            text: disabledPluginsDraft
            wrapMode: TextEdit.Wrap
            onTextChanged: {
                disabledPluginsDraft = text;
                updateDisabledPluginsTimer.restart();
            }

            Timer {
                id: updateDisabledPluginsTimer
                interval: 500
                repeat: false
                onTriggered: {
                    Config.options.plugins.disabled = disabledPluginsDraft
                    .split(",")
                    .map(id => id.trim())
                    .filter(id => id.length > 0);
                }
            }
        }

        StyledText {
            Layout.fillWidth: true
            color: Appearance.colors.colSubtext
            wrapMode: Text.Wrap
            text: Translation.tr("Place plugin .qml files in: %1").arg(Directories.userPlugins)
        }
    }
}
