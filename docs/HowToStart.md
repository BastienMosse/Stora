# How to Run the Flutter App

This guide explains how to launch the Flutter application locally, use an emulator or physical device, and reduce unnecessary logs in the debug console.

---

## Checklist

Before running the app, ensure the following tools are installed:

```bash
dart --version		# Chech if dart is installed
flutter --version	# Chech if flutter is installed
flutter doctor		# Check if flutter is ready to run
```

## Install Dependencies

```bash
flutter clean         # Optional: clears old build files
flutter pub get       # Fetches all project dependencies
```

## Launch or Select a Device

### List available devices :

```bash
flutter devices
```

Sample output:

```md
Found 3 connected devices:
  Android SDK built for x86 64 (mobile) • emulator-5554 • android-x64    • Android 15 (API 35) (emulator)
  Linux (desktop)                       • linux         • linux-x64      • Fedora Linux 42 (Workstation Edition) 6.15.3-200.fc42.x86_64
  Chrome (web)                          • chrome        • web-javascript • Google Chrome 138.0.7204.49

Run "flutter emulators" to list and start any available device emulators.

If you expected another device to be detected, please run "flutter doctor" to diagnose potential issues. You may also try increasing the time to wait for connected
devices with the "--device-timeout" flag. Visit https://flutter.dev/setup/ for troubleshooting tips.
```

### List available emulators :

```bash
flutter emulators
```

Sample output:

```md
1 available emulator:

Id   • Name • Manufacturer • Platform

Medium_Phone • Medium_Phone • Generic      • android

To run an emulator, run 'flutter emulators --launch <emulator id>'.
To create a new emulator, run 'flutter emulators --create [--name xyz]'.

You can find more information on managing emulators at the links below:
  https://developer.android.com/studio/run/managing-avds
  https://developer.android.com/studio/command-line/avdmanager
```

Example :
```bash
flutter emulators --launch Medium_Phone
```

## Run the App

### Run on the default or current device :

```bash
flutter run
```

### Run on a specific device :

```bash
flutter run -d <device_id>
```

Examples:

```bash
flutter run -d emulator-5554		# Android emulator
flutter run -d chrome				# Web
flutter run -d windows				# Desktop app Windows
flutter run -d linux 				# Desktop app Linux

```

## Reduce Debug Console Noise

Reduce logs displayed

```bash
flutter run --no-enable-impeller
```

No log mode
(disables hot reload and debug print outputs)

```bash
flutter run --release
```

## Useful Commands

```
Flutter run key commands.
r Hot reload. 🔥🔥🔥
R Hot restart.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).
```

## Project Structure Overview

lib/
├── app/               # AppState and UserPrefs (global state)
├── assets/            # Icons and images used across the UI
├── data/              # API, requests, responses, models
├── l10n/              # Localization files (.arb and generated)
├── presentation/      # All UI screens, views, viewmodels
├── routing/           # App routing and route definitions
├── theme/             # Theme data and controllers
├── global_const.dart  # Global constants
├── index.dart         # Centralized exports
└── main.dart          # App entry point
