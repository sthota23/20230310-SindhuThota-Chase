//
//  APIManager.swift
//  SindhuWeatherTask
//
//  Created by Sindhu Thota on 09/03/23.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    init() {}
    /**
     This method is to fetch the search results from server using search string
     - Parameter searchString: value to search
     */
    func getWeatherDetails(lat: Double, long: Double, completionHandler: @escaping (Result<WeatherReport, APIServiceError>) -> Void) {
        
        let weatherUrlString = WebServiceUrlEndpoint.getWeatherApi(lat: lat, long: long).url()
        let urlString = weatherUrlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)

        guard let weatherUrl = URL(string: urlString ?? "") else {
            completionHandler(.failure(.apiError(errorMessage: "Network Error")))
            return
        }
        WebServices.shared.getRequestDetails(url: weatherUrl) { (result: Result<WeatherReport, APIServiceError>) in
                return completionHandler(result)
        }
    }
    
    func getWeatherCityDetails(cityName: String, completionHandler: @escaping (Result<WeatherCityData, APIServiceError>) -> Void) {
        
        let weatherUrlString = WebServiceUrlEndpoint.getSearchDataApi(cityName: cityName).url()
        let urlString = weatherUrlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)

        guard let weatherUrl = URL(string: urlString ?? "") else {
            completionHandler(.failure(.apiError(errorMessage: "Network Error")))
            return
        }
        WebServices.shared.getRequestDetails(url: weatherUrl) { (result: Result<WeatherCityData, APIServiceError>) in
                return completionHandler(result)
        }
    }

}
