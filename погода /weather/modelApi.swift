//
//  modelApi.swift
//  weather
//
//  Created by Георгий on 06.02.2022.
//

import Foundation

struct Main : Codable {
    var temp : Double = 0.0
    var temp_min:Double = 0.0
    var temp_max:Double = 0.0
    var pressure : Int = 0
    var humidity: Int = 0
}

struct Wind : Codable {
    var speed : Double = 0.0
    var deg : Int = 0
}

struct WeatherData : Codable {
    var main : Main = Main()
    var wind : Wind = Wind()
    var name : String = ""
}
