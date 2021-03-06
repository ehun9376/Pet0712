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
        self.init(frame: .zero)
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
        stackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 33).isActive = true
        stackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -33.0).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        let totalButtons = bottomBarButtons.count
        let spacing: CGFloat = 20
        let availableWidth = UIScreen.main.bounds.width - CGFloat(totalButtons - 1) * spacing - 66
        let minWidth = min(availableWidth / CGFloat(totalButtons), CGFloat(140))
        
        for button in bottomBarButtons {
            
            stackView.addArrangedSubview(button)
//            button.heightAnchor.constraint(equalToConstant: 45).isActive = true
            button.widthAnchor.constraint(equalToConstant: minWidth).isActive = true
        }
        
        
    }
    
    
}
