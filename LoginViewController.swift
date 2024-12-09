import UIKit
import FirebaseAuth

protocol LoginViewControllerDelegate: AnyObject {
    func userDidLogIn(user: FirebaseAuth.User)
}

class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
        view = loginView
        
        loginView.login.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginView.register.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
    @objc func loginTapped() {
        guard let email = loginView.email.text,
              let password = loginView.password.text,
              !email.isEmpty, !password.isEmpty else {
            showAlert(message: "Please enter both email and password.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(message: "Login failed: \(error.localizedDescription)")
            } else if let user = authResult?.user {
                self.delegate?.userDidLogIn(user: user)
                self.dismiss(animated: true)
            }
        }
    }
    
    @objc func registerTapped() {
        let registerController = RegisterViewController()
        self.present(registerController, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
