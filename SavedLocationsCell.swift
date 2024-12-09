//
//  SavedLocationsCell.swift
//  roam
//
//  Created by user266918 on 11/28/24.
//

import UIKit

class SavedLocationsCell: UITableViewCell {

    var wrapperCellView: UIView!
    var labelName: UILabel!
    var image: UIImageView!
        
    //MARK: unused methods...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupWrapperCellView()
            setupLabelName()
            setupImage()
            initConstraints()
        }
    
        func setupImage() {
            image = UIImageView()
            image.image = UIImage(systemName: "star.fill")
            image.contentMode = .scaleToFill
            image.clipsToBounds = true
            image.layer.cornerRadius = 10
            image.translatesAutoresizingMaskIntoConstraints = false
            wrapperCellView.addSubview(image)
        }
        
        func setupWrapperCellView(){
            wrapperCellView = UITableViewCell()
            wrapperCellView.layer.borderColor = UIColor.gray.cgColor
            wrapperCellView.layer.borderWidth = 1
            wrapperCellView.layer.cornerRadius = 5
            wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(wrapperCellView)
        }
        
        func setupLabelName(){
            labelName = UILabel()
            labelName.translatesAutoresizingMaskIntoConstraints = false
            wrapperCellView.addSubview(labelName)
        }
        
        func initConstraints(){
            NSLayoutConstraint.activate([
                wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor),
                wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                
                image.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
                image.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
                image.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
                image.widthAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
                
                labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 28),
                labelName.heightAnchor.constraint(equalToConstant: 20),
                labelName.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 8),
                
                wrapperCellView.heightAnchor.constraint(equalToConstant: 76)
            ])
        }

}
