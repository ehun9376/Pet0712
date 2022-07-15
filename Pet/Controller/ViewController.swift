//
//  ViewController.swift
//  Pet
//
//  Created by Kai on 2022/7/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBottomBarView()
    }
    
    func setBottomBarView() {
        let height: CGFloat = 80
        
        let searchButton: BottomBarButton = .search(action: {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PetTableViewController") {
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })

        
        let stackBottomView = StackBottomBarView(bottomBarButtons: [searchButton])
        stackBottomView.backgroundColor = UIColor.white
        stackBottomView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackBottomView)
        stackBottomView.heightAnchor.constraint(equalToConstant: height).isActive = true
        stackBottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackBottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stackBottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

}

