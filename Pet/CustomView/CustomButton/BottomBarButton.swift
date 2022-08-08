//
//  BottomBarButton.swift
//  Pet
//
//  Created by 陳逸煌 on 2022/7/15.
//

import Foundation
import UIKit

protocol BaseButtonModel {
    var title: String? { get set }
    var buttonTouchUpInsideAction: (()->())? { get set }
}

protocol ButtonModelBinding {
    func setupButtonView(model: BaseButtonModel )
}

class BottomBarButtonModel: BaseButtonModel{
    
    enum BottomBarStyle {
        case red
        case white
        case none
    }
    
    class BottomBarButtonisEnabledStyle {
        var backgroundColor: UIColor?
        var titleColor: UIColor?
    }
    
    var title: String? = ""
    
    var buttonTouchUpInsideAction: (() -> ())?
    
    var style: BottomBarStyle = .none
    
    var canClick: Bool = true
    
    var button: ButtonModelBinding?
    
    init(
        title: String? = "",
        style: BottomBarStyle,
        canClick: Bool = true,
        buttonTouchUpInsideAction: (()->())?
    ){
        self.title = title
        self.style = style
        self.canClick = canClick
        self.buttonTouchUpInsideAction = buttonTouchUpInsideAction
    }
    
    static func search(style: BottomBarStyle = .none,action: (()->())? = nil) -> BottomBarButtonModel {
        let buttonModel = BottomBarButtonModel(title: "搜尋", style: style, buttonTouchUpInsideAction: action)
        return buttonModel
    }
    
    static func confirm(style: BottomBarStyle = .none,action: (()->())? = nil) -> BottomBarButtonModel {
        let buttonModel = BottomBarButtonModel(title: "確定", style: style, buttonTouchUpInsideAction: action)
        return buttonModel
    }
    func updateView(){
        if let button = button {
            button.setupButtonView(model: self)
        }
    }
    
}


class BottomBarButton: UIButton {
    
    var buttonModel: BottomBarButtonModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func touchUpInsideAction() {
        guard let buttonAction = buttonModel?.buttonTouchUpInsideAction else {
            return
        }
        buttonAction()
    }
        
}
extension BottomBarButton: ButtonModelBinding {
    func setupButtonView(model: BaseButtonModel) {
        guard let model = model as? BottomBarButtonModel else { return }
        self.buttonModel = model
        self.setTitle(model.title, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(touchUpInsideAction), for: .touchUpInside)
        
        switch model.style {
            
        case .red:
            break
        case .white:
            self.setTitleColor(UIColor.white, for: .normal)
            self.backgroundColor = model.canClick ? UIColor.red : .gray
            self.isEnabled = model.canClick
            self.translatesAutoresizingMaskIntoConstraints = false
            self.clipsToBounds = true
            self.layer.cornerRadius = 9
        case .none:
            break
        }
    }
}
