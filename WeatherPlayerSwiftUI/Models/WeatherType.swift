// WeatherType.swift by Gokhan Mutlu on 26.10.2024

import Foundation

enum WeatherType: String, CaseIterable{
	case rain, snow, sun
	
	func getSFSymbol() -> String{
		switch(self){
			case .rain: return "cloud.rain"
			case .snow: return "cloud.snow"
			case .sun: return "sun.min.fill"
		}
	}
}

extension WeatherType: Identifiable{
	var id: Self{ self }
}
