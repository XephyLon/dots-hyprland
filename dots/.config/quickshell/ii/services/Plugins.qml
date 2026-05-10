pragma Singleton

import qs.modules.common
import QtQuick
import Qt.labs.folderlistmodel

Singleton {
    id: root

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
        const familyMap = Config.options?.plugins?.familyMap ?? [];
        for (const entry of familyMap) {
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
        if (!Config.options?.plugins?.enable) return false;
        return !(Config.options?.plugins?.disabled ?? []).includes(pluginId);
    }

    readonly property list<var> discoveredPlugins: {
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
        return discovered;
    }

    FolderListModel {
        id: pluginsFolder
        folder: Qt.resolvedUrl(Directories.userPlugins)
        showDirs: false
        showHidden: false
        nameFilters: ["*.qml"]
        sortField: FolderListModel.Name
    }
}
