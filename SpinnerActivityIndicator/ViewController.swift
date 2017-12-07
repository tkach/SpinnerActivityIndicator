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

    @IBAction func startSpinner(_ sender: Any) {
        spinnerActivity.startAnimating()
    }
    
    @IBAction func stopSpinner(_ sender: Any) {
        spinnerActivity.stopAnimating()
    }
}

