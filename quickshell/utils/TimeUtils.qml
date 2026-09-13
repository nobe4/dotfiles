pragma Singleton

import Quickshell

Singleton {
    function formatTime(seconds) {
        if (seconds <= 0)
            return "";

        const hours = Math.floor(seconds / 3600);
        const minutes = Math.floor(seconds % 3600 / 60);
        if (hours > 0)
            return hours + "h " + minutes + "m";
        return minutes + "m";
    }
}
