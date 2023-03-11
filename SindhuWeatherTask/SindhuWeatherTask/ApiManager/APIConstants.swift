//
//  APIConstants.swift
//  SindhuWeatherTask
//
//  Created by Sindhu Thota on 09/03/23.
//

import Foundation

// MARK: - API Constants
public var app_id = "fae7190d7e6433ec3a45285ffcf55c86"
public var weather_api = "https://api.openweathermap.org/data/2.5/onecall?lat=%f&lon=%f&exclude=&appid=%@&units=metric"
public var image_url = "https://openweathermap.org/img/wn/%@@2x.png"
public var cityNameApi = "https://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@"

// MARK: - WebServiceUrlEndpoint
enum WebServiceUrlEndpoint {
    
    case getWeatherApi(lat: Double, long: Double)
    case getSearchDataApi(cityName: String)
    
    func url() -> String {
        switch self {
        case .getWeatherApi(let lat, let long):
            return  String(format: weather_api, lat, long, app_id)
        case .getSearchDataApi(let cityName):
            return String(format: cityNameApi, cityName, app_id)
        }
    }

}

// MARK: - ImageServiceUrlEndpoint
enum ImageServiceUrlEndpoint {
    
    case getWeatherImage(name: String)
    func url() -> String {
        switch self {
        case .getWeatherImage(let name):
            return  String(format: image_url, name)
        }
    }
    
}
