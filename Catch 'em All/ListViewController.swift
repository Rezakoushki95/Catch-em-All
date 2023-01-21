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
	var activityIndicator = UIActivityIndicatorView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		setUpActivityIndicator()
		activityIndicator.startAnimating()
		activityIndicator.isUserInteractionEnabled = false
		pokemons.getData {
			DispatchQueue.main.async {
				self.navigationItem.title = "\(self.pokemons.pokemonArray.count) of \(self.pokemons.count) pokemons."
				self.tableView.reloadData()
				self.activityIndicator.stopAnimating()
				self.activityIndicator.isUserInteractionEnabled = true
			}
		}
	}
	
	func setUpActivityIndicator() {
		activityIndicator.center = self.view.center
		activityIndicator.hidesWhenStopped = true
		activityIndicator.style = .large
		activityIndicator.color = UIColor.red
		view.addSubview(activityIndicator)
	}
	
	func loadAll() {
		if pokemons.urlString.hasPrefix("http") {
			pokemons.getData {
				DispatchQueue.main.async {
					self.navigationItem.title = "\(self.pokemons.pokemonArray.count) of \(self.pokemons.count) pokemons."
					self.tableView.reloadData()
				}
				self.loadAll()
			}
		} else {
			DispatchQueue.main.async {
				print("All done - all loaded. Total Pokemons = \(self.pokemons.pokemonArray.count)")
				self.activityIndicator.stopAnimating()
				self.activityIndicator.isUserInteractionEnabled = true
			}
		}
	}
	
	@IBAction func loadAllButtonPressed(_ sender: UIBarButtonItem) {
		activityIndicator.startAnimating()
		activityIndicator.isUserInteractionEnabled = false
		loadAll()
	}
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  		let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
		if indexPath.row == pokemons.pokemonArray.count-1 && pokemons.urlString.hasPrefix("http") {
			self.activityIndicator.stopAnimating()
			self.activityIndicator.isUserInteractionEnabled = true
			pokemons.getData {
				DispatchQueue.main.async {
					self.navigationItem.title = "\(self.pokemons.pokemonArray.count) of \(self.pokemons.count) pokemons."
					self.tableView.reloadData()
					self.activityIndicator.stopAnimating()
					self.activityIndicator.isUserInteractionEnabled = true
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

