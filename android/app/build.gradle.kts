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

    /// 🔹 FLAVOR CONFIGURATION (FIXED)
    flavorDimensions.add("env")

    productFlavors {
        create("dev") {
            dimension = "env"
            versionNameSuffix = "-dev"
        }
        create("prod") {
            dimension = "env"
        }
    }

    sourceSets {
        getByName("dev") {
            res.srcDirs("src/dev/res")
        }
        getByName("prod") {
            res.srcDirs("src/prod/res")
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
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
