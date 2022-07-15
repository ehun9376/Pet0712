//
//  BottomBar.swift
//  Pet
//
//  Created by 陳逸煌 on 2022/7/15.
//

import Foundation
import UIKit

class StackBottomBarView: UIView {
    
    convenience init(bottomBarButtons: [BottomBarButton] = []) {
        let height: CGFloat = 70
        self.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - height, width: UIScreen.main.bounds.size.width, height: height))
        self.setupView(bottomBarButtons: bottomBarButtons)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }
    
    func setupView(bottomBarButtons: [BottomBarButton] = []) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.1
        
        let stackView = createStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        for button in bottomBarButtons {
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
            button.heightAnchor.constraint(equalToConstant: 45).isActive = true
            button.widthAnchor.constraint(equalToConstant: 140).isActive = true
        }
        
        
    }
    
    
}
