//
//  Exercise2ViewController.swift
//  Day01
//
//  Created by Developer on 12/23/16.
//  Copyright © 2016 Developer. All rights reserved.
//
import Utils
import UIKit

class Exercise2ViewController: UIViewController {
    @IBOutlet weak var numberLabel: CustomUIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedPress(_ sender: UIButton) {
        let number = arc4random_uniform(1000)
        numberLabel.setTitle("\(number)", for: .normal)
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
