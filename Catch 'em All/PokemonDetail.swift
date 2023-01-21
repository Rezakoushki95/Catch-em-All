//
//  PokemonDetail.swift
//  Catch 'em All
//
//  Created by Reza Koushki on 21/01/2023.
//

import Foundation

class PokemonDetail {
	
	private struct Returned: Codable {
		var height: Double
		var weight: Double
		var sprites: Sprites
	}
	
	private struct Sprites: Codable {
		var front_default: String
	}
	
	var height = 0.0
	var weight = 0.0
	var imageURL = ""
	var urlString = ""
	
	func getData(completed: @escaping ()->()) {
		print("We are accessing the url \(urlString)")
		
		// Create a URL
		guard let url = URL(string: urlString) else {
			print("ERROR: Could not create URL from \(urlString)")
			return
		}
		
		// Create a Session
		let session = URLSession.shared
		
		// get data with .dataTask method
		let task = session.dataTask(with: url) { (data, response, error) in
			if let error = error {
				print("ERROR: \(error.localizedDescription)")
			}
			do {
				let returned = try JSONDecoder().decode(Returned.self, from: data!)
				print("Here is what I've returned: \(returned)")
				self.height = returned.height
				self.weight = returned.weight
				self.imageURL = returned.sprites.front_default
			} catch {
				print("JSON ERROR: Thrown when we tried to decode from Returned.self with data")
			}
			completed()
		}
		task.resume()
	}

}
