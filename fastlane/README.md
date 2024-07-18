fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios beta_noffice_app

```sh
[bundle exec] fastlane ios beta_noffice_app
```

Build and upload the main Notitime app to TestFlight

### ios development

```sh
[bundle exec] fastlane ios development
```

Fetch development certificates and profiles, and build the app for development

### ios appstore

```sh
[bundle exec] fastlane ios appstore
```

Fetch app store certificates and profiles, and build the app for distribution

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
