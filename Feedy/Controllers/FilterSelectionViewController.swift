//
//  FilterSelectionViewController.swift
//  Feedy
//
//  Created by jack Maarek on 03/04/2019.
//  Copyright © 2019 jack Maarek. All rights reserved.
//

import UIKit

class FilterSelectionViewController: UIViewController {
    var stringPassed: String?

    func sendParameterToview(stringPassed:String )->Void{
        let myVC = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        navigationController?.pushViewController(myVC, animated: true)
        ViewController.stringPassed = stringPassed
        present(myVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func HallalChoice(_ sender: Any) {
        sendParameterToview(stringPassed: "Hallal")
    }
    
    
    @IBAction func FreeGlutenChoice(_ sender: Any) {
        sendParameterToview(stringPassed: "Free Gluten")
    }
    
    @IBAction func VegetarianChoice(_ sender: Any) {
        sendParameterToview(stringPassed: "Vegetarian")
    }
    
    @IBAction func KosherChoice(_ sender: Any) {
        sendParameterToview(stringPassed: "Kosher")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
