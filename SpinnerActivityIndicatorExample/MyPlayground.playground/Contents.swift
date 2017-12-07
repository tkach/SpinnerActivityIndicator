//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
//@testable import SpinnerActivityIndicator

var str = "Hello, playground"
let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
PlaygroundPage.current.liveView = vc
