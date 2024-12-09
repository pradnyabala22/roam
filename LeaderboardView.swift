import UIKit

class LeaderboardView: UIView, UITableViewDataSource {

    var leaderboardHeader: UILabel!
    var leaderboardTableView: UITableView!
    var leaderboardData: [(name: String, points: Int)] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 95/255, green: 117/255, blue: 142/255, alpha: 1)

        setupLeaderboardHeader()
        setupLeaderboardTableView()
        initConstraints()
    }
    
    func setupLeaderboardHeader() {
        leaderboardHeader = UILabel()
        leaderboardHeader.text = "Leaderboard"
        leaderboardHeader.font = UIFont(name: "Cochin-Bold", size: 50)
        leaderboardHeader.textColor = UIColor(red: 234/255, green: 222/255, blue: 200/255, alpha: 1)
        leaderboardHeader.textAlignment = .center
        leaderboardHeader.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leaderboardHeader)
    }
    
    func setupLeaderboardTableView() {
        leaderboardTableView = UITableView()
        leaderboardTableView.dataSource = self
        leaderboardTableView.translatesAutoresizingMaskIntoConstraints = false
        leaderboardTableView.register(UITableViewCell.self, forCellReuseIdentifier: "LeaderboardCell")
        leaderboardTableView.backgroundColor = .clear
        leaderboardTableView.separatorStyle = .none
        addSubview(leaderboardTableView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            leaderboardHeader.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            leaderboardHeader.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            leaderboardHeader.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            leaderboardTableView.topAnchor.constraint(equalTo: leaderboardHeader.bottomAnchor, constant: 20),
            leaderboardTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            leaderboardTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            leaderboardTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath)
        
        cell.backgroundColor = UIColor(red: 95/255, green: 117/255, blue: 142/255, alpha: 1)
        cell.textLabel?.font = UIFont(name: "Cochin-Bold", size: 18)
        cell.textLabel?.textColor = UIColor(red: 234/255, green: 222/255, blue: 200/255, alpha: 1)
        cell.textLabel?.text = "\(indexPath.row + 1). \(leaderboardData[indexPath.row].name) - \(leaderboardData[indexPath.row].points) Points"
        cell.selectionStyle = .none 
        
        return cell
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
