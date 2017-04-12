//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Julien Saito on 4/12/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon?
    
    func populateCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLabel.text = pokemon.name
        thumbnail.image = UIImage(named: "\(pokemon.id)")
    }
}
