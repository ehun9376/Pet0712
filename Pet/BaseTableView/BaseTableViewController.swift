//
//  ViewController.swift
//  Pet
//
//  Created by Kai on 2022/7/10.
//

import UIKit

class BaseTableViewController: UIViewController {
    
    var defaultTableView = UITableView()
    
    var stackBottomView: StackBottomBarView?
        
    var rowModels: [CellRowModel] = []
    
    var defaultBottomBarHeight: CGFloat = 80
    
    var adapter: TableViewAdapter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDefaultTableView()
        self.setBottomBarView(bottomBarViewModel: self.createBottomBarViewModel())
        self.adapter = .init(self.defaultTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setDefaultApp()
    }
    
    func setDefaultApp(){
        if #available(iOS 13.0, *) {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = .white
            barAppearance.shadowColor = .clear
            navigationItem.standardAppearance = barAppearance
            navigationItem.scrollEdgeAppearance = barAppearance
        }

        if #available(iOS 15.0, *){
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
    }
    
    func setupDefaultTableView() {
        self.defaultTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.defaultTableView)
        self.defaultTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.defaultTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.defaultTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.defaultTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant:  -self.defaultBottomBarHeight).isActive = true
    }
    

    
    ///call this func to set CellIDs
    func setRegisID<cellTypes>(cellIDs: cellTypes) {
        
        if let ids = cellIDs as? [String] {
            for id in ids {
                self.defaultTableView.register(UINib(nibName: id,
                                                     bundle: nil),
                                               forCellReuseIdentifier: id)
            }
        }
        
        if let cells = cellIDs as? [UITableViewCell.Type] {
            for cell in cells {
                self.defaultTableView.register(cell, forCellReuseIdentifier: "\(cell.self)")
            }
        }
        
    }
    
    
    func createBottomBarViewModel() -> BottomBarViewModel {
        let bottomBarViewModel = StackBottomBarViewModel()
        return bottomBarViewModel
    }
    
    func setBottomBarView(bottomBarViewModel: BottomBarViewModel) {
        
        for view in self.view.subviews {
            if let view = view as? StackBottomBarView{
                view.removeFromSuperview()
            }
        }
        
        guard !bottomBarViewModel.buttonsModels.isEmpty else { return }
        
        self.stackBottomView = .init()
        
        stackBottomView?.setupBottomBarView(viewModel: bottomBarViewModel)
        
        self.view.addSubview(stackBottomView ?? UIView())
        stackBottomView?.heightAnchor.constraint(equalToConstant: self.defaultBottomBarHeight).isActive = true
        stackBottomView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackBottomView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stackBottomView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

}

