# ProGuard rules for WGRALGO Financial Calculators

# Keep Capacitor + plugin bridge classes
-keep class com.getcapacitor.** { *; }
-keep class com.getcapacitor.annotation.** { *; }
-keepattributes *Annotation*
-keep @com.getcapacitor.annotation.CapacitorPlugin class * { *; }
-keepclassmembers class * {
    @com.getcapacitor.PluginMethod *;
}

# Keep classes referenced via reflection in JavaScript bridges
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# AndroidX / WebView safety
-dontwarn org.bouncycastle.**
-dontwarn org.conscrypt.**
-dontwarn org.openjsse.**

# Cordova plugins
-keep class org.apache.cordova.** { *; }

# Keep our app classes
-keep class org.wgralgo.financialcalculators.** { *; }

# Preserve source/line info for crash reports
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile
