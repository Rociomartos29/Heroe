//
//  TransformacionesDetailViewController.swift
//  DragonBallHeroes
//
//  Created by Rocio Martos on 14/1/24.
//

import UIKit

final class TransformationDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var TransformacionImage: UIImageView!
    
    @IBOutlet weak var NombreTransformacion: UILabel!
    
    @IBOutlet weak var DescripcionLabel: UILabel!
    
    
    // MARK: - Model
    private var transformationDetail: HeroeTransformation
    
    // MARK: - Initializer
    init(transformationDetail: HeroeTransformation) {
        self.transformationDetail = transformationDetail
        super.init(nibName: "TransformationDetailViewController", bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - UI Update
    private func updateUI() {
        NombreTransformacion.text = transformationDetail.name
        DescripcionLabel.text = transformationDetail.description
        
        if let imageURL = transformationDetail.photo, let url = URL(string: imageURL) {
            // Utiliza URLSession para cargar la imagen de forma asíncrona.
            URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
                guard let data = data, error == nil else {
                    print("Error cargando la imagen: \(error?.localizedDescription ?? "Desconocido")")
                    return
                }
                DispatchQueue.main.async {
                    // Utiliza UIImage(data:) para convertir los datos en una imagen.
                    let image = UIImage(data: data)
                    self?.TransformacionImage.image = image
                }
            }.resume()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Back to Heroes", style: .plain, target: self, action: #selector(goBackToHeroes))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.orange
        
        // Configure the navigation bar title
        let logo = UIImage(named: "AlternateDragonBallLogo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 50, height: 15)
        navigationItem.titleView = imageView
    }


    // MARK: - Action
    @objc
    private func goBackToHeroes(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
