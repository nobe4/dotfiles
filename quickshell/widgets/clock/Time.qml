pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string time: {
        Qt.formatDateTime(clock.date, "yy-MM-dd hh:mm");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
