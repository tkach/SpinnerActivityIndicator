//
//  ViewController.swift
//  SpinnerActivityIndicator
//
//  Created by Alexander Tkachenko on 8/22/17.
//  Copyright © 2017 megogo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spinnerActivity: SpinnerActivityIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startSpinner(_ sender: Any) {
        spinnerActivity.startAnimating()
    }
    
    @IBAction func stopSpinner(_ sender: Any) {
        spinnerActivity.stopAnimating()
    }
    
}

