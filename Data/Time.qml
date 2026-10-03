pragma Singleton
import Quickshell
import QtQuick

Singleton {
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    readonly property var now: clock.date

    // Moon phase in degrees (0 = new, 180 = full) for any date; shared by the clock and the calendar
    function moonPhaseDegreeAt(date) {
        const synodicMonth = 29.53059;
        const referenceNewMoon = new Date(Date.UTC(2000, 0, 6, 18, 14));
        const diffDays = (date - referenceNewMoon) / (1000 * 60 * 60 * 24);
        const days = ((diffDays % synodicMonth) + synodicMonth) % synodicMonth;
        const degree = 360 - Math.floor((days / synodicMonth) * 360);
        if (degree >= 355 || degree <= 5)
            return 0;
        if (degree >= 175 && degree <= 185)
            return 180;
        return degree;
    }

    readonly property string time: {
        const h = now.getHours().toString().padStart(2, "0");
        const m = now.getMinutes().toString().padStart(2, "0");
        return h + ":" + m;
    }

    readonly property string date: {
        const months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
        return months[now.getMonth()] + "·" + now.getDate().toString().padStart(2, "0");
    }

    readonly property string weekday: {
        const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
        return days[now.getDay()];
    }

    readonly property string daytime: {
        const h = now.getHours();
        if (h >= 5 && h < 12)
            return "Dawn";
        if (h >= 12 && h < 17)
            return "Noon";
        if (h >= 17 && h < 21)
            return "Dusk";
        return "Dark";
    }

    readonly property real moonPhaseDegree: moonPhaseDegreeAt(now)
}
