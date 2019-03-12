# EZSky2
## A simple weather app (MVVM version)

* This new version of EZSky simple weather app is written in Swift 4.2. 
* It is built with MVVM (Model, View, ViewModel) architecture and includes Unit Tests.

### Functionality
* The app uses Core Location to get the geographical coordinates of the user's device. 
* Then it fetches the local weather data from OpenWeatherMap API. 
* It parses the JSON response to get the current weather information and also a 7-day forecast. 
* ViewModels are initialized from the Weather and Forecast data models. 
* And then the views update upon didSet of their ViewModel properties.



