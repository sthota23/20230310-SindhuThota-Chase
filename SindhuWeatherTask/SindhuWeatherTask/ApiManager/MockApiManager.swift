//
//  MockAPIManager.swift
//  SindhuWeatherTask
//
//  Created by Sindhu Thota on 09/03/23.
//

import Foundation

class MockAPIManager: APIManager {

    static let sharedManager = MockAPIManager()
    private override init() {
        super.init()
    }

    override func getWeatherDetails(lat: Double, long: Double, completionHandler: @escaping (Result<WeatherReport, APIServiceError>) -> Void) {
        
        if let path = Bundle.main.path(forResource: "WeatherReportMock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let weatherData = try JSONDecoder().decode(WeatherReport.self, from: data)
                completionHandler(.success(weatherData))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }
        
    }
    
    override func getWeatherCityDetails(cityName: String, completionHandler: @escaping (Result<WeatherCityData, APIServiceError>) -> Void) {
        
        if let path = Bundle.main.path(forResource: "WeatherCityMock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let weatherData = try JSONDecoder().decode(WeatherCityData.self, from: data)
                completionHandler(.success(weatherData))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }
    }
    
}
