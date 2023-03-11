//
//  WeatherDetailsViewModel.swift
//  SindhuWeatherTask
//
//  Created by Sindhu Thota on 09/03/23.
//

import Foundation
class WeatherDetailsViewModel: NSObject {

    var apiManager: APIManager!
    var weatherData: WeatherReport?
    var coordinate: Coord?
    var sysData: Sys?
    var countryCode = NSLocale.current.regionCode
    
    init(apimanager: APIManager) {
        self.apiManager = apimanager
        super.init()
    }

    func getWeatherResults(completion: @escaping ( _ status: Bool, _ error: String?) -> ()) {
        
        if let latitude = coordinate?.lat, let longitude = coordinate?.lon, countryCode == "US" {
            apiManager.getWeatherDetails(lat: latitude, long: longitude) { result in
                switch result {
                case .success(let responseModel):
                    self.weatherData = responseModel
                    completion(true, nil)
                case .failure(let failure):
                    completion(false, failure.errorMessage())
                }
            }
        } else {
            completion(false, "Weather Data will work for only US region")
        }
    }
    
    func getCityWeatherDetails(cityName: String, completion: @escaping ( _ status: Bool, _ error: String?) -> ()) {
        apiManager.getWeatherCityDetails(cityName: cityName) { result in
            switch result {
            case .success(let responseModel):
                self.updateCoordinateLocation(location: responseModel.coord)
                self.updateCountryCode(countryCode: responseModel.sys.country)
                completion(true, nil)
            case .failure(let failure):
                completion(false, failure.errorMessage())
            }
        }
    }
    
    func updateCoordinateLocation(location: Coord?) {
        coordinate = location
    }
    
    func updateCountryCode(countryCode: String) {
        self.countryCode = countryCode
    }

}
