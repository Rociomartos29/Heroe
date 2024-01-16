//
//  TransformacionesTableViewCell.swift
//  DragonBallHeroes
//
//  Created by Rocio Martos on 14/1/24.
//

import UIKit

class CustomTransformTableViewCell: UITableViewCell {

    //MARK: - Identifier
    static let identifier = "CustomTransformTableViewCell"

    //MARK: - Outlets
    let transformNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let transformImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let transformInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // Para admitir varias líneas de texto
        return label
    }()

    //MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }

    //MARK: - Configure
    func configure(with transform: HeroeTransformation) {
        transformNameLabel.text = transform.name
        transformInfoLabel.text = transform.description
        
        if let imageURL = transform.photo, let url = URL(string: imageURL) {
            // Utiliza URLSession para cargar la imagen de forma asíncrona
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("Error cargando la imagen: \(error?.localizedDescription ?? "Desconocido")")
                    return
                }
                
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    self?.imageView?.image = image
                }
            }.resume()
        }
    }
    //MARK: - UI Setup
    private func setupUI() {
        // Agregar subvistas y establecer restricciones
        addSubview(transformNameLabel)
        addSubview(transformImage)
        addSubview(transformInfoLabel)

        NSLayoutConstraint.activate([
            transformImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            transformImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            transformImage.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8),
            transformImage.widthAnchor.constraint(equalToConstant: 80),
            
            transformNameLabel.leadingAnchor.constraint(equalTo: transformImage.trailingAnchor, constant: 8),
            transformNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            transformInfoLabel.leadingAnchor.constraint(equalTo: transformImage.trailingAnchor, constant: 8),
            transformInfoLabel.topAnchor.constraint(equalTo: transformNameLabel.bottomAnchor, constant: 4),
            transformInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            transformInfoLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8)
        ])
    }
}
