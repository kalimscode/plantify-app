# Keep model classes for JSON serialization
-keep class com.example.plantify.** { *; }
-keepclassmembers class com.example.plantify.** { *; }

# Keep OkHttp (used by Dio under the hood)
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**

# Keep Retrofit
-keep class retrofit2.** { *; }
-dontwarn retrofit2.**

# Keep method signatures and annotations (needed for serialization)
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses

# Keep SharedPreferences and TokenStorage
-keep class com.example.plantify.**TokenStorage* { *; }

# Keep Dio internals
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Keep Flutter plugins (auth, shared_prefs, image_picker)
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.plugins.**

# Keep SharedPreferences plugin
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# Prevent stripping of Kotlin coroutines (used by Riverpod/async code)
-keepclassmembernames class kotlinx.** { volatile <fields>; }
-dontwarn kotlinx.coroutines.**

# Keep Kotlin metadata
-keep class kotlin.Metadata { *; }
-dontwarn kotlin.**