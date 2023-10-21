# Initializing App

This README provides step-by-step instructions on how to clone Inkflow AI repository, set up Flutter on Windows, enable Developer Mode on your Android phone, and finally, run the Flutter app on your Android device.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Clone the Git Repository](#clone-the-git-repository)
3. [Install Flutter on Windows](#install-flutter-on-windows)
4. [Enable Developer Mode on Android](#enable-developer-mode-on-android)
5. [Run the Flutter App](#run-the-flutter-app)

## Prerequisites

Before you begin, ensure you have the following prerequisites in place:

- A Windows computer.
- An Android smartphone.
<!-- - A reliable internet connection. -->

## Clone the Git Repository

1. Open a command prompt or terminal window on your Windows computer.

2. Navigate to the directory where you want to clone the Git repository using the `cd` command:

   ```
   cd /path/to/your/desired/directory
   ```

3. Clone the Git repository using the following command:
 
    ```
    git clone https://github.com/Brian586/inkflowai.git
    ```

4. Change your working directory to the newly cloned repository:

    ```
    cd inkflowai
    ```

## Install Flutter on Windows
1. Download the Flutter SDK for Windows from the official Flutter website: [Flutter SDK](https://docs.flutter.dev/get-started/install/windows).

2. Extract the downloaded archive to a location on your computer. For example, you can extract it to `C:\flutter`.

3. Add the Flutter `bin` directory to your system's PATH environment variable. To do this:

    - Right-click on the `Start` button and select `System`.
    - Click on `Advanced system settings` on the left.
    - Under the `System Properties` window, click the `Environment Variables` button.
    - In the `System Variables` section, scroll down and find the `Path` variable, then click `Edit`
    - Click `New` and add the path to the bin directory inside the Flutter SDK (e.g., `C:\flutter\bin`).
    - Click `OK` to close the windows.
4. Open a new command prompt or terminal window to verify that Flutter has been properly installed by running:

    ```
    flutter doctor
    ```
Follow any prompts to complete the Flutter installation setup.

## Enable Developer Mode on Android
Before you can run Flutter apps on your Android device, you need to enable Developer Mode on the device:

1. Open the `Settings` app on your Android device.

2. Scroll down and select `About phone` or `About device`.

3. Find the `Build number` entry and tap it repeatedly (usually `7` times) until you see a message that says you are now a developer.

4. Go back to the main `Settings` screen, and you should now see a new option called `Developer options` or `System` with developer-related settings.

5. Open `Developer options` and enable the `USB debugging` option.

## Run the Flutter App
1. Connect your Android phone to your Windows computer using a USB cable.

2. In the terminal or command prompt, navigate to your Flutter app's directory (the one you cloned earlier).

3. Run the following command to ensure all the dependencies are installed:

    ```
    flutter pub get
    ```

4. Once the dependencies are successfully installed, run your Flutter app on the connected Android device using:

    ```
    flutter run
    ```

This command will build and deploy the app to your Android device. You should see your Flutter app running on your Android phone.
