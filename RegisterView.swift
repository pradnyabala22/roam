import UIKit

class RegisterView: UIView {

    var name: UITextField!
    var email: UITextField!
    var password: UITextField!
    var repeatPassword: UITextField!
    var register: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1)
        
        setupName()
        setupEmail()
        setupPassword()
        setupRepeatPassword()
        setupRegister()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRepeatPassword() {
        repeatPassword = UITextField()
        repeatPassword.placeholder = "Confirm Password"
        repeatPassword.isSecureTextEntry = true
        repeatPassword.textContentType = .newPassword
        repeatPassword.passwordRules = nil
        repeatPassword.borderStyle = .roundedRect
        repeatPassword.textAlignment = .center
        repeatPassword.font = UIFont(name: "Cochin-Bold", size: 18)
        repeatPassword.translatesAutoresizingMaskIntoConstraints = false
        addSubview(repeatPassword)
    }
    
    func setupRegister() {
        register = UIButton(type: .system)
        register.setTitle("Register", for: .normal)
        register.tintColor = .white
        register.backgroundColor = UIColor(red: 95/255, green: 117/255, blue: 142/255, alpha: 1)
        register.layer.cornerRadius = 12
        register.layer.borderWidth = 2
        register.layer.borderColor = UIColor.white.cgColor
        register.titleLabel?.font = UIFont(name: "Cochin-Bold", size: 20)
        register.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(register)
    }
    
    func setupName() {
        name = UITextField()
        name.placeholder = "Name"
        name.borderStyle = .roundedRect
        name.textAlignment = .center
        name.font = UIFont(name: "Cochin-Bold", size: 18)
        name.translatesAutoresizingMaskIntoConstraints = false
        addSubview(name)
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
        password.textContentType = .newPassword
        password.passwordRules = nil
        password.borderStyle = .roundedRect
        password.textAlignment = .center
        password.font = UIFont(name: "Cochin-Bold", size: 18)
        password.translatesAutoresizingMaskIntoConstraints = false
        addSubview(password)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            name.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            name.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            name.heightAnchor.constraint(equalToConstant: 50),
            
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            email.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            email.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            email.heightAnchor.constraint(equalToConstant: 50),
            
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20),
            password.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            password.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            password.heightAnchor.constraint(equalToConstant: 50),
            
            repeatPassword.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
            repeatPassword.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            repeatPassword.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            repeatPassword.heightAnchor.constraint(equalToConstant: 50),
            
            register.topAnchor.constraint(equalTo: repeatPassword.bottomAnchor, constant: 30), 
            register.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            register.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            register.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
