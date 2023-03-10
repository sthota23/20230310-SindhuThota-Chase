//
//  Hourly.swift
//  SindhuWeatherTask
//
//  Created by Sindhu Thota on 09/03/23.
//

import Foundation
struct Hourly : Codable {
	let dt : Int?
	let temp : Double?
	let feels_like : Double?
	let pressure : Int?
	let humidity : Int?
	let dew_point : Double?
	let uvi : Double?
	let clouds : Int?
	let visibility : Int?
	let wind_speed : Double?
	let wind_deg : Int?
	let wind_gust : Double?
	let weather : [Weather]?
	let pop : Double?
}
