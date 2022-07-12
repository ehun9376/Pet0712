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
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let _sender = sender as? UIButton else { return }
        print(_sender.tag)
        if let vc = segue.destination as? PetTableViewController {
            vc.petType = _sender.tag == 0 ? .dog : .cat
        }
    }

}

