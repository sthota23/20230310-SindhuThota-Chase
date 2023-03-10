//
//  WeatherReport.swift
//  SindhuWeatherTask
//
//  Created by Sindhu Thota on 09/03/23.
//

import Foundation
struct WeatherReport : Codable {
	let lat : Double?
	let lon : Double?
	let timezone : String?
	let timezone_offset : Int?
	let current : Current?
	let minutely : [Minutely]?
	let hourly : [Hourly]?
	let daily : [Daily]?
}
