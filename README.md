# QR Scanner App

**QR Code Scanning Application in Flutter**

## Description

This app scans QR codes using the device's camera and displays the scanned content on the screen. Users can **copy** the result to the clipboard or **open** a link if the QR code content is a URL.

## Features

- **QR Code Scanning** using the device’s camera.
- **Scan Line Animation** to guide the user.
- **Copy and Open URL Options** for scanned results.
- **Confirmation Messages** when copying to the clipboard or trying to open a URL.

## Technologies

- **Flutter** for the user interface.
- **Dart** as the programming language.
- **qr_code_scanner** to integrate QR code scanning functionality.
- **url_launcher** to open URLs in the browser or other apps.

## Installation

### Prerequisites

- **Flutter** installed on your machine ([Installation Guide](https://flutter.dev/docs/get-started/install))
- A mobile device or emulator with a functional camera

### Setup Steps

1. Clone this repository:
   ```bash
   git clone https://github.com/your_username/qr_scanner_app.git
   cd qr_scanner_app
2. Install dependencies:
    ```bash
    flutter pub get
3. Run the app:
   ```bash
   flutter run

## Usage
-Open the app to start the camera and position the QR code within the scan frame.
-Once scanned, the result will appear at the bottom.
You can:
-Copy the result to the clipboard.
-Open the URL in your browser (if the QR code is a URL).
## Code Structure
main.dart: Contains the main structure of the application and scanning logic.
QR Controller: Manages the flow of scanned data and action buttons.
Scan Animation: Uses a timer to move a scan line vertically for visual guidance.
Contributions
Contributions are welcome. If you would like to improve functionality or fix bugs, please create a pull request and ensure that you follow the code style and structure.

License
This project is licensed under the MIT License.



