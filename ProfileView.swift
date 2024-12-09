import UIKit

class ProfileView: UIView, UITableViewDataSource {

    var profileHeader: UILabel!
    var emailLabel: UILabel!
    var pointsLabel: UILabel!
    var savedLocationsLabel: UILabel!
    var savedLocations: UITableView!
    var savedLocationsData: [String] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupProfileHeader()
        setupEmailLabel()
        setupPointsLabel()
        setupSavedLocationsLabel()
        setupSavedLocations()
        initConstraints()
    }

    func setupProfileHeader() {
        profileHeader = UILabel()
        profileHeader.text = "Profile"
        profileHeader.font = UIFont(name: "Cochin-Bold", size: 50)
        profileHeader.textAlignment = .center
        profileHeader.textColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1)
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileHeader)
    }

    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.text = "Email:"
        emailLabel.font = UIFont(name: "Cochin-Bold", size: 20)
        emailLabel.textAlignment = .center
        emailLabel.textColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailLabel)
    }

    func setupPointsLabel() {
        pointsLabel = UILabel()
        pointsLabel.text = "0"
        pointsLabel.font = UIFont(name: "Cochin-Bold", size: 24)
        pointsLabel.textAlignment = .center
        pointsLabel.layer.cornerRadius = 75
        pointsLabel.layer.borderWidth = 2
        pointsLabel.layer.borderColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1).cgColor
        pointsLabel.clipsToBounds = true
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pointsLabel)
    }

    func setupSavedLocationsLabel() {
        savedLocationsLabel = UILabel()
        savedLocationsLabel.text = "Bookmarked Locations"
        savedLocationsLabel.font = UIFont(name: "Cochin-Bold", size: 20)
        savedLocationsLabel.textColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1)
        savedLocationsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(savedLocationsLabel)
    }

    func setupSavedLocations() {
        savedLocations = UITableView()
        savedLocations.dataSource = self
        savedLocations.register(UITableViewCell.self, forCellReuseIdentifier: "location")
        savedLocations.backgroundColor = UIColor(red: 234/255, green: 222/255, blue: 200/255, alpha: 1)
        savedLocations.translatesAutoresizingMaskIntoConstraints = false
        savedLocations.layer.cornerRadius = 10
        savedLocations.layer.masksToBounds = true
        self.addSubview(savedLocations)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedLocationsData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "location", for: indexPath)
        cell.textLabel?.text = savedLocationsData[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Cochin-Bold", size: 18)
        cell.textLabel?.textColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1) 
        cell.backgroundColor = UIColor(red: 234/255, green: 222/255, blue: 200/255, alpha: 1)
        cell.selectionStyle = .none
        return cell
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            profileHeader.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            profileHeader.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            profileHeader.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: profileHeader.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            pointsLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            pointsLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            pointsLabel.widthAnchor.constraint(equalToConstant: 150), // Adjusted for larger circle
            pointsLabel.heightAnchor.constraint(equalToConstant: 150), // Adjusted for larger circle
            
            savedLocationsLabel.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: 30),
            savedLocationsLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            savedLocationsLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            savedLocations.topAnchor.constraint(equalTo: savedLocationsLabel.bottomAnchor, constant: 10),
            savedLocations.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            savedLocations.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            savedLocations.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
