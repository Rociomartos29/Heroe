//
//  HeroTableViewController.swift
//  DragonBallHeroes
//
//  Created by Rocio Martos on 14/1/24.
//

import UIKit
import Foundation


class HeroDetailViewController: UIViewController {
    @IBOutlet weak var DescripcionLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var TransformacionButton: UIButton!
    @IBOutlet weak var NameLabel: UILabel!
    var hero: Heroe?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configurar la vista con los datos del héroe
        if let hero = hero {
            NameLabel.text = hero.name
            DescripcionLabel.text = hero.description
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

   
        let transformationsVC = HeroesManager()
                navigationController?.pushViewController(transformationsVC, animated: true)
            }
}
