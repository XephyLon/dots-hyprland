pragma Singleton

import qs.modules.common
import QtQuick
import Qt.labs.folderlistmodel
import Quickshell

Singleton {
    id: root

    readonly property bool pluginsEnabled: Config.options?.plugins?.enable ?? false
    readonly property list<string> disabledPlugins: Config.options?.plugins?.disabled ?? []
    readonly property list<var> configuredFamilyMap: Config.options?.plugins?.familyMap ?? []
    property list<var> discoveredPlugins: []

    function ensureFileUrl(path) {
        const pathString = `${path ?? ""}`;
        if (pathString.startsWith("file://")) {
            return pathString;
        }
        return `file://${pathString}`;
    }

    function normalizeFamilies(families) {
        if (!Array.isArray(families) || families.length === 0) {
            return ["ii", "waffle"];
        }
        return families.filter(family => family === "ii" || family === "waffle");
    }

    function getFamiliesForPlugin(pluginId) {
        for (const entry of configuredFamilyMap) {
            if (entry?.id === pluginId) {
                const normalized = normalizeFamilies(entry.families);
                if (normalized.length > 0) {
                    return normalized;
                }
            }
        }
        return ["ii", "waffle"];
    }

    function shouldLoadPlugin(pluginId) {
        if (!pluginsEnabled) return false;
        return !disabledPlugins.includes(pluginId);
    }

    function rebuildDiscoveredPlugins() {
        const discovered = [];
        for (let i = 0; i < pluginsFolder.count; i++) {
            const fileName = pluginsFolder.get(i, "fileName");
            const filePath = pluginsFolder.get(i, "filePath");
            if (!fileName || !filePath || !fileName.endsWith(".qml")) continue;

            const pluginId = fileName.replace(/\.qml$/, "");
            if (!shouldLoadPlugin(pluginId)) continue;

            discovered.push({
                "id": pluginId,
                "families": getFamiliesForPlugin(pluginId),
                    "source": ensureFileUrl(filePath),
            });
        }
        root.discoveredPlugins = discovered;
    }

    FolderListModel {
        id: pluginsFolder
        folder: ensureFileUrl(Directories.userPlugins)
        showDirs: false
        showHidden: false
        nameFilters: ["*.qml"]
        sortField: FolderListModel.Name
        onCountChanged: root.rebuildDiscoveredPlugins()
    }

    Connections {
        target: root
        function onPluginsEnabledChanged() {
            root.rebuildDiscoveredPlugins()
        }
        function onDisabledPluginsChanged() {
            root.rebuildDiscoveredPlugins()
        }
        function onConfiguredFamilyMapChanged() {
            root.rebuildDiscoveredPlugins()
        }
    }

    Component.onCompleted: {
        root.rebuildDiscoveredPlugins()
    }
}
