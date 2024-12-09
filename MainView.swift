import UIKit

class MainView: UIView {

    var locationLabel: UILabel!
    var bookmarkButton: UIButton!
    var visitedButton: UIButton!
    var leaderboardButton: UIButton!
    var randomLocationButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 234/255, green: 222/255, blue: 200/255, alpha: 1) 
        
        setupRoamLabel()
        setupLocationLabel()
        setupBookmark()
        setupVisited()
        setupLeaderboardButton()
        setupRandomLocationButton()
        initConstraints()
    }
    
    func setupRoamLabel() {
        let roamLabel = UILabel()
        roamLabel.text = "Roam"
        roamLabel.font = UIFont(name: "Cochin-Bold", size: 40)
        roamLabel.textColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1) 
        roamLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(roamLabel)
        roamLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        roamLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
    }
    
    func setupLocationLabel() {
        locationLabel = UILabel()
        locationLabel.text = ""
        locationLabel.font = UIFont(name: "Cochin-Bold", size: 22)
        locationLabel.textColor = UIColor(red: 95/255, green: 117/255, blue: 142/255, alpha: 1) // #5F758E
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(locationLabel)
    }
    
    func setupBookmark() {
        bookmarkButton = createStyledButton(title: "Bookmark")
        self.addSubview(bookmarkButton)
    }
    
    func setupVisited() {
        visitedButton = createStyledButton(title: "Visited")
        self.addSubview(visitedButton)
    }

    func setupLeaderboardButton() {
        leaderboardButton = createStyledButton(title: "Leaderboard")
        self.addSubview(leaderboardButton)
    }
    
    func setupRandomLocationButton() {
        randomLocationButton = createStyledButton(title: "Find Random Location")
        self.addSubview(randomLocationButton)
    }
    
    private func createStyledButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "Cochin-Bold", size: 18)
        button.tintColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1) // Dark brown text
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            locationLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            bookmarkButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 40),
            bookmarkButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 200),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 50),
            
            visitedButton.topAnchor.constraint(equalTo: bookmarkButton.bottomAnchor, constant: 20),
            visitedButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            visitedButton.widthAnchor.constraint(equalToConstant: 200),
            visitedButton.heightAnchor.constraint(equalToConstant: 50),
            
            leaderboardButton.topAnchor.constraint(equalTo: visitedButton.bottomAnchor, constant: 20),
            leaderboardButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            leaderboardButton.widthAnchor.constraint(equalToConstant: 200),
            leaderboardButton.heightAnchor.constraint(equalToConstant: 50),
            
            randomLocationButton.topAnchor.constraint(equalTo: leaderboardButton.bottomAnchor, constant: 20),
            randomLocationButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            randomLocationButton.widthAnchor.constraint(equalToConstant: 220),
            randomLocationButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
