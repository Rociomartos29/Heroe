//
//  personalizarCollectionViewCell.swift
//  DragonBallHeroes
//
//  Created by Rocio Martos on 15/1/24.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    @IBOutlet private weak var nameLabel: UILabel!
    // ... otras outlets según tus necesidades
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Configuraciones adicionales, si las necesitas
    }
    
    func configure(with item: Heroe) {
        nameLabel.text = item.name
        // Configura otras propiedades según tus necesidades
    }
}
