//
//  ddd.swift
//  SurfInternship
//
//  Created by Людмила Долонтаева on 2/8/23.
//

import Foundation
import UIKit

class PullUpViewController: UIViewController {
 


  private let scrollView = UIScrollView()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    scrollView.frame = self.view.bounds
    scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 1.5)
    scrollView.showsVerticalScrollIndicator = false
    self.view.addSubview(scrollView)
  }
}
