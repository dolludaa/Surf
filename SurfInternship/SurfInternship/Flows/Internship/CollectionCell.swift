//
//  CollectionCell.swift
//  SurfInternship
//
//  Created by Людмила Долонтаева on 2/8/23.
//
import UIKit
import Foundation

class CollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MyCollectionCell"
    
    let directionLabel = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupLayout()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        
        directionLabel.numberOfLines = 1
        directionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = UIColor(named: "cellBackground")
    }
    
    private func setupLayout() {
        
        directionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(directionLabel)
        
        directionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        directionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        directionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 24).isActive = true
        directionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -24).isActive = true
    }
    
    func configure(text: String?, isSelected: Bool) {
        
        directionLabel.text = text
        directionLabel.textColor = isSelected ? .white : .black
        contentView.backgroundColor = isSelected ? UIColor(named: "buttonColor") :  UIColor(named: "cellBackground")
    }
}

