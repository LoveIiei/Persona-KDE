pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root

    // Persona fonts from ~/.local/share/fonts
    // Titles and big labels (single bold weight)
    readonly property string display: "FOT-Skip Std"
    // Body text and numbers (DB weight, B with font.bold)
    readonly property string body: "FOT-NewRodin Pro"
    // Nerd Font glyphs (battery icons)
    readonly property string icons: "FantasqueSansM Nerd Font"
}
