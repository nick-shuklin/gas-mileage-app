# ⛽ Gas Mileage App

**Gas Mileage App** is an iOS application designed to simplify tracking and analyzing your vehicle’s fuel efficiency and expenses. It allows users to log fill-up data, calculates gas mileage, and visualizes monthly and yearly expenses with intuitive charts. Supporting both English and Russian locales, the app provides an accessible experience for international users.

![Platform](https://img.shields.io/badge/platform-iOS-blue)
![Swift](https://img.shields.io/badge/Swift-5.7-orange)
![Xcode](https://img.shields.io/badge/Xcode-15+-blue)
![iOS](https://img.shields.io/badge/iOS-17+-brightgreen)

## 📝 Features

- **Easy Data Entry**: Add fill-up details like odometer reading, volume, and price per gallon.
- **Mileage Calculation**: Automatically computes gas mileage based on user input.
- **Data Visualization**: Chart displays monthly/yearly gas expenses and average gas mileage.
- **Localization**: Full support for English and Russian languages.
- **Modern UI**: Built with SwiftUI for a seamless and fluid user experience.

## 🛠 Technologies Used

- **Languages**: Swift
- **Frameworks**: SwiftUI, SwiftData
- **Testing**: XCUITest with custom assert methods and robot pattern
- **Architecture**: MV (Model-View) using Apple’s SwiftData approach

## 🔍 Architecture

The app is structured using Apple’s recommended **MV architecture** for SwiftData, which ensures data flow is intuitive and easily maintainable. **SwiftUI** powers the interface, with views that adapt fluidly to user data and locale settings.

## 🧪 Testing

The **Gas Mileage App** employs a robust testing strategy:

- **XCUITest** for UI tests
- **Robot Pattern Architecture**: Cleanly organizes test logic and interaction steps
- **Custom Assertions**: Validates both functional and localization aspects, tailored for iOS UI testing
- **Multi-locale Testing**: Current suite includes 7 comprehensive tests across 2 locales (English and Russian)
- **Runtime**: Full test suite executes in approximately 3m 30s on a single simulator

## 🚀 Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/GasMileageApp.git
   ```
2. **Open in Xcode**:
   - Open the project in Xcode 15 or higher.
3. **Build & Run**:
   - Build the app using Xcode’s build option or press `Cmd + R`.
4. **Run Tests**:
   - Use the Test Navigator or press `Cmd + U` to execute the test suite.

## 📊 Screenshots / Demo

*(Add any screenshots or GIFs of the app and charts here to showcase UI and functionality)*

## 🤝 Contributions & Feedback

Contributions are welcome! For feedback, suggestions, or issues, please open an issue on the GitHub repository.