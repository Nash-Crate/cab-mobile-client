import java.util.Properties
import java.io.FileInputStream

//import com.android.build.gradle.internal.api.BaseVariantOutputImpl

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

val localPropsFile = rootProject.file("local.properties")
val localProps = Properties()
if (localPropsFile.exists()) {
    localPropsFile.inputStream().use { localProps.load(it) }
}

val googleMapsApiKey: String? by lazy {
    localProps.getProperty("googleMapsApiKey")
        ?: System.getenv("GOOGLE_MAPS_API_KEY_ENVIRONMENT_VARIABLE_ANDROID")
}
val flutterNdkVersion: String by lazy {
    localProps.getProperty("ndkVersion")
        ?: flutter.ndkVersion
}


android {
    namespace = "com.nashcrate.mobile_client"
    ndkVersion = flutterNdkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.nashcrate.mobile_client"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        compileSdk = flutter.compileSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        manifestPlaceholders["google_maps_api_key"] = googleMapsApiKey ?: ""
    }

    signingConfigs {
        create("release") {
            val env = System.getenv()

            when {
                // Production
                env["ANDROID_KEYSTORE_PATH"] != null -> {
                    storeFile = env["ANDROID_KEYSTORE_PATH"]?.let { file(it) }
                    keyAlias = env["ANDROID_KEYSTORE_ALIAS"]
                    keyPassword = env["ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD"]
                    storePassword = env["ANDROID_KEYSTORE_PASSWORD"]
                }

                // Staging
                env["STG_ANDROID_KEYSTORE_PATH"] != null -> {
                    storeFile =
                        env["STG_ANDROID_KEYSTORE_PATH"]?.let { file(it) }
                    keyAlias = env["STG_ANDROID_KEYSTORE_ALIAS"]
                    keyPassword =
                        env["STG_ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD"]
                    storePassword = env["STG_ANDROID_KEYSTORE_PASSWORD"]
                }

                // Development
                else -> {
                    keyAlias = keystoreProperties["keyAlias"] as String?
                    keyPassword = keystoreProperties["keyPassword"] as String?
                    storeFile =
                        keystoreProperties["storeFile"]?.let { file(it) }
                    storePassword =
                        keystoreProperties["storePassword"] as String?
                }
            }
        }
    }

//    applicationVariants.all {
//        outputs.all {
//            val appName = "mauri_cab"
//            val buildTypeName = buildType.name
//            val newName = if (buildTypeName == "debug") {
//                "app-${flavorName}-debug.apk"
//            } else {
//                "${appName}_${flavorName}_${defaultConfig.versionName}+${defaultConfig.versionCode}.apk"
//            }
//            (this as BaseVariantOutputImpl).outputFileName = newName
//        }
//    }

    buildTypes {
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
        }

        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            proguardFiles += getDefaultProguardFile("proguard-android-optimize.txt")
        }
    }

    flavorDimensions += "default"
    productFlavors {
        create("development") {
            dimension = "default"
            applicationIdSuffix = ".dev"
            resValue(
                type = "string",
                name = "app_name",
                value = "[DEV] MauriCab"
            )
        }
        create("staging") {
            dimension = "default"
            applicationIdSuffix = ".stg"
            resValue(
                type = "string",
                name = "app_name",
                value = "[STG] MauriCab"
            )
        }
        create("production") {
            dimension = "default"
            applicationIdSuffix = ""
            resValue(
                type = "string",
                name = "app_name",
                value = "MauriCab"
            )
        }
    }
}

flutter {
    source = "../.."
}
