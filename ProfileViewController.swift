//
//  ProfileViewController.swift
//  roam
//
//  Created by user266918 on 11/28/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    let database = Firestore.firestore()
    var currentUser: FirebaseAuth.User?
    var profileView: ProfileView!

    override func viewDidLoad() {
        super.viewDidLoad()

        profileView = ProfileView()
        view = profileView

        setupProfileHeader()

        setupNavigationBarAppearance()

        profileView.savedLocations.delegate = self
        
        if let user = Auth.auth().currentUser {
            currentUser = user
            loadUserData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserData()
    }
    
    func setupProfileHeader() {
        let profileHeader = UILabel()
        profileHeader.text = "Profile"
        profileHeader.font = UIFont(name: "Cochin-Bold", size: 50)
        profileHeader.textColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1)
        profileHeader.textAlignment = .center
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileHeader)
        
        NSLayoutConstraint.activate([
            profileHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeader.bottomAnchor.constraint(equalTo: profileView.emailLabel.topAnchor, constant: -20)
        ])
    }

    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 95/255, green: 75/255, blue: 62/255, alpha: 1)
    
        appearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Cochin-Bold", size: 18)!
        ]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.backButtonTitle = ""
    }

    func loadUserData() {
        guard let userEmail = currentUser?.email else { return }

        let userDocRef = database.collection("users").document(userEmail)
        
        userDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                DispatchQueue.main.async {
                    self.profileView.emailLabel.text = "Email: \(userEmail)"
                    
                    if let points = document.data()?["points"] as? Int {
                        self.profileView.pointsLabel.text = "Points: \(points)"
                    } else {
                        self.profileView.pointsLabel.text = "Points: 0"
                    }
                    
                    if let bookmarkedLocations = document.data()?["bookmarkedLocations"] as? [String] {
                        self.profileView.savedLocationsData = bookmarkedLocations
                        self.profileView.savedLocations.reloadData()
                    } else {
                        self.profileView.savedLocationsData = []
                        self.profileView.savedLocations.reloadData()
                    }
                }
            } else {
                print("Error fetching user document: \(String(describing: error))")
            }
        }
    }
    
    func deleteBookmarkedLocation(at index: Int) {
        guard let userEmail = currentUser?.email else { return }
        let userDocRef = database.collection("users").document(userEmail)
        
        let locationToDelete = profileView.savedLocationsData[index]
        
        userDocRef.updateData([
            "bookmarkedLocations": FieldValue.arrayRemove([locationToDelete])
        ]) { error in
            if let error = error {
                print("Error deleting location: \(error.localizedDescription)")
            } else {
                print("Location deleted successfully!")
                DispatchQueue.main.async {
                    self.profileView.savedLocationsData.remove(at: index)
                    self.profileView.savedLocations.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            self.deleteBookmarkedLocation(at: indexPath.row)
            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor(red: 220/255, green: 90/255, blue: 90/255, alpha: 1) 
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
