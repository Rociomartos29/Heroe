//
//  TransformationListTableViewController.swift
//  DragonBallHeroes
//
//  Created by Rocio Martos on 14/1/24.
//
import UIKit

class CustomTransformListViewController: UIViewController, UITableViewDelegate {
    
    //MARK: - Typealias
    typealias DataSource = UITableViewDiffableDataSource<Int, HeroeTransformation>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, HeroeTransformation>
    
    //MARK: - Models
    private var transformList: [HeroeTransformation]
    private var tableView: UITableView!
    private var dataSource: DataSource?
    
    //MARK: - Initializer
    init(transformList: [HeroeTransformation]) {
        self.transformList = transformList
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        applySnapshot()
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        title = "Transformations"
        
        let logo = UIImage(named: "CustomDragonBallLogo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 50, height: 15)
        navigationItem.titleView = imageView
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .orange
    }
    
    //MARK: - Table View Setup
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(CustomTransformTableViewCell.self, forCellReuseIdentifier: CustomTransformTableViewCell.identifier)
        tableView.rowHeight = 150
        tableView.delegate = self
        view.addSubview(tableView)
        
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, transform in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTransformTableViewCell.identifier, for: indexPath) as? CustomTransformTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: transform)
            return cell
        }
    }
    
    //MARK: - Apply Snapshot
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(transformList)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    //MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = .orange
        
        guard let transformDetail = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        
        let transformDetailSender = TransformationDetailViewController(transformationDetail: transformDetail)
        navigationController?.show(transformDetailSender, sender: nil)
        tableView.cellForRow(at: indexPath)?.backgroundColor = .white
    }
}

