// QsMenuAnchor needs QApplication mode for system tray menus.
//@ pragma UseQApplication

import Quickshell
import "./widgets/notifications/"

ShellRoot {
    Bar {}
    Notifications {}
}
