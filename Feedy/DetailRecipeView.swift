//
//  DetailRecipeView.swift
//  Feedy
//
//  Created by jack Maarek on 04/04/2019.
//  Copyright © 2019 jack Maarek. All rights reserved.
//

import UIKit

class DetailRecipeView: UIViewController {
    
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var exitButton: UIButton!
    
    var stringPassed = ""
    var imagePassed : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(stringPassed)
        recipeName.text = stringPassed
        recipeImage.image = imagePassed
        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnButton(_ sender: UIButton) {
        let previousVC = storyboard?.instantiateViewController(withIdentifier: "MyRecipes") as! RecipeViewController
    navigationController?.pushViewController(previousVC, animated: true)
        present(previousVC, animated: true, completion: nil)
        
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
