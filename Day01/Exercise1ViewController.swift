//
//  Exercise1ViewController.swift
//  Day01
//
//  Created by Developer on 12/23/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class Exercise1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedButton(_ sender: UIButton) {
        guard let text = sender.currentTitle else { return }
        if let number = Int(text) {
            sender.setTitle("\(number + 1)", for: .normal)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
