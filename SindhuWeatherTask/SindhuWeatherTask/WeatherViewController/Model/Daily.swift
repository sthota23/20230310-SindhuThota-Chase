//
//  Daily.swift
//  SindhuWeatherTask
//
//  Created by Sindhu Thota on 09/03/23.
//

import Foundation
struct Daily : Codable {
	let dt : Int?
	let sunrise : Int?
	let sunset : Int?
	let moonrise : Int?
	let moonset : Int?
	let moon_phase : Double?
	let temp : Temp?
	let feels_like : Feels_like?
	let pressure : Int?
	let humidity : Int?
	let dew_point : Double?
	let wind_speed : Double?
	let wind_deg : Int?
	let wind_gust : Double?
	let weather : [Weather]?
	let clouds : Int?
	let pop : Double?
	let uvi : Double?
}
