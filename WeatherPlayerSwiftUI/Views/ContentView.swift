// ContentView.swift by Gokhan Mutlu on 26.10.2024

import SwiftUI
import AVKit
//import AVFoundation
	

struct ContentView: View {
	@ObservedObject var vm = ContentModelView()
	@State private var weatherSelected:WeatherType = .sun
	
	var body: some View {
		VStack {
			
			VStack {
				Picker("Weather", selection: $weatherSelected) {
					ForEach(WeatherType.allCases) { weather in
						//Image(systemName: weather.getSFSymbol())
						Text(weather.rawValue.capitalized)
							.tag(weather)
					}
				}
				.pickerStyle(.segmented)
			}
			.padding()
			
			
			VideoPlayer(player: vm.avPlayer)
				.ignoresSafeArea(.all)
				.frame(height: 240)
				//.scaleEffect(1.1)
				.blur(radius: vm.isPlaying ? 0 : 5)
			
			VStack {
				Button {
					vm.playerPlayOrPause()
				} label: {
					Image(systemName: vm.isPlaying ? "stop" : "play")
						.padding()
						.foregroundStyle(.tint)
						.imageScale(.large)
				}
			.buttonStyle(.bordered)
			}
			.padding()

			
			Spacer()
		}
		.onDisappear(){
			vm.playerPause()
		}
		/*.onReceive(NotificationCenter.default.publisher(for: Notification.Name.AVPlayerItemDidPlayToEndTime),
				   perform: { _ in
		})*/
		.onChange(of: weatherSelected) {
			vm.weatherchanged(weather: weatherSelected.rawValue)
			//vm.isPlaying = true
		}
		
	}
	
	
}

#Preview {
	ContentView()
}
