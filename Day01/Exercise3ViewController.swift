//
//  Exercise3ViewController.swift
//  Day01
//
//  Created by Developer on 12/23/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class Exercise3ViewController: UIViewController {
    @IBOutlet weak var expressionLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet var calculatorButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        for button in calculatorButtons {
            button.addTarget(self, action: #selector(touchedButton), for: .touchUpInside)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func touchedButton() {
        
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
