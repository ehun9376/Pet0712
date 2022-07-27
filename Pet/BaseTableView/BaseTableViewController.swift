//
//  ViewController.swift
//  Pet
//
//  Created by Kai on 2022/7/10.
//

import UIKit

class BaseTableViewController: UIViewController {
    
    var scrollView = UIScrollView()

    var defaultTableView = UITableView()
        
    var rowModels: [CellRowModel] = []
    
    var defaultBottomBarHeight: CGFloat = 80
    
    var adapter: TableViewAdapter?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDefaultTableView()
        self.setBottomBarView(buttons:self.setBottomButtons())
        self.adapter = .init(self.defaultTableView)
        self.regisCellID()
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

        self.defaultTableView.bounces = false
    }
    func regisCellID() {
        
        for id in self.setRegisID() {
            self.defaultTableView.register(UINib(nibName: id,
                                                 bundle: nil),
                                           forCellReuseIdentifier: id)
        }
    }
    
    ///Override this func to set CellIDs
    func setRegisID() -> [String] {
        return []
    }
    
    
    ///if need bottoBar override this func
    func setBottomButtons() -> [BottomBarButton] {
        return []
    }
    
    func setBottomBarView(buttons: [BottomBarButton]) {
        guard !buttons.isEmpty else { return }
        
        let stackBottomView = StackBottomBarView(bottomBarButtons: buttons)
        stackBottomView.backgroundColor = UIColor.white
        stackBottomView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackBottomView)
        stackBottomView.heightAnchor.constraint(equalToConstant: self.defaultBottomBarHeight).isActive = true
        stackBottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackBottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stackBottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

}

