//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Leonardo Benavides on 5/9/23.
//

import Foundation

struct ResponseDataModel: Codable {
    let name: String
    let weather: [WeatherDataModel]
    let main: TemperaturesDataModel
    let sys: SunModel
    let timezone: Double
}

struct WeatherDataModel: Codable {
    let main: String
    let description: String
    let icon: String
}

struct SunModel: Codable {
    
    let country: String
    let sunrise: Int
    let sunset: Int
    
    func sunriseTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: sunriseDate())
    }
    
    func sunsetTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: sunsetDate())
    }
    
    func sunriseDate() -> Date {
        return Date(timeIntervalSince1970: Double(sunrise))
    }
    
    func sunsetDate() -> Date {
        return Date(timeIntervalSince1970: Double(sunset))
    }
    
}

struct TemperaturesDataModel: Codable {
    let temp: CGFloat
    let feels_like: CGFloat
    let temp_min: CGFloat
    let temp_max: CGFloat
    let humidity: CGFloat
}
