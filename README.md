# 20230310-SindhuThota-Chase
Mobile app to show the weather forecast by city name of USA

## Requirements
You will need to have the following tools in place before working on this application:

1. [Xcode](./.xcode-version)

## Setting it up

1. Clone the repository
  - `$ git clone https://github.com/sthota23/20230310-SindhuThota-Chase.git`
  - `$ cd 20230310-SindhuThota-Chase/SindhuWeatherTask/`
  - `$ open SindhuWeatherTask.xcodeproj 

## How the app works 

Use Case 1: Upon launching the app, the user will be prompted to grant access to their location. If the user grants access, the app will display the weather forecast based on the user's current location. If the user denies access to their location, the launch page will be displayed.

<img src="https://user-images.githubusercontent.com/127543478/224514620-cf22e25a-cfeb-4363-af79-88270b1041d4.jpeg" width="393" height="852">

If user deny access.

<img src="https://user-images.githubusercontent.com/127543478/224514781-19cf5f1f-1fb6-42f6-b361-3734f8affe97.png" width="393" height="852">



Use Case 2: The launch page will feature a search bar where the user can enter the name of a city. After entering the city name, the app will display the weather forecast for that city.

<img src="https://user-images.githubusercontent.com/127543478/224514741-3d641aac-0286-408f-9804-ac3995fcf515.png" width="393" height="852">


Use Case 3: Upon relaunching the app, the previously searched city name and its forecast will be displayed by default. If the user enters an incorrect city name, an error alert will be displayed.



<img src="https://user-images.githubusercontent.com/127543478/224514741-3d641aac-0286-408f-9804-ac3995fcf515.png" width="393" height="852">

Error:



Use Case 4: If the user enters a city outside of the USA, the app will display an alert stating that weather data is only available for the US region.


<img src="https://user-images.githubusercontent.com/127543478/224514877-3bcf8b40-3d68-477c-9beb-592ebbb85d25.png" width="393" height="852">



## Architecture( Design Pattern) 

To build this application, I used MVVM Design pattern. 


2. Run the tests using Xcode
    - Open SindhuWeatherTask.xcodeproj 
    - Select an iPhone 14 Prod simulator and build and run the project (Menu Product > Run or `⌘ + R`)
    - Run the unit tests (Menu Product > Test or `⌘ + U`)

  Unit tests will be executed as part of the test step

