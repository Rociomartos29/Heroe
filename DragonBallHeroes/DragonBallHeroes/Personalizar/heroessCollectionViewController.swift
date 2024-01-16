
import UIKit

final class HeroCollectionViewController: UICollectionViewController {
    
    // MARK: - Typealiases
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Heroe>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Heroe>
    
    // MARK: - Models
    private let model = NetworkModel.shared
    private var dataSource: DataSource?
    
    // MARK: - Initializers
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchAndApplyData()
    }
    
    // MARK: - Collection View Configuration
    private func setupCollectionView() {
        // Configuración de la vista de colección...
    }
    
    // MARK: - Data Fetching and Application
    private func fetchAndApplyData() {
        model.fetchHeroes { [weak self] result in
            switch result {
            case let .success(items):
                var snapshot = Snapshot()
                snapshot.appendSections([0])
                snapshot.appendItems(items)
                self?.dataSource?.apply(snapshot)
            case let .failure(error):
                print("Error al obtener datos: \(error)")
            }
        }
    }
    // MARK: - Actions
    @objc
    private func cerrarSesion() {
        let loginVC = LoginViewController()
        navigationController?.setViewControllers([loginVC], animated: true)
    }
}

// MARK: - UICollectionViewDelegate
extension HeroCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange
            
            guard let selectedItem = dataSource?.itemIdentifier(for: indexPath) else { return }
            
            model.getCustomItems { [weak self] (result: Result<[HeroeTransformation], CustomNetworkError>) in
                switch result {
                case let .success(details):
                    DispatchQueue.main.async {
                        let heroesDetailViewController = HeroesDetailViewController(hero: selectedItem, transformations: details)
                        self?.navigationController?.show(heroesDetailViewController, sender: nil)
                        collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange
                    }
                case let .failure(error):
                    print("Error al obtener detalles: \(error)")
                }
            }
        }
    }
