//
//  Extensions+TabBar.swift
//  HW5-1
//
//  Created by zalkarbek on 23/5/23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    private func generateTabBar() {
        viewControllers = [
        generateVC(vc: ViewController(),
                       title: "Home",
                       image: UIImage(systemName: "house.fill")
                  ),
        generateVC(vc: SearchViewController(),
                   title: "Search",
                   image: UIImage(systemName: "heart.fill")
                  )
        ]
    }
    
    private func generateVC(vc: UIViewController, title: String, image: UIImage?) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }
}
