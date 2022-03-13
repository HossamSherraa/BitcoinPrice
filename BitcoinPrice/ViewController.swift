//
//  ViewController.swift
//  BitcoinPrice
//
//  Created by Hossam on 16/05/2021.
//

import UIKit
class ViewController : UIViewController {
    override func loadView() {
        self.view = ChartPathView()
    }
}
