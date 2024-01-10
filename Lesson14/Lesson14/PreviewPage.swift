//
//  PreviewPage.swift
//  Lesson14
//
//  Created by Михаил Парсуков on 10.01.2024.
//

import UIKit

private let reuseIdentifier = "ArtCover"

class PreviewPage: UICollectionViewController {

    let imageNameArray = ["Alberto Ruiz - 7 Elements (Original Mix)",
                              "Dave Wincent - Red Eye (Original Mix)",
                              "E-Spectro - End Station (Original Mix)",
                              "Edna Ann - Phasma (Konstantin Yoodza Remix)",
                              "Ilija Djokovic - Delusion (Original Mix)",
                              "John Baptiste - Mycelium (Original Mix)",
                              "Lane 8 - Fingerprint (Original Mix)",
                              "Mac Vaughn - Pink Is My Favorite Color (Alex Stein Remix)",
                              "Metodi Hristov, Gallya - Badmash (Original Mix)",
                              "Veerus, Maxie Devine - Nightmare (Original Mix)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // не нужна, тк у нас свой класс ячейки
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        collectionView.allowsMultipleSelection = false
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowDetail" {
            if let indexPath = self.collectionView.indexPathsForSelectedItems?[0] {
                let detailView = segue.destination as! DetailViewController
                detailView.trackTitle = imageNameArray[indexPath.row]
            }
        }
    }

    // MARK: UICollectionViewDataSource

    /*override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageNameArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArtCoverCell
    
        // Configure the cell
        cell.coverImageView.image = UIImage(named: imageNameArray[indexPath.row])
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
