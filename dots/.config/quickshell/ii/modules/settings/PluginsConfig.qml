import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets
import qs.services

ContentPage {
    forceWidth: true

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
            text: Config.options.plugins.disabled.join(", ")
            wrapMode: TextEdit.Wrap
            onTextChanged: {
                Config.options.plugins.disabled = text
                .split(",")
                .map(id => id.trim())
                .filter(id => id.length > 0);
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
