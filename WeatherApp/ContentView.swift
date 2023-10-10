//
//  ContentView.swift
//  WeatherApp
//
//  Created by Leonardo Benavides on 5/9/23.
//



import SwiftUI

struct ContentView: View {
    @ObservedObject private var weatherViewModel = WeatherViewModel()
    @State private var selectedCity = "Cumaná"
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack {
                Text(weatherViewModel.weatherResponse?.name ?? "Texto")
                    .font(.system(size:70))
                Text(weatherViewModel.weatherResponse?.sys.country ?? "")
                Text(weatherViewModel.weatherResponse?.weather[0].description.capitalized ?? "Calor triple hp")
                    .font(.system(size: 20))
                HStack{
                    if let iconUrl = weatherViewModel.weatherResponse?.weather[0].icon,
                       let url = URL(string: "http://openweathermap.org/img/wn/\(iconUrl)@2x.png"){
                        AsyncImage(url: url) { image in
                            image
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    Text("\(String(format: "%.f", weatherViewModel.weatherResponse?.main.temp ?? 0.00))°")
                        .font(.system(size: 60))
                }
                HStack{
                    Label("\(String(format: "%.f",weatherViewModel.weatherResponse?.main.temp_max ?? 0.0))° Max.", systemImage: "thermometer.sun.fill")
                    Label("\(String(format: "%.f",weatherViewModel.weatherResponse?.main.temp_min ?? 0.0))° Min.", systemImage: "thermometer.snowflake")
                }
                .symbolRenderingMode(.multicolor)
                HStack{
                    Label("\(weatherViewModel.weatherResponse?.sys.sunriseTime() ?? "")", systemImage: "sunrise.fill")
                    Label("\(weatherViewModel.weatherResponse?.sys.sunsetTime() ?? "")", systemImage: "sunset.fill")
                }
                .padding()
                .symbolRenderingMode(.multicolor)
                Text("Sensación térmica: \(String(format: "%.f",weatherViewModel.weatherResponse?.main.feels_like ?? 0.0))°")
                Label("\(String(format: "%.f", weatherViewModel.weatherResponse?.main.humidity  ?? 0))%", systemImage: "humidity.fill")
                    .padding(.vertical,10)
                HStack{
                    TextField("Ingresa un valor", text: $selectedCity)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(.white)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .cornerRadius(10)
                    Button(action: {
                        weatherViewModel.getWeather(city: selectedCity.trimmingCharacters(in: .whitespaces).folding(options: .diacriticInsensitive, locale: .current))
                    }) {
                        Text("Buscar")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(40)
                if let error = weatherViewModel.errorResponse {
                    Text(error)
                        .font(.system(size: 20))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.white)
        .background(
            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .onAppear {
            weatherViewModel.getWeather(city: selectedCity.trimmingCharacters(in: .whitespaces).folding(options: .diacriticInsensitive, locale: .current))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
