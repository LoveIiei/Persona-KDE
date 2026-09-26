import Quickshell.Wayland
import Quickshell
import "../Data" as Dat
import "../Widgets" as Wid
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Scope {
    id: capsuleScope
    property var mpris: Mpris.players.values[0] || null
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: pmusicWindow
            anchors {
                bottom: true
                left: true
            }
            required property var modelData
            screen: modelData
            color: "transparent"
            implicitWidth: 800
            implicitHeight: 300
            WlrLayershell.layer: WlrLayer.Bottom
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.namespace: "music-player-interactive"
            focusable: false

            Image {
                id: dialogueBox
                source: "../Assets/components/player.png"
                transformOrigin: Item.Center
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -170
                anchors.verticalCenterOffset: -15
                width: 500
                height: 500
                rotation: 10
                fillMode: Image.PreserveAspectFit
            }

            // LCD Display Window Container
            Item {
                id: screenDisplay
                anchors.centerIn: dialogueBox
                anchors.horizontalCenterOffset: 68
                anchors.verticalCenterOffset: 1
                rotation: 10
                width: 216
                height: 48

                // Controls: Anchored to the right side of the screen
                Row {
                    id: controlsRow
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2

                    // Prev Button
                    Item {
                        width: 26
                        height: 26
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            id: prevIcon
                            anchors.centerIn: parent
                            text: "skip_previous"
                            font.family: "Material Symbols Rounded"
                            font.pixelSize: 24
                            color: prevMouse.containsMouse ? Dat.Colors.color3 : Dat.Colors.color15
                            Behavior on color {
                                ColorAnimation {
                                    duration: 150
                                }
                            }
                        }

                        MouseArea {
                            id: prevMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: if (capsuleScope.mpris?.canGoPrevious)
                                capsuleScope.mpris.previous()
                        }
                    }

                    // Spinning Disc
                    Item {
                        width: 46
                        height: 46
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            id: imgDisk
                            anchors.fill: parent
                            anchors.margins: 4
                            fillMode: Image.PreserveAspectCrop
                            source: capsuleScope.mpris ? (capsuleScope.mpris.trackArtUrl || "") : ""
                            smooth: true
                            mipmap: true
                            layer.enabled: true
                            layer.smooth: true
                            layer.effect: MultiEffect {
                                antialiasing: true
                                maskEnabled: true
                                maskSpreadAtMin: 1.0
                                maskThresholdMax: 1.0
                                maskThresholdMin: 0.5
                                maskSource: Image {
                                    layer.smooth: true
                                    mipmap: true
                                    smooth: true
                                    source: "../Assets/components/AlbumCover-by-Squirrel-Modeller.svg"
                                }
                            }
                            Behavior on rotation {
                                NumberAnimation {
                                    duration: diskTimer.interval
                                    easing.type: Easing.Linear
                                }
                            }
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 300
                                    easing.type: Easing.OutCubic
                                }
                            }
                        }

                        MouseArea {
                            id: diskMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: if (capsuleScope.mpris?.canTogglePlaying)
                                capsuleScope.mpris.togglePlaying()
                            onEntered: imgDisk.scale = 0.8
                            onExited: imgDisk.scale = 1.0
                        }

                        Timer {
                            id: diskTimer
                            interval: 500
                            repeat: true
                            running: capsuleScope.mpris !== null && capsuleScope.mpris.playbackState === MprisPlaybackState.Playing
                            onTriggered: imgDisk.rotation += 3
                        }
                    }

                    // Next Button
                    Item {
                        width: 26
                        height: 26
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            id: nextIcon
                            anchors.centerIn: parent
                            text: "skip_next"
                            font.family: "Material Symbols Rounded"
                            font.pixelSize: 24
                            color: nextMouse.containsMouse ? Dat.Colors.color3 : Dat.Colors.color15
                            Behavior on color {
                                ColorAnimation {
                                    duration: 150
                                }
                            }
                        }

                        MouseArea {
                            id: nextMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: if (capsuleScope.mpris?.canGoNext)
                                capsuleScope.mpris.next()
                        }
                    }
                }

                // Track Info: Anchored from left margin to controls
                Column {
                    id: trackInfoCol
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.right: controlsRow.left
                    anchors.rightMargin: 6
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    spacing: 1

                    // Artist Row (collapses when empty so title centers automatically)
                    Item {
                        width: parent.width
                        height: artistMarquee.text !== "" ? (artistMarquee.implicitHeight + 2) : 0
                        visible: artistMarquee.text !== ""

                        Wid.Marquee {
                            id: artistMarquee
                            anchors.bottom: parent.bottom
                            text: capsuleScope.mpris ? (capsuleScope.mpris.trackArtist || "") : ""
                            maxWidth: parent.width
                            font: "FOT-Skip Std"
                            size: 11
                            color: Dat.Colors.color3
                            scrollRate: 50
                            pauseDuration: 2000
                            visible: text !== ""
                        }
                    }

                    // Song Title / "No Media"
                    Item {
                        width: parent.width
                        height: songname.implicitHeight

                        Wid.Marquee {
                            id: songname
                            text: capsuleScope.mpris ? (capsuleScope.mpris.trackTitle || "No title") : "No Media"
                            maxWidth: parent.width
                            font: "FOT-Skip Std"
                            size: 14
                            color: "black"
                            scrollRate: 50
                            pauseDuration: 2000
                        }
                    }
                }
            }
        }
    }
}
