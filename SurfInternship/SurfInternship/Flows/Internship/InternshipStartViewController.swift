//
//  ViewController.swift
//  SurfInternship
//
//  Created by Людмила Долонтаева on 2/8/23.
//
import PullUpController
import UIKit

class InternshipStartViewController: UIViewController{
    
    private let internshipVC = InternshipViewController()
    private let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyle()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        guard children.isEmpty else { return }
        addPullUpController()
        setUpLayouts()
        
    }
    
    private func setUpLayouts() {
        view.insertSubview(imageView, at: 0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50).isActive = true
        imageView.bottomAnchor.constraint(equalTo: internshipVC.view.topAnchor, constant: 50).isActive = true
    }
    
    private func setUpStyle() {
        
        imageView.image = UIImage(named: "backgroundImage")
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
    }
    
    private func addPullUpController() {
        
        addPullUpController(internshipVC, initialStickyPointOffset: 500, animated: false)
        internshipVC.view.setNeedsLayout()
        internshipVC.view.layoutIfNeeded()
        internshipVC.pullUpControllerMoveToVisiblePoint( internshipVC.lowestPoint, animated: false, completion: nil)
        internshipVC.view.setNeedsLayout()
    }
    
}


