//
//  ViewController.swift
//  ScrollDemo
//
//  Created by Chandresh Kachariya on 10/04/21.
//

import UIKit

class ViewController: UIViewController {

    /**********UICollectionView**********************/
    @IBOutlet weak var largeCollecctionView: UICollectionView!
    @IBOutlet weak var smallCollectionView: UICollectionView!
    let reuseIdentifierImageCVCell = "ImageCVCell"
    let reuseIdentifierLargeCVCell = "LargeCVCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initSetup()
    }

    func initSetup() {
        
        largeCollecctionView.dataSource = self
        largeCollecctionView.delegate = self
        largeCollecctionView.register(UINib.init(nibName: reuseIdentifierLargeCVCell, bundle: nil), forCellWithReuseIdentifier: reuseIdentifierLargeCVCell)

        largeCollecctionView.reloadData()
        
        smallCollectionView.dataSource = self
        smallCollectionView.delegate = self
        smallCollectionView.register(UINib.init(nibName: reuseIdentifierImageCVCell, bundle: nil), forCellWithReuseIdentifier: reuseIdentifierImageCVCell)

        smallCollectionView.reloadData()
    }
}

// MARK: - UICollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == largeCollecctionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierLargeCVCell, for: indexPath) as! LargeCVCell

            cell.imgView.image = UIImage.init(named: String(indexPath.row) + "_bg")
            
            return cell
        }
        else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierImageCVCell, for: indexPath) as! ImageCVCell

            cell.imgView.image = UIImage.init(named: String(indexPath.row) + "_front")
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == largeCollecctionView {
            
            return CGSize(width: (self.largeCollecctionView.bounds.width), height: (self.largeCollecctionView.bounds.height))
        }else {
            
            return CGSize(width: (self.smallCollectionView.bounds.width), height: (self.smallCollectionView.bounds.height))

        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView == smallCollectionView {
            smallCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll")

        let visibleRect = smallCollectionView.convert(scrollView.bounds, to: smallCollectionView)

        largeCollecctionView.scrollRectToVisible(visibleRect, animated: true)
    }
    

}

