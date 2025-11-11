import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

val localProps = Properties().apply {
    val f = rootProject.file("local.properties")
    if (f.exists()) load(f.inputStream())
}

val flutterVersionCode = localProps.getProperty("flutter.versionCode") ?: "1"
val flutterVersionName = localProps.getProperty("flutter.versionName") ?: "1"

val keystoreProps = Properties().apply {
    val f = rootProject.file("key.properties")
    if (f.exists()) load(f.inputStream())
}

android {
    namespace = "vn.tuoitre.app"
    compileSdk = 34

    defaultConfig {
        applicationId = "vn.tuoitre.app"
        minSdk = maxOf(21, flutter.minSdkVersion)
        targetSdk = 35
        versionCode = flutterVersionCode.toInt()
        versionName = flutterVersionName
        multiDexEnabled = true
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    signingConfigs {
        create("release") {
            if (keystoreProps.isNotEmpty()) {
                storeFile = file(keystoreProps["storeFile"]!!)
                storePassword = keystoreProps["storePassword"] as String?
                keyAlias = keystoreProps["keyAlias"] as String?
                keyPassword = keystoreProps["keyPassword"] as String?
            }
        }
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            signingConfig = signingConfigs.getByName("release")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    lint {
        disable.add("InvalidPackage")
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.android.gms:play-services-ads:22.6.0")
    implementation(platform("com.google.firebase:firebase-bom:29.1.0"))
    implementation("com.google.firebase:firebase-analytics-ktx")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version")
    implementation("com.google.firebase:firebase-messaging-ktx:23.0.5")
    implementation("androidx.multidex:multidex:2.0.1")
    implementation("com.netcore.android:smartech-sdk:3.5.1")

    api("com.netcore.android:smartech-sdk:${SMARTECH_BASE_SDK_VERSION}")
    api("com.netcore.android:smartech-push:${SMARTECH_PUSH_SDK_VERSION}")

    testImplementation("junit:junit:4.12")
    androidTestImplementation("androidx.test:runner:1.5.2")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
}

configurations.all {
    resolutionStrategy {
        force("com.google.android.gms:play-services-ads:22.6.0")
        force("com.google.android.gms:play-services-measurement-base:20.1.2")
        force("com.google.android.gms:play-services-measurement-impl:20.1.2")
        force("com.google.android.gms:play-services-measurement:20.1.2")
    }
}
