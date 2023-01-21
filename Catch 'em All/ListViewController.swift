//
//  ViewController.swift
//  Catch 'em All
//
//  Created by Reza Koushki on 12/01/2023.
//

import UIKit

class ListViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var pokemons = Pokemons()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		pokemons.getData {
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		print("\(indexPath.row+1) of \(pokemons.pokemonArray.count)")
		let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
		if indexPath.row == pokemons.pokemonArray.count-1 && pokemons.urlString.hasPrefix("http") {
			pokemons.getData {
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
		cell.textLabel?.text = "\(indexPath.row+1). \(pokemons.pokemonArray[indexPath.row].name)"
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pokemons.pokemonArray.count
	}
	
}

