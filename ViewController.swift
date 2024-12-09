import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    var currentUser: FirebaseAuth.User?
    let database = Firestore.firestore()
    let mainView = MainView()
    
    let bostonLocations = [
        "Boston Common", "Fenway Park", "The Museum of Fine Arts, Boston",
        "Newbury Street", "The Boston Public Library", "Boston Tea Party Ships and Museum",
        "The North End", "Beacon Hill", "Boston Harbor Islands", "Franklin Park Zoo",
        "Harvard Square", "Isabella Stewart Gardner Museum", "Quincy Market",
        "The Charles River Esplanade", "Trident Booksellers & Cafe", "Tatte Bakery & Cafe",
        "Copley Square", "The Freedom Trail", "Museum of Science, Boston",
        "The Institute of Contemporary Art (ICA)", "Boston Children's Museum",
        "The Arnold Arboretum", "Castle Island", "John F. Kennedy Presidential Library and Museum",
        "The Paul Revere House", "Faneuil Hall Marketplace", "The USS Constitution Museum",
        "Bunker Hill Monument", "Boston Symphony Hall", "Rose Kennedy Greenway",
        "Samuel Adams Brewery", "Boston Chinatown", "SoWa Open Market",
        "Christian Science Plaza", "Emerald Necklace Conservancy", "Boston Seaport District",
        "Blue Hills Reservation", "Boston Athenaeum", "Boston Opera House",
        "Granary Burying Ground", "Boston Harborwalk", "Prudential Skywalk Observatory",
        "The Old State House", "The Old North Church", "Harbor Cruises to Georges Island",
        "The Boston Harbor Hotel", "Carson Beach", "Larz Anderson Auto Museum",
        "MIT Museum", "Harvard Museum of Natural History", "Boston Latin School Site",
        "The Hatch Shell", "South Boston Waterfront", "Rowes Wharf", "Piers Park",
        "The Eliot Hotel", "Longfellow Bridge", "Assembly Row", "Coolidge Corner Theatre",
        "The Mapparium", "The Sports Museum", "TD Garden", "Boston Public Market",
        "Boston City Hall Plaza", "Revere Beach", "Shirley-Eustis House",
        "Plimoth Patuxet Museums (near Boston)", "Dorchester Heights", "Fort Independence",
        "Waterfront Park", "Chesterwood (historic site)", "Stone Zoo (near Boston)",
        "Warren Anatomical Museum", "Brookline Reservoir Park", "Roxbury Heritage State Park",
        "East Boston Greenway", "Mary Baker Eddy Library", "Peabody Museum of Archaeology and Ethnology",
        "CambridgeSide Mall", "Boston Logan International Airport Viewing Area"
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = nil
        navigationItem.largeTitleDisplayMode = .never
        
        view = mainView
        
        setupNavigationButtons()
        
        mainView.bookmarkButton.addTarget(self, action: #selector(bookmarkLocation), for: .touchUpInside)
        mainView.visitedButton.addTarget(self, action: #selector(markAsVisited), for: .touchUpInside)
        mainView.leaderboardButton.addTarget(self, action: #selector(navigateToLeaderboard), for: .touchUpInside)
        mainView.randomLocationButton.addTarget(self, action: #selector(setRandomLocation), for: .touchUpInside)
        
        checkAuthenticationStatus()
    }
    
    private func setupNavigationButtons() {
        let profileButton = createStyledButton(title: "Profile", action: #selector(onProfileTapped))
        let logoutButton = createStyledButton(title: "Logout", action: #selector(onLogoutTapped))
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: profileButton),
                                              UIBarButtonItem(customView: logoutButton)]
    }
    
    private func createStyledButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "Cochin-Bold", size: 16)
        button.tintColor = .white // White text
        button.backgroundColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1) // Brown fill
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor // White border
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }
    
    @objc func onProfileTapped() {
        let profileController = ProfileViewController()
        navigationController?.pushViewController(profileController, animated: true)
    }
    
    @objc func onLogoutTapped() {
        do {
            try Auth.auth().signOut()
            let loginViewController = LoginViewController()
            loginViewController.delegate = self
            self.present(loginViewController, animated: true, completion: nil)
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func checkAuthenticationStatus() {
        if let user = Auth.auth().currentUser {
            currentUser = user
            loadUserPoints()
        } else {
            let loginViewController = LoginViewController()
            loginViewController.delegate = self
            self.present(loginViewController, animated: true)
        }
    }
    
    func loadUserPoints() {
        guard let userEmail = currentUser?.email else { return }
        
        database.collection("users").document(userEmail).getDocument { document, error in
            if let document = document, document.exists, let points = document.data()?["points"] as? Int {
                DispatchQueue.main.async {
                }
            } else {
                print("Error fetching points: \(String(describing: error))")
            }
        }
    }
    
    @objc func bookmarkLocation() {
        guard let userEmail = currentUser?.email else { return }
        guard let location = mainView.locationLabel.text?.replacingOccurrences(of: "Today's Location: \n", with: ""), !location.isEmpty else {
            showAlert(message: "No location selected!")
            return
        }
        
        database.collection("users").document(userEmail).setData([
            "bookmarkedLocations": FieldValue.arrayUnion([location])
        ], merge: true) { error in
            if let error = error {
                self.showAlert(message: "Failed to save bookmarked location: \(error.localizedDescription)")
            } else {
                self.showAlert(message: "Location bookmarked successfully!")
            }
        }
    }
    
    @objc func markAsVisited() {
        guard let userEmail = currentUser?.email else { return }
        let userDocRef = database.collection("users").document(userEmail)
        
        guard let currentLocation = mainView.locationLabel.text?.replacingOccurrences(of: "Today's Location: \n", with: ""), !currentLocation.isEmpty else {
            showAlert(message: "No location selected!")
            return
        }
        
        userDocRef.getDocument { document, error in
            if let document = document, document.exists {
                var visitedLocations = document.data()?["visitedLocations"] as? [String] ?? []
                var points = document.data()?["points"] as? Int ?? 0
                
                if !visitedLocations.contains(currentLocation) {
                    points += 10
                    visitedLocations.append(currentLocation)
                    
                    userDocRef.updateData([
                        "points": points,
                        "visitedLocations": visitedLocations
                    ]) { error in
                        if let error = error {
                            print("Error adding points: \(error)")
                            DispatchQueue.main.async {
                                self.showAlert(message: "Failed to add points: \(error.localizedDescription)")
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.showAlert(message: "Hope you had fun, added 10 points to your profile!")
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(message: "You've already visited this location!")
                    }
                }
            } else {
                print("Document does not exist or error fetching document: \(String(describing: error))")
                DispatchQueue.main.async {
                    self.showAlert(message: "Error fetching user data")
                }
            }
        }
    }
    
    @objc func setRandomLocation() {
        let randomLocation = bostonLocations.randomElement() ?? "No location available"
        mainView.locationLabel.text = "\(randomLocation)"
    }
    
    @objc func navigateToLeaderboard() {
        let leaderboardController = LeaderboardViewController()
        navigationController?.pushViewController(leaderboardController, animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let backgroundColor = UIColor(red: 95/255, green: 117/255, blue: 142/255, alpha: 1) // Leaderboard background color
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = backgroundColor
        
        let messageFont = UIFont(name: "Cochin-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16)
        let attributedMessage = NSAttributedString(string: message, attributes: [
            NSAttributedString.Key.font: messageFont,
            NSAttributedString.Key.foregroundColor: UIColor(red: 234/255, green: 222/255, blue: 200/255, alpha: 1) // Light brown text
        ])
        alert.setValue(attributedMessage, forKey: "attributedMessage")
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        okAction.setValue(UIColor(red: 234/255, green: 222/255, blue: 200/255, alpha: 1), forKey: "titleTextColor")
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

extension ViewController: LoginViewControllerDelegate {
    func userDidLogIn(user: FirebaseAuth.User) {
        currentUser = user
        loadUserPoints()
    }
}
