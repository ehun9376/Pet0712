//
//  BottomBar.swift
//  Pet
//
//  Created by 陳逸煌 on 2022/7/15.
//

import Foundation
import UIKit

protocol BottomBarViewModel {
    var buttonsModels: [BaseButtonModel] { get set }
}

protocol BottomBarViewBinding {
    func setupBottomBarView(viewModel: BottomBarViewModel )
}

class StackBottomBarViewModel: BottomBarViewModel {
    
    var backgroundColor: UIColor = .white
    
    var buttonsModels: [BaseButtonModel] = []
    
    init(
        backgroundColor: UIColor = .white,
        buttonsModels: [BaseButtonModel] = []
    ){
        self.backgroundColor = backgroundColor
        self.buttonsModels = buttonsModels
    }
}

class StackBottomBarView: UIView {
    
    let stackView = UIStackView()
    
    var stackViewModel: StackBottomBarViewModel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
        self.setupStackView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupStackView()
    }
    
    func setupStackView() {
        self.stackView.axis = .horizontal
        self.stackView.distribution = .fillProportionally
        self.stackView.alignment = .center
        self.stackView.spacing = 20
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.1
        
        
        self.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 33).isActive = true
        stackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -33.0).isActive = true
        
    }
    
}

extension StackBottomBarView: BottomBarViewBinding {
    func setupBottomBarView(viewModel: BottomBarViewModel) {
        guard let viewModel = viewModel as? StackBottomBarViewModel else { return }
        
        self.stackViewModel = viewModel
        
        self.backgroundColor = viewModel.backgroundColor
        
        let totalButtons = viewModel.buttonsModels.count
        let spacing: CGFloat = 20
        let availableWidth = UIScreen.main.bounds.width - CGFloat(totalButtons - 1) * spacing - 66
        let minWidth = min(availableWidth / CGFloat(totalButtons), CGFloat(140))
        
        for model in viewModel.buttonsModels {
            let button = BottomBarButton()
            button.setupButtonView(model: model)
            stackView.addArrangedSubview(button)
            button.widthAnchor.constraint(equalToConstant: minWidth).isActive = true
            
        }
    }
}
