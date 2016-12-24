//
//  ViewController.swift
//  Day01
//
//  Created by Developer on 12/22/16.
//  Copyright © 2016 Developer. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = UIColor.init(red: 0, green: 122/255, blue: 255/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tappedExercise1(_ sender: UIButton) {
        performSegue(withIdentifier: "InitialToExercise1", sender: nil)
    }
    @IBAction func tappedExercise2(_ sender: UIButton) {
        performSegue(withIdentifier: "InitialToExercise2", sender: nil)
    }
    @IBAction func tappedExercise3(_ sender: UIButton) {
        performSegue(withIdentifier: "InitialToExercise3", sender: nil)
    }
}

