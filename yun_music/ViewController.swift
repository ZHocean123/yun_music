//
//  ViewController.swift
//  yun_music
//
//  Created by yang on 13/11/2017.
//  Copyright © 2017 ocean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bar"), for: .any, barMetrics: .default)
        view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
