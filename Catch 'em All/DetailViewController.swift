//
//  DetailViewController.swift
//  Catch 'em All
//
//  Created by Reza Koushki on 21/01/2023.
//

import UIKit

class DetailViewController: UIViewController {
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var heightLabel: UILabel!
	@IBOutlet weak var weightLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	
	var pokemon: Pokemon!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		nameLabel.text = pokemon.name
		let pokemonDetail = PokemonDetail()
		pokemonDetail.urlString = pokemon.url
		pokemonDetail.getData {
			DispatchQueue.main.async {
				self.weightLabel.text = "\(pokemonDetail.weight)"
				self.heightLabel.text = "\(pokemonDetail.height)"
				guard let url = URL(string: pokemonDetail.imageURL) else {return}
				
				do {
					let data = try Data(contentsOf: url)
					self.imageView.image = UIImage(data: data)
				} catch {
					print("ERROR: error thrown trying to get image from url \(url)")
				}
			}
		}
    }
}
