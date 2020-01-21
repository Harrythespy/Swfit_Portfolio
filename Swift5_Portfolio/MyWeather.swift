//
//  MyWeather.swift
//  Swift5_Portfolio
//
//  Created by Harry Shen on 21/1/20.
//  Copyright © 2020 Harry Shen. All rights reserved.
//

import Foundation

struct MyWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
//    let rain: Rain
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Sys: Codable {
    let type: Int
    let id: Int
//    let message: Double
    let country: String
    let sunrise: Int
    let sunset: Int
}

struct Clouds: Codable {
    let all: Int
}

//struct Rain: Codable {
//    let 3h: Double
//}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

struct Main: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
//    let sea_level: Double
//    let grnd_level: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}
