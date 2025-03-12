plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.smartroombooking.biher"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true // ✅ Enable core library desugaring
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.smartroombooking.biher"
        minSdk = 23
        multiDexEnabled = true // ✅ Fixed syntax
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }



    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    /// flutter flavors
    flavorDimensions += "default"
    productFlavors {
        create("dev") {
            dimension = "default"
            resValue(
                type = "string",
                name = "app_name",
                value = "SmartRoomBookingDev"
            )
            applicationIdSuffix = ".dev"
        }
        create("prod") {
            dimension = "default"
            resValue(
                type = "string",
                name = "app_name",
                value = "SmartRoomBooking"
            )
            applicationIdSuffix = ""

        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.multidex:multidex:2.0.1") // ✅ Ensure multidex is included
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:1.2.2") // ✅ Corrected
}
