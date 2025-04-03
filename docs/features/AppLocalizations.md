# Feature: AppLocalizations

## Description

`AppLocalizations` is a core utility in the application that provides localized strings for different languages. It is generated automatically based on `.arb` files and integrates seamlessly with Flutter's internationalization framework.

## Features

### Dynamic Localization

#### Description
`AppLocalizations` dynamically provides translations for static text in the application. It adapts automatically to the active locale set in the application.

#### How it works:
- Reads translations from `.arb` files located in the project.
- Automatically updates the displayed text when the locale changes.
- Integrates with Flutter's `MaterialApp` for seamless localization.

#### Example Use Case:
- Displaying localized text:
  ```dart
  final loc = AppLocalizations.of(context)!;
  print(loc.hello); // Outputs "Hello" or its translation based on the locale.
  ```

### Support for Multiple Languages

#### Description
`AppLocalizations` supports multiple languages by defining translations in `.arb` files for each locale.

#### How it works:
- Each `.arb` file corresponds to a specific locale (e.g., `app_en.arb` for English, `app_fr.arb` for French).
- The application uses `supportedLocales` to define the list of available languages.

#### Example Use Case:
- Adding support for a new language:
  1. Create a new `.arb` file (e.g., `app_es.arb` for Spanish).
  2. Add translations for all keys.
  3. Update `supportedLocales` in the application.

### Integration with Flutter

#### Description
`AppLocalizations` integrates with Flutter's internationalization framework to provide localized content dynamically.

#### How it works:
- Uses `localizationsDelegates` to load and manage localized resources.
- Works with `MaterialApp` to apply the active locale across the application.

#### Example Use Case:
- Configuring `MaterialApp` for localization:
  ```dart
  MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: Locale('en'), // Set the default locale
    home: HomeScreen(),
  );
  ```

## Usage

### `l10n.yaml` Configuration

#### Description
The `l10n.yaml` file is a configuration file used by Flutter's localization tool to define settings for generating localization files.

#### Example File:
```yaml
arb-dir: lib/assets/lang
template-arb-file: app_en.arb

output-dir: lib/app_tools/generated
output-localization-file: app_localizations.dart
output-class: AppLocalizations

untranslated-messages-file: lib/assets/lang/untranslated-messages.json

synthetic-package: false
```

#### Key Fields:
- `arb-dir`: Specifies the directory where `.arb` files are stored.
- `template-arb-file`: Defines the base `.arb` file used as a template for other locales.
- `output-dir`: Specifies the directory where the generated localization Dart files will be stored.
- `output-localization-file`: Specifies the name of the generated Dart file containing the localization logic.
- `output-class`: Defines the name of the generated localization class.
- `untranslated-messages-file`: Specifies where untranslated messages will be logged during generation.

### Generating Localization Files

#### Command
To generate the localization files, run the following command in the terminal:
```bash
flutter gen-l10n
```

#### What Happens:
- The tool reads the `l10n.yaml` file for configuration.
- It processes all `.arb` files in the specified directory.
- It generates the localization Dart files in the directory specified by `output-localization-file`.

### Importing Localization Files

#### Description
The generated localization files are imported into the project through a wrapper file for easier access.

#### Example:
The wrapper file `app_tools/app_localizations.dart` imports the generated localization files:
```dart
// This uses a generated file. Do not edit.
export '/app_tools/generated/app_localizations.dart';
```

This allows you to use `AppLocalizations` throughout the project without directly referencing the generated files.

### `untranslated-messages.json`

#### Description
The `untranslated-messages.json` file is generated during the localization process and contains a list of messages that are missing translations in one or more `.arb` files.

#### Location:
```
lib/assets/lang/untranslated-messages.json
```

#### Example File:
```json
// app_en.arb
{
	"@@locale": "en",
	"hello": "Hello",
	"welcome": "Welcome to our app!"
}
```

```json
// app_fr.arb
{
	"@@locale": "fr",
	"hello": "Bonjour"
}
```

output :

```json
// untranslated-messages.json
{
  "fr": [
    "welcome"
  ]
}
```

#### Purpose:
- Helps developers identify untranslated keys.
- Ensures all supported locales have complete translations.

#### How to Use:
1. Review the file after running `flutter gen-l10n`.
2. Add the missing translations to the appropriate `.arb` files.
3. Regenerate the localization files using `flutter gen-l10n`.