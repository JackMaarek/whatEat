//
//  RecipeViewController.swift
//  Feedy
//
//  Created by jack Maarek on 03/04/2019.
//  Copyright © 2019 jack Maarek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class RecipeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    

    var cell : RecipeCollectionViewCell? = nil
    var recipeIsVisible = false
    
    //Create Item array
    var itemsZ = [String]()
    
    // Create image array
    var foodImagesZ = [String]()
    
    var items = ["Tartiflette","Beuf Poke","3","4","5","6"]
    
    // Create image array
    var foodImages = ["R0","R1","R2","R4","R5","R6"]
    // if let foodImages = tonarray {..}
    let ingrediantSelection = "chips"
    let apiUrl = "https://world.openfoodfacts.org/cgi/search.pl?search_terms=chips&search_simple=1&jqm=1" //Concat
    
    //var bottomConstraint:NSLayoutConstraint = NSLayoutConstraint()
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        recipeViewContainer.isHidden = true

        RecipesNetwork.getRecipes() {
            recipes, error in
            
            guard nil == error else {
                print(error!)
                return
            }
            
            if let recipes = recipes {
                for recipe in recipes {
                    self.items.append(recipe.name!)
                    self.foodImages.append(recipe.image!)
                }
            }
        }
        
//        Alamofire.request(apiUrl, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)") //Add JSon response to subArray
//            case .failure(let error):
//                print(error)
//            }
//        }
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as? RecipeCollectionViewCell
        
        
        cell!.foodName.text = items[indexPath.item]
        cell!.image.image = UIImage(named:foodImages[indexPath.row])
        cell!.image.isUserInteractionEnabled = false
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let touchedCell = collectionView.cellForItem(at: indexPath) as? RecipeCollectionViewCell {
            print(touchedCell.foodName.text)
            print(touchedCell.image.image)
            
        }
        //configureRecipeView()
//        recipeViewChange()
        
        guard let cell = self.cell else {
            print("cell does not exist")
            return
        }
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "RecipeInformation") as! DetailRecipeView
        myVC.stringPassed = cell.foodName.text!
        myVC.imagePassed = cell.image.image!
        navigationController?.pushViewController(myVC, animated: true)
        present(myVC, animated: true, completion: nil)
        
    }
  
    
//    var recipeDetail = UIView()
//    func configureRecipeView() {
//        // The total number of pages that are available is based on how many available colors we have.
//        recipeDetail = UIView(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
//        self.view.addSubview(recipeDetail)
//
//         bottomConstraint = NSLayoutConstraint(item: recipeDetail, attribute: NSLayoutConstraint.Attribute.notAnAttribute, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: -500)
//
//        UIView.animate(withDuration: 0.25) {
//            self.bottomConstraint.constant = -(self.recipeDetail.bounds.origin.x + 200)
//            self.view.layoutIfNeeded()
//        }
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


//    func recipeViewChange() {
//        if recipeIsVisible {
//            UIView.animate(withDuration: 0.25) {
//                self.bottomConstraints.constant = -(self.recipeViewContainer.frame.height + 400)
//                self.view.layoutIfNeeded()
//                self.recipeViewContainer.isHidden = true
//            }
//            recipeIsVisible = false
//        } else {
//            UIView.animate(withDuration: 0.25) {
//                self.bottomConstraints.constant = 400
//                self.view.layoutIfNeeded()
//                self.recipeViewContainer.isHidden = false
//            }
//            recipeIsVisible = true
//        }
//
//        if(recipeViewContainer.isHidden == true){
//            recipeViewContainer.isHidden = false
//        }else if(recipeViewContainer.isHidden == false){
//            recipeViewContainer.isHidden = true
//        }
//    }
}
