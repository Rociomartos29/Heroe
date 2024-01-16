//
//  UITableViewController.swift
//  DragonBallHeroes
//
//  Created by Rocio Martos on 14/1/24.
//

import UIKit

class HeroesTableViewController: UITableViewController {
    var heroes: [Heroe] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        HeroesManager.shared.getHeroes { [weak self] heroes, error in
            guard let self = self, let heroes = heroes else {
                // Manejar el error de alguna manera (mostrar un mensaje de error, etc.)
                return
            }

            self.heroes = heroes

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // Implementa los métodos necesarios para la UITableViewDataSource y UITableViewDelegate aquí
}
