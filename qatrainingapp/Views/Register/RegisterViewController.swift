//import UIKit
//
//class RegisterViewController: UIViewController {
//
//    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var usernameTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var registerButton: UIButton!
//    
//    var userManager: UserManager!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        userManager = UserManager()
//
//        // Set up the register button action
//        registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
//    }
//
//    @objc func registerUser() {
//        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty,
//              let username = usernameTextField.text?.trimmingCharacters(in: .whitespaces), !username.isEmpty,
//              let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces), !password.isEmpty else {
//            showToast(message: "All fields are required")
//            return
//        }
//
//        // Save user information
//        //userManager.saveUser(name: name, username: username, password: password)
//        showToast(message: "User registered successfully!")
//        
//        // Dismiss the view controller (go back to the login screen)
//        navigationController?.popViewController(animated: true)
//    }
//
//    // Function to display toast-like messages
//    func showToast(message: String) {
//        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2 - 150, y: self.view.frame.size.height - 100, width: 300, height: 50))
//        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        toastLabel.textColor = UIColor.white
//        toastLabel.textAlignment = .center;
//        toastLabel.font = UIFont.systemFont(ofSize: 16)
//        toastLabel.text = message
//        toastLabel.alpha = 1.0
//        toastLabel.layer.cornerRadius = 10;
//        toastLabel.clipsToBounds = true;
//        self.view.addSubview(toastLabel)
//        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
//            toastLabel.alpha = 0.0
//        }, completion: { (isCompleted) in
//            toastLabel.removeFromSuperview()
//        })
//    }
//}
