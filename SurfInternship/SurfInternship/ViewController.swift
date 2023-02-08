//
//  ViewController.swift
//  SurfInternship
//
//  Created by Людмила Долонтаева on 2/8/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage(named: "backgroundImage")
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(imageView, at: 0)
    }
}



