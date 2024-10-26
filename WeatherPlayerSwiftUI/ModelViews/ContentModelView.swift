// ContentModelView.swift by Gokhan Mutlu on 26.10.2024

import SwiftUI
import Combine
import AVKit

class ContentModelView: ObservableObject{
	
	@Published private(set) var avPlayer = AVPlayer()
	@Published var isPlaying = false
	
	private var publisher:NotificationCenter.Publisher =
		NotificationCenter.default.publisher(for: Notification.Name.AVPlayerItemDidPlayToEndTime)
	private var cancelables:Set<AnyCancellable> = []
	
	init() {
		let url = getUrl(foResource: WeatherType.sun.rawValue)!
		self.avPlayer = AVPlayer(url: url)
		
		publisher.sink { notification in
			self.avPlayer.seek(to: CMTime.zero)
			self.avPlayer.pause()
			self.isPlaying = false
		}
		.store(in: &cancelables)
	}
	
	private func getUrl(foResource resource:String, withExtension ext:String = "mp4") -> URL?{
		guard let url = Bundle.main.url(forResource: resource, withExtension: ext) else{ return nil }
		//print(url)
		return url
	}
	
	
}

//MARK: - Player

extension ContentModelView{
	
	func loadVideo(weather:String, andPlay isPlay:Bool = false){
		guard let urlValid = getUrl(foResource: weather) else { return }
		avPlayer = AVPlayer(url: urlValid)
		avPlayer.seek(to: CMTime.zero)
		if isPlay{
			avPlayer.play()
		}
	}
	
	func playerPause(){
		avPlayer.pause()
	}
	
	func playerPlay(){
		avPlayer.play()
	}
	
	func playerPlayOrPause(){
		isPlaying ? playerPause() : playerPlay()
		isPlaying.toggle()
		//avPlayer.seek(to: .zero)
	}
	
	func weatherchanged(weather:String){
		playerPause()
		loadVideo(weather: weather)
		playerPlay()
		isPlaying = true
	}
	
}
