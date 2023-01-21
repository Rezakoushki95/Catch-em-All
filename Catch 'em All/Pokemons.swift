//
//  Pokemons.swift
//  Catch 'em All
//
//  Created by Reza Koushki on 12/01/2023.
//

import Foundation

class Pokemons {
	
	private struct Returned: Codable {
		var count: Int
		var next: String?
		var results: [Pokemon]
	}
	
	var count = 0
	var urlString = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20"
	var pokemonArray: [Pokemon] = []
	
	func getData(completed: @escaping ()->()) {
		print("We are accessing the url \(urlString)")
		
		// Create a URL
		guard let url = URL(string: urlString) else {
			print("ERROR: Couln't get create a URL from \(urlString)")
			return
		}
		
		// Create a URLSession
		let session = URLSession.shared
		
		// Get the data with .dataTask method
		let task = session.dataTask(with: url) { data, response, error in
			if let error = error {
				print("ERROR: \(error.localizedDescription)")
			}
			do {
				let returned = try JSONDecoder().decode(Returned.self, from: data!)
				print("Here is what was returned \(returned)")
				self.pokemonArray.append(contentsOf: returned.results)
				self.urlString = returned.next ?? ""
				self.count = returned.count
				 
			} catch {
				print("JSON ERROR: Thrown when we tried to decode from Returned.self with data")
			}
			completed()
		}
		task.resume()
	}
}
