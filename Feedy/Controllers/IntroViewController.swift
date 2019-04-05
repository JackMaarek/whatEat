//
//  IntroViewController.swift
//  Feedy
//
//  Created by jack Maarek on 03/04/2019.
//  Copyright © 2019 jack Maarek. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToSelection(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "SetProfileInformation") as! FilterSelectionViewController
    navigationController?.pushViewController(myVC, animated: true)
        present(myVC, animated: true, completion: nil)
        
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
