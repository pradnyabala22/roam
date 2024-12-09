import UIKit
import FirebaseFirestore

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var leaderboardView: LeaderboardView!
    var users: [(email: String, points: Int)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaderboardView = LeaderboardView()
        view = leaderboardView
        
        leaderboardView.leaderboardTableView.delegate = self
        leaderboardView.leaderboardTableView.dataSource = self
        
        fetchLeaderboardData()
    }

    func fetchLeaderboardData() {
        let database = Firestore.firestore()
        
        database.collection("users")
            .order(by: "points", descending: true)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching leaderboard data: \(error)")
                    return
                }
                
                self.users = snapshot?.documents.compactMap { document in
                    if let points = document.data()["points"] as? Int {
                        return (email: document.documentID, points: points)
                    }
                    return nil
                } ?? []
                
                DispatchQueue.main.async {
                    self.leaderboardView.leaderboardTableView.reloadData()
                }
            }
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath)
        let user = users[indexPath.row]
        
        cell.backgroundColor = UIColor(red: 234/255, green: 222/255, blue: 200/255, alpha: 1)
        
        let numberBubble = UILabel()
        numberBubble.text = "\(indexPath.row + 1)"
        numberBubble.font = UIFont(name: "Cochin-Bold", size: 18)
        numberBubble.textColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1)
        numberBubble.textAlignment = .center
        numberBubble.backgroundColor = UIColor(red: 95/255, green: 117/255, blue: 142/255, alpha: 1)
        numberBubble.layer.cornerRadius = 20
        numberBubble.layer.masksToBounds = true
        numberBubble.translatesAutoresizingMaskIntoConstraints = false
        
        let emailLabel = UILabel()
        emailLabel.text = user.email
        emailLabel.font = UIFont(name: "Cochin-Bold", size: 18)
        emailLabel.textColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let pointsLabel = UILabel()
        pointsLabel.text = "\(user.points) points"
        pointsLabel.font = UIFont(name: "Cochin", size: 18)
        pointsLabel.textColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1)
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(numberBubble)
        cell.contentView.addSubview(emailLabel)
        cell.contentView.addSubview(pointsLabel)
        
        NSLayoutConstraint.activate([
            numberBubble.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15),
            numberBubble.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            numberBubble.widthAnchor.constraint(equalToConstant: 40),
            numberBubble.heightAnchor.constraint(equalToConstant: 40),
            
            emailLabel.leadingAnchor.constraint(equalTo: numberBubble.trailingAnchor, constant: 15),
            emailLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 15),
            emailLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -15),
            
            pointsLabel.leadingAnchor.constraint(equalTo: numberBubble.trailingAnchor, constant: 15),
            pointsLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            pointsLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -15),
            pointsLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -15)
        ])
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero) 
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 
    }
}
