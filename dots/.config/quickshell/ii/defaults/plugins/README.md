## Third-party plugins

You can add custom shell plugins by dropping QML files into:

- `~/.config/illogical-impulse/plugins`

### 1) Enable plugin loading

In `~/.config/illogical-impulse/config.json`, set:

```json
{
  "plugins": {
    "enable": true
  }
}
```

### 2) Create a plugin file

Create a `.qml` file in `~/.config/illogical-impulse/plugins`.
The file name (without `.qml`) is the plugin ID.

### 3) (Optional) Restrict a plugin to panel families

Use `plugins.familyMap` in `config.json`:

```json
{
  "plugins": {
    "familyMap": [
      { "id": "MyPlugin", "families": ["ii"] }
    ]
  }
}
```

Supported families: `"ii"`, `"waffle"`.

### 4) (Optional) Disable specific plugins

```json
{
  "plugins": {
    "disabled": ["MyPlugin"]
  }
}
```

### Notes

- Plugins are loaded dynamically and reloaded when files are added/removed.
- A plugin can define any Quickshell items it needs (for example `PanelWindow`, `Scope`, etc.).
