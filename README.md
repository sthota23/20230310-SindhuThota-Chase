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

On App launch, app will ask for the user location access.  If user grants the access it will show the weather forecast based current user location
If user does not grant the location access, then it will show launch page. 
there will be a search bar where user can enter city name and once the user enters city name app will show that city weather forecast. 

Upon relaunch app will show the previously searched city name by default along with that city forecast. If user enters the wrong city name it will show the error alert. 

if user enters city outside of USA, APP will  show the alert saying " Weather data only work for US Region" 






2. Run the tests using Xcode
    - Open SindhuWeatherTask.xcodeproj 
    - Select an iPhone 14 Prod simulator and build and run the project (Menu Product > Run or `⌘ + R`)
    - Run the unit tests (Menu Product > Test or `⌘ + U`)

  Unit tests will be executed as part of the test step

