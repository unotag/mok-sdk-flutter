# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# Keep all classes in the 'com.unotag.mokone' namespace
-keep class com.unotag.mokone.** { *; }

# Keep public methods in 'com.unotag.mokone' namespace
-keepclassmembers class com.unotag.mokone.** {
    public <methods>;
}

# Keep enums in 'com.unotag.mokone' namespace
-keepclassmembers enum com.unotag.mokone.** { *; }

# Keep resource files (if applicable)
#-keepresources res/drawablee/your_sdk_icon.png

# Keep serialization/deserialization methods (if applicable)
-keepclassmembers class com.unotag.mokone.** {
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep any third-party dependencies used by 'com.unotag.mokone'
-keep class your.thirdparty.library.** { *; }
