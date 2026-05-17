# Third-Party Notices

WGRALGO Financial Calculators is licensed under **GPL-3.0-only**. The third-party
components listed below remain under their own respective licenses. Their inclusion
does not change the license of this project, and this project's GPLv3 license does
not override the licenses of these components.

The app ships **no external/CDN assets**. All code that runs in the app is bundled
locally in the APK. The date pickers use the browser's native `<input type="date">`
(no third-party date-picker library).

## Runtime dependencies (bundled in the APK)

### Capacitor (`@capacitor/core`, `@capacitor/android`, `@capacitor/cli`) — v6.2.1
- Project: https://github.com/ionic-team/capacitor
- License: MIT
- Notice: Copyright (c) Drifty Co. Permission is hereby granted, free of charge,
  to any person obtaining a copy of this software, under the terms of the MIT License.

### @capacitor/splash-screen — v6.0.4
- Project: https://github.com/ionic-team/capacitor-plugins
- License: MIT
- Notice: Copyright (c) Drifty Co., MIT License.

### AndroidX libraries
- androidx.appcompat:appcompat 1.6.1
- androidx.coordinatorlayout:coordinatorlayout 1.2.0
- androidx.core:core 1.12.0
- androidx.core:core-splashscreen 1.0.1
- androidx.activity:activity 1.8.0
- androidx.fragment:fragment 1.6.2
- androidx.webkit:webkit 1.9.0
- Project: https://developer.android.com/jetpack/androidx
- License: Apache License 2.0
- Notice: Copyright (c) The Android Open Source Project. Licensed under the
  Apache License, Version 2.0 (http://www.apache.org/licenses/LICENSE-2.0).
  AndroidX components are written in Java and Kotlin and pull in the Kotlin
  standard library (`org.jetbrains.kotlin:kotlin-stdlib`), Apache License 2.0,
  https://github.com/JetBrains/kotlin.

### Apache Cordova Android (compatibility layer via Capacitor) — 10.1.1
- Project: https://github.com/apache/cordova-android
- License: Apache License 2.0
- Notice: Copyright (c) Apache Software Foundation, Apache License 2.0.

## Build / development-only dependencies (NOT shipped in the APK)

### @capacitor/assets — v3.0.5
- Project: https://github.com/ionic-team/capacitor-assets
- License: MIT
- Used only to generate launcher icons and splash screens at build time.

### Test dependencies (not in release APK)
- junit:junit 4.13.2 — Eclipse Public License 1.0
- androidx.test.ext:junit 1.1.5 — Apache License 2.0
- androidx.test.espresso:espresso-core 3.5.1 — Apache License 2.0

## Removed dependencies

- **Flatpickr** — previously loaded from `cdn.jsdelivr.net`. Removed for the
  v1.0.0 public release and replaced with the native HTML date input. No
  Flatpickr code is present or bundled.

---

Full Apache License 2.0 text: https://www.apache.org/licenses/LICENSE-2.0
Full MIT License text: https://opensource.org/license/mit
