//
//  HeroesDetailViewController.swift
//  DragonBallHeroes
//
//  Created by Rocio Martos on 14/1/24.
//

import UIKit

class HeroesDetailViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var NombreLable: UILabel!
    
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var TransformacionBoton: UIButton!
    @IBOutlet weak var imagenView: UIImageView!
    // MARK: - Models
      private let hero: Heroe
      private let heroTransformations: [HeroeTransformation]

      // MARK: - Initializers
      init(hero: Heroe, transformations: [HeroeTransformation]) {
          self.hero = hero
          self.heroTransformations = transformations
          super.init(nibName: nil, bundle: nil)
      }

      @available(*, unavailable)
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

      // MARK: - Lifecycle
      override func viewDidLoad() {
          super.viewDidLoad()

          showButton(cantidad: heroTransformations.count)
          updateUI()
      }
   
    
      // MARK: - Actions
    
      // MARK: - UI Functions
    private func updateUI() {
        NombreLable.text = hero.name
        descripcionLabel.text = hero.description

        // Utiliza la propiedad image para establecer la imagen en UIImageView
        if let imageURL = hero.imageURL, let url = URL(string: imageURL) {
            // Utiliza URLSession para cargar la imagen de forma asíncrona.
            URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
                guard let data = data, error == nil else {
                    print("Error cargando la imagen: \(error?.localizedDescription ?? "Desconocido")")
                    return
                }
                DispatchQueue.main.async {
                    // Utiliza UIImage(data:) para convertir los datos en una imagen.
                    let image = UIImage(data: data)
                    self?.imagenView.image = image
                }
            }.resume()
        }

        let logo = UIImage(named: "DragonBallLogo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 50, height: 15)
        navigationItem.titleView = imageView

        navigationItem.backBarButtonItem?.title = "Heroes"
        navigationItem.backBarButtonItem?.tintColor = .red // Cambiar al color deseado

        TransformacionBoton.tintColor = .black
    }

      private func showButton(cantidad: Int?) {
          TransformacionBoton.isHidden = cantidad == 0
      }
  }

  // MARK: - Animations
  extension HeroesDetailViewController {
      private func zoomIn() {
              UIView.animate(
                  withDuration: 0.2,
                  delay: 0,
                  usingSpringWithDamping: 0.15,
                  initialSpringVelocity: 0.5
              ) { [weak self] in
                  self?.TransformacionBoton.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
              }
          }

          private func zoomOut() {
              UIView.animate(
                  withDuration: 0.2,
                  delay: 0,
                  usingSpringWithDamping: 0.4,
                  initialSpringVelocity: 2
              ) { [weak self] in
                  self?.TransformacionBoton.transform = .identity
              }
          }
  }
