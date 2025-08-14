// Time.qml

// with this line our type becomes a Singleton
pragma Singleton

import Quickshell
import QtQuick

// your singletons should always have Singleton as the type
Singleton {
  id: root

  // an expression can be broken across multiple lines using {}
  readonly property string time: {
        Qt.formatDateTime(clock.date, "ddd MMM d hh:mm:ss AP t yyyy")
  }

  SystemClock {
      id: clock
      precision: SystemClock.Seconds
  }
}
