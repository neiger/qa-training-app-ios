import UIKit

class HomeViewController: UIViewController {

    // MARK: - UI Components

    private let drawerWidth: CGFloat = 250
    private var isDrawerOpen = false
    var loginViewModel: LoginViewModel!

    private let drawerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("☰", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let calculatorButton = HomeViewController.createMenuButton(title: "Calculator")
    private let registerButton = HomeViewController.createMenuButton(title: "Register")
    private let logoutButton = HomeViewController.createMenuButton(title: "Log Out")

    private var drawerLeadingConstraint: NSLayoutConstraint!

    static func createMenuButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 60/255, green: 77/255, blue: 103/255, alpha: 1.0)

        setupDrawer()
        setupMenuActions()

        // Inactivity Timer
        InactivityManager.shared.onTimeout = { [weak self] in
            DispatchQueue.main.async {
                self?.logout()
            }
        }
        InactivityManager.shared.start()
    }

    // MARK: - Drawer Setup

    private func setupDrawer() {
        view.addSubview(drawerView)
        view.addSubview(menuButton)

        drawerLeadingConstraint = drawerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -drawerWidth)

        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            drawerLeadingConstraint,
            drawerView.topAnchor.constraint(equalTo: view.topAnchor),
            drawerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            drawerView.widthAnchor.constraint(equalToConstant: drawerWidth)
        ])

        drawerView.addSubview(calculatorButton)
        drawerView.addSubview(registerButton)
        drawerView.addSubview(logoutButton)

        NSLayoutConstraint.activate([
            calculatorButton.topAnchor.constraint(equalTo: drawerView.topAnchor, constant: 100),
            calculatorButton.leadingAnchor.constraint(equalTo: drawerView.leadingAnchor, constant: 20),

            registerButton.topAnchor.constraint(equalTo: calculatorButton.bottomAnchor, constant: 30),
            registerButton.leadingAnchor.constraint(equalTo: calculatorButton.leadingAnchor),

            logoutButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 30),
            logoutButton.leadingAnchor.constraint(equalTo: calculatorButton.leadingAnchor)
        ])

        menuButton.addTarget(self, action: #selector(toggleDrawer), for: .touchUpInside)
    }

    @objc private func toggleDrawer() {
        isDrawerOpen.toggle()
        drawerLeadingConstraint.constant = isDrawerOpen ? 0 : -drawerWidth

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - Menu Actions

    private func setupMenuActions() {
        calculatorButton.addTarget(self, action: #selector(openCalculator), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(openRegister), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }

    @objc private func openCalculator() {
        toggleDrawer()
        
        let alert = UIAlertController(title: nil, message: "Calculator tapped (placeholder)", preferredStyle: .alert)
        self.present(alert, animated: true)

        // Dismiss after 1.5 seconds like a toast
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            alert.dismiss(animated: true, completion: nil)
        }
    }


    @objc private func openRegister() {
        toggleDrawer()
        let registerVC = RegisterViewController()
        registerVC.loginViewModel = self.loginViewModel
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true, completion: nil)
    }

    @objc func logout() {
        InactivityManager.shared.stop()
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
}
