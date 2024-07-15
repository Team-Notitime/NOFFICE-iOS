## Make
- **Tuist project creation**
  > Use this instead of ‘tuist generate’. It includes the lint command.
  ```
  $ make generate
  ```
- **Linting**
  ```
  $ make lint
  ```
- **Linting(Autocorrect and fix)**
  ```
  $ make format
  ```
- **Clean**
  > Remove the DerivedData
  ```
  $ make clean
  ```

## Fastlane
> ⚠️ This action requires a `.env` file. Please contact do83430208@gmail.com for assistance.
- **Upload to testflight**
  ```
  $ fastlane beta_noffice_app
  ```
- **Match**
  > This works for the app targets of all bundle IDs defined in the AppFile.
  ```
  $ fastlane development
  ```
  ```
  $ fastlane appstore
  ```
