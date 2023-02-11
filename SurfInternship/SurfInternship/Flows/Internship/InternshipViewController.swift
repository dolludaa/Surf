//
//  InternshipViewController.swift
//  SurfInternship
//
//  Created by Людмила Долонтаева on 2/8/23.
//

import Foundation
import UIKit
import PullUpController
import AlignedCollectionViewFlowLayout

class InternshipViewController: PullUpController {
    
    private let reuseIdentifier = "MyCollectionCell"
    private let infiniteFlowLayout = UICollectionViewFlowLayout()
    private let doubleFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
    private let dataService = DataService()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let conditionLabel = UILabel()
    private let contentView = UIView()
    private let applyButton = UIButton()
    private let wantLabel = UILabel()
    private let maxCellCount = 500
    private let infiniteDataSource = InfiniteDirectionsDataSource()
    private let doubleDataSource = DoubleDataSource()
    private let whiteView = UIView()
    private lazy var infiniteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: infiniteFlowLayout)
    private lazy var doubleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: doubleFlowLayout)
    
    var lowestPoint: CGFloat {
        
        infiniteCollectionView.frame.maxY + contentView.frame.maxY - applyButton.frame.minY + 32
    }

    override var pullUpControllerMiddleStickyPoints: [CGFloat] {
        
        guard let parent else { return [] }
        let insets = parent.view.safeAreaInsets.top
        let bottomPadding = 276 + view.safeAreaInsets.bottom
        let height = parent.view.bounds.height - insets
        
        return [bottomPadding, 500, height]
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadData()
        setupLayout()
        setupStyle()
    }
    
    private func scrollToMiddleItem() {
        
        let indexPath = IndexPath(row: maxCellCount / 2 , section: 0)
        infiniteCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    private func setupLayout() {
        
        view.addSubview(contentView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        wantLabel.translatesAutoresizingMaskIntoConstraints = false
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        infiniteCollectionView.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        doubleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(infiniteCollectionView)
        contentView.addSubview(doubleCollectionView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(conditionLabel)
        contentView.addSubview(whiteView)
        contentView.addSubview(applyButton)
        contentView.addSubview(wantLabel)
        
        titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -12).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        infiniteCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12).isActive = true
        infiniteCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        infiniteCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        infiniteCollectionView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        conditionLabel.topAnchor.constraint(equalTo: infiniteCollectionView.bottomAnchor, constant: 24).isActive = true
        conditionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        conditionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        
        doubleCollectionView.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 12).isActive = true
        doubleCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        doubleCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        doubleCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        applyButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        applyButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        applyButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        applyButton.addTarget(self, action: #selector(sendApplicationButtonTapped), for: .touchUpInside)
        
        wantLabel.centerYAnchor.constraint(equalTo: applyButton.centerYAnchor).isActive = true
        wantLabel.rightAnchor.constraint(lessThanOrEqualTo: applyButton.leftAnchor, constant: -5).isActive = true
        wantLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        wantLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        whiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        whiteView.topAnchor.constraint(equalTo: applyButton.topAnchor).isActive = true
        whiteView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        whiteView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
    }
    
    @objc private func sendApplicationButtonTapped() {
        
        let alert = UIAlertController(title: "Поздравляем!", message: "Ваша заявка успешно отправлена!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func setupStyle() {
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = UIColor(named: "fontColor")
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.setLineSpacing(lineHeightMultiple: 1.2)
        
        applyButton.layer.masksToBounds = true
        applyButton.setTitle("Отправить заявку", for: .normal)
        applyButton.backgroundColor = UIColor(named: "buttonColor" )
        applyButton.setBackgroundColor(.lightGray, forState: .highlighted)
        applyButton.layer.cornerRadius = 30
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        applyButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
        
        wantLabel.text = "Хочешь к нам?"
        wantLabel.font = .systemFont(ofSize: 14, weight: .regular)
        wantLabel.textColor = UIColor(named: "fontColor")
        
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 32
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        infiniteFlowLayout.scrollDirection = .horizontal
        infiniteFlowLayout.minimumInteritemSpacing = 12
        infiniteFlowLayout.minimumLineSpacing = 12
        infiniteFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        infiniteCollectionView.dataSource = infiniteDataSource
        infiniteCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.reuseIdentifier)
        infiniteCollectionView.contentInset.left = 20
        infiniteCollectionView.contentInset.right = 20
        infiniteCollectionView.showsHorizontalScrollIndicator = false
        
        doubleFlowLayout.minimumInteritemSpacing = 12
        doubleFlowLayout.minimumLineSpacing = 12
        doubleFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        doubleCollectionView.isScrollEnabled = false
        doubleCollectionView.dataSource = doubleDataSource
        doubleCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.reuseIdentifier)
        doubleCollectionView.delegate = doubleDataSource
        doubleCollectionView.contentInset.left = 20
        doubleCollectionView.contentInset.right = 20
        doubleCollectionView.showsHorizontalScrollIndicator = false
        
        conditionLabel.numberOfLines = 0
        conditionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        conditionLabel.textColor = UIColor(named: "fontColor")
        conditionLabel.lineBreakMode = .byWordWrapping
        conditionLabel.setLineSpacing(lineHeightMultiple: 1.2)
        
        whiteView.backgroundColor = .white
    }
    
    private func loadData() {
        
        dataService.fetchNewData { [weak self] result in
            switch result {
            case .success(let dataModel):
                self?.configure(dataModel: dataModel)
                self?.infiniteDataSource.directions = dataModel.directions
                self?.doubleDataSource.directions = dataModel.directions
                self?.infiniteCollectionView.reloadData()
                DispatchQueue.main.async {
                    self?.scrollToMiddleItem()
                }
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default ))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func configure(dataModel: DataModel) {
        
        titleLabel.text = dataModel.title
        descriptionLabel.text = dataModel.description
        conditionLabel.text = dataModel.conditions
    }
}
