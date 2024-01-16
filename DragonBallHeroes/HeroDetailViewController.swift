//
//  HeroDetailViewController.swift
//  DragonBallHeroes
//
//  Created by Rocio Martos on 14/1/24.
//

import UIKit

@IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var transformationsButton: UIButton!

    var hero: Hero?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configurar la vista con los datos del héroe
        if let hero = hero {
            nameLabel.text = hero.name
            descriptionLabel.text = hero.description
            // Configurar la imagen (puedes usar alguna biblioteca como SDWebImage para cargar imágenes desde una URL)
            // imageView.image = UIImage(named: hero.image)
        }
    }

    // Acción del botón para mostrar la lista de transformaciones
    @IBAction func showTransformationsTapped(_ sender: UIButton) {
        guard let hero = hero else {
            // Manejar el caso en que no haya un héroe configurado
            return
        }

        // Aquí puedes navegar a la vista de lista de transformaciones (puedes usar un Segue, Coordinator, etc.)
        // Por ejemplo:
        let transformationsVC = TransformationsViewController(hero: hero)
        navigationController?.pushViewController(transformationsVC, animated: true)
    }
}
