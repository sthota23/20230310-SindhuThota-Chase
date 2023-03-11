//
//  UserDefaults+Extension.swift
//  SindhuWeatherTask
//
//  Created by Sindhu Thota on 09/03/23.
//

import Foundation
extension UserDefaults {

    static let savedCityName: String = "SavedCityName"
    
    static func saveUserLocation(cityName: String) {
        UserDefaults.standard.setValue(cityName, forKey: savedCityName)
    }
    
    static func getUserLocation() -> String {
        return UserDefaults.standard.value(forKey: savedCityName) as? String ?? ""
    }
    
}
