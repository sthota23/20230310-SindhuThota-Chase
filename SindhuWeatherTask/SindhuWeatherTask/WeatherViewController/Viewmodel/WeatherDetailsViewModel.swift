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
    
    init(apimanager: APIManager) {
        self.apiManager = apimanager
        super.init()
    }

    func getWeatherResults(completion: @escaping ( _ status: Bool, _ error: String?) -> ()) {
        if let latitude = coordinate?.lat, let longitude = coordinate?.lon, let country = sysData?.country, country == "US" {
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
            completion(false, "Please enter US country city names only")
        }
    }
    
    func getCityWeatherDetails(cityName: String, completion: @escaping ( _ status: Bool, _ error: String?) -> ()) {
        apiManager.getWeatherCityDetails(cityName: cityName) { result in
            switch result {
            case .success(let responseModel):
                self.updateCoordinateLocation(location: responseModel.coord)
                self.updateSysLocation(sysLocation: responseModel.sys)
                completion(true, nil)
            case .failure(let failure):
                completion(false, failure.errorMessage())
            }
        }
    }
    
    func updateCoordinateLocation(location: Coord?) {
        self.coordinate = location
    }
    
    func updateSysLocation(sysLocation: Sys?) {
        self.sysData = sysLocation
    }

}
