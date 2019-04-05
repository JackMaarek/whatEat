//
//  ViewController.swift
//  Feedy
//
//  Created by jack Maarek on 02/04/2019.
//  Copyright © 2019 jack Maarek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
     static var stringPassed = ""
    
     var cell : RecipeCollectionViewCell? = nil
    //Create Item array
    var items = ["Tartiflette","Beuf Poke","3","4","5","6"]
    
    // Create image array
    var foodImages = ["R0","R1","R2","R4","R5","R6"]
    // if let foodImages = tonarray {..}
    
  
    @IBOutlet weak var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    let dragCellid = "knDraggableCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(knDraggableCell.self, forCellWithReuseIdentifier: dragCellid)
        
        collectionView.collectionViewLayout = self.layout
        self.layout.minimumInteritemSpacing = 0
         self.layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        print(ViewController.stringPassed)
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let dim = (self.view.bounds.width - 30) / 2
        self.layout.itemSize = CGSize(width: dim, height: dim)
        
    }
    
    @objc func refreshCollection() {
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FoodControllerCollectionViewCell
        cell.image.image = UIImage(named:foodImages[indexPath.row])
        cell.foodName.text = items[indexPath.row]
        print(cell)
        cell.image.isUserInteractionEnabled = false
        cell.delegate = self
         return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        //getting the current cell from the index path
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
 
}


extension ViewController: knDraggableViewDelegate {
    func cardSwipedLeft(_ card: UIView) {
        removeOnSwiping(card: card)
    }
    
    func removeOnSwiping(card: UIView) {
        let cells = collectionView.visibleCells
        var ind: Int?
    
        for i in 0 ..< cells.count {
            let cell = card as! FoodControllerCollectionViewCell
            if items[i] == cell.foodName.text! {
                ind = i
            }
        }
        //guard let index = cells.firstIndex(where: { return card == $0 }) else { return }
        guard let index = ind else { return }
        items.remove(at: index)
        foodImages.remove(at: index)
        collectionView.reloadData()
    }
    
    func cardSwipedRight(_ card: UIView) {
        removeOnSwiping(card: card)
    }
    
    
}
