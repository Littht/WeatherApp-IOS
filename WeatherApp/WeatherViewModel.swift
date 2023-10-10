//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Leonardo Benavides on 5/9/23.
//

//https://api.openweathermap.org/data/2.5/weather?q=cumana&appid=50757835a9d0b5c322140cb1faeec6ce&units=metric&lang=es

import Foundation
import Alamofire

final class WeatherViewModel: ObservableObject {
    init (){
        
    }
    @Published var weatherResponse: ResponseDataModel?
    @Published var errorResponse: String = ""
    
    func getWeather(city:String) {
        AF.request("https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=50757835a9d0b5c322140cb1faeec6ce&units=metric&lang=es").responseDecodable(of: ResponseDataModel.self) { response in
            switch response.result {
            case let .success(weather):
                print("Weather Response:", weather)
                self.weatherResponse = weather
                self.errorResponse = ""
            case let .failure(error):
                print(error)
                self.errorResponse = "Ciudad no encontrada"
            }
        }
    }
    
}
