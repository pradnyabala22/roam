import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    var registerView: RegisterView!
    let database = Firestore.firestore()  

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Register"
        registerView = RegisterView()
        view = registerView
        
        registerView.register.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
    @objc func registerTapped() {
        guard let name = registerView.name.text, !name.isEmpty else {
            showAlert(message: "Please enter your name.")
            return
        }
        guard let email = registerView.email.text, !email.isEmpty else {
            showAlert(message: "Please enter your email.")
            return
        }
        guard let password = registerView.password.text, !password.isEmpty else {
            showAlert(message: "Please enter your password.")
            return
        }
        guard let repeatPassword = registerView.repeatPassword.text, !repeatPassword.isEmpty else {
            showAlert(message: "Please confirm your password.")
            return
        }
        if password != repeatPassword {
            showAlert(message: "Passwords do not match.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                self?.showAlert(message: "Error registering: \(error.localizedDescription)")
                return
            }
            
            self?.createUserDocument(email: email)
            
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    func createUserDocument(email: String) {
        let userData: [String: Any] = [
            "points": 0,
            "bookmarkedLocations": [],
            "visitedLocations": []
        ]
        
        database.collection("users").document(email).setData(userData) { error in
            if let error = error {
                print("Error creating Firestore document: \(error.localizedDescription)")
            } else {
                print("Firestore document created for user: \(email)")
            }
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
