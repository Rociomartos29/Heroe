import UIKit
struct User {
    let username: String
    let password: String
    
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    // Puedes agregar más métodos según sea necesario
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextFile: UITextField!
    @IBOutlet weak var passwordTextFile: UITextField!
    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var buttonLogin: UIButton!
    
    private let model = NetworkModel.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        buttonLogin.backgroundColor = UIColor.black
        buttonLogin.layer.cornerRadius = 8.0
    }
    
    // MARK: - Actions
    @IBAction func buttonLoginTapped(_ sender: UIButton) {
        animateButtonTap()
        
        model.login(user: emailTextFile.text ?? "", password: passwordTextFile.text ?? "") { [weak self] (result: Result<User, Error> ) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.navigateToHeroes()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    // MARK: - Navigation
    private func navigateToHeroes() {
        let heroeCollectionViewController = HeroCollectionViewController()
        navigationController?.pushViewController(heroeCollectionViewController, animated: true)
    }
    
    // MARK: - Button Animation
    private func animateButtonTap() {
        UIView.animate(
            withDuration: 0.2,
            animations: { [weak self] in
                guard let self = self else { return }
                self.buttonLogin.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { [weak self] _ in
                guard let self = self else { return }
                UIView.animate(
                    withDuration: 0.2,
                    animations: {
                        self.buttonLogin.transform = .identity
                    }
                )
            }
        )
    }
}
