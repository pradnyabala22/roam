import UIKit

class LoginView: UIView {

    var email: UITextField!
    var password: UITextField!
    var login: UIButton!
    var register: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1)
        
        setupEmail()
        setupPassword()
        setupRegister()
        setupLogin()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRegister() {
        register = UIButton(type: .system)
        register.setTitle("Register", for: .normal)
        register.tintColor = .white
        register.titleLabel?.font = UIFont(name: "Cochin-Bold", size: 18)
        register.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(register)
    }
    
    func setupLogin() {
        login = UIButton(type: .system)
        login.setTitle("Login", for: .normal)
        login.tintColor = .white
        login.backgroundColor = UIColor(red: 95/255, green: 117/255, blue: 142/255, alpha: 1)
        login.layer.cornerRadius = 12
        login.layer.borderWidth = 2
        login.layer.borderColor = UIColor.white.cgColor
        login.titleLabel?.font = UIFont(name: "Cochin-Bold", size: 18)
        login.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(login)
    }
    
    func setupEmail() {
        email = UITextField()
        email.placeholder = "Email"
        email.borderStyle = .roundedRect
        email.textAlignment = .center
        email.font = UIFont(name: "Cochin-Bold", size: 18)
        email.translatesAutoresizingMaskIntoConstraints = false
        addSubview(email)
    }
    
    func setupPassword() {
        password = UITextField()
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.borderStyle = .roundedRect
        password.textAlignment = .center
        password.font = UIFont(name: "Cochin-Bold", size: 18)
        password.translatesAutoresizingMaskIntoConstraints = false
        addSubview(password)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            email.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 140),
            email.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            email.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            email.heightAnchor.constraint(equalToConstant: 50),
            
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20),
            password.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            password.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            password.heightAnchor.constraint(equalToConstant: 50),
            
            login.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 30),
            login.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            login.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            login.heightAnchor.constraint(equalToConstant: 55),
            
            register.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 25), 
            register.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
