<h1 align="center">Persona Quickshell</h1>

<div align="center">

[![QML](https://img.shields.io/badge/QML-Quickshell-7aa2f7?style=for-the-badge&logo=qt&logoColor=white)](https://quickshell.outfoxxed.me)
[![Stars](https://img.shields.io/github/stars/Yujonpradhananga/Persona-Quickshell-?style=for-the-badge&color=e0af68&logoColor=white)](https://github.com/Yujonpradhananga/Persona-Quickshell-/stargazers)
[![KDE Plasma](https://img.shields.io/badge/KDE_Plasma-Wayland-2ac3de?style=for-the-badge&logo=kde&logoColor=white)](https://kde.org/plasma-desktop)
[![Last Commit](https://img.shields.io/github/last-commit/Yujonpradhananga/Persona-Quickshell-?style=for-the-badge&color=9ece6a&logoColor=white)](https://github.com/Yujonpradhananga/Persona-Quickshell-/commits/main)

</div>



<https://github.com/user-attachments/assets/7e6fd291-dd28-48fa-83aa-81556558b132>







---

## Dependencies

- [Quickshell](https://quickshell.outfoxxed.me) (tested with 0.3.1) running on **KDE Plasma (Wayland)**
- `qdbus6` (power menu), `busctl` (launcher screen detection), `nmcli` (network list in Stats)

### Fonts

Font names live in `Data/Fonts.qml`, change them there:

| Role | Font |
|------|------|
| Titles and big labels | FOT-Skip Std |
| Body text and numbers | FOT-NewRodin Pro (DB / B) |
| Battery icons | Any Nerd Font (default: FantasqueSansM Nerd Font) |
| Media controls | Material Symbols Rounded |

### Optional: animated wallpaper

`Widgets/WallpaperEngine.qml` is not loaded by `shell.qml`. It needs this custom cava plugin:
<https://github.com/Yujonpradhananga/Qt6-Cava-plugin>
If you don't want the plugin, delete `CavaVisualizer.qml` and the `CavaVisualizer { ... }` block in `WallpaperEngine.qml`.

---

## AppLauncher

The launcher is toggled over IPC and opens on the screen KWin reports as active.
Bind it in **System Settings → Keyboard → Shortcuts → Add New → Command or Script**:

```sh
qs ipc call searchapp toggle
```

(Add `-c <config name>` or `-p <path>` if this isn't your default Quickshell config.)

---

## Power Menu

Shutdown, restart and logout open KDE's own confirmation screen (`org.kde.LogoutPrompt`).
To act immediately without confirmation, change the commands in `Layers/P3rpause.qml` to
`org.kde.Shutdown` (`logoutAndShutdown`, `logoutAndReboot`, `logout`).

---

## Credits
The wallpaper is from : https://steamcommunity.com/sharedfiles/filedetails/?id=3151551777

The greyscale shader is from [@snes19xx](https://github.com/snes19xx)'s [surface-dots](https://github.com/snes19xx/surface-dots/blob/main/.config/hypr/shaders/reading_mode.glsl).

The media player's album art implementation is taken from [Rexcrazy804](https://github.com/Rexcrazy804)'s [Zaphkiel](https://github.com/Rexcrazy804/Zaphkiel).

Shoutout to [blairxu13](https://github.com/blairxu13)'s [persona3-website](https://github.com/blairxu13/persona3-website).

---

## License

MIT License - feel free to use and modify as needed.

Created by Yujon Pradhananga
