//
//  MainCollectionViewController.swift
//  bunjang_ios_day
//
//  Created by 안다영 on 2022/08/23.
//

import UIKit

class MainCollectionViewController: UIViewController {
    
    var page = 1
    
    @IBAction func tapBarButton(_ sender: UIBarButtonItem) {
        
        print("🚧전체메뉴 누름")
        let storyboard = UIStoryboard(name: "AllMenus", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AllMenusViewController") as! AllMenusViewController
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setCollectionView()
    }
    
    private func setData(){
        HomeFeedDataManager().getHomeFeedData(page: page, delegate: self)
    }
    
    private func setCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(UINib(nibName: "Section1CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Section1CollectionViewCell")
        collectionView.register(UINib(nibName: "Section2CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Section2CollectionViewCell")
        collectionView.register(UINib(nibName: "Section3CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Section3CollectionViewCell")
        collectionView.register(UINib(nibName: "Section4CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Section4CollectionViewCell")
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
    }
    
}
extension MainCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
            
        case 1:
            return 20
            
        default:
            return 5
            
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            switch indexPath.row {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Section1CollectionViewCell", for: indexPath) as! Section1CollectionViewCell
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Section2CollectionViewCell", for: indexPath) as! Section2CollectionViewCell
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Section3CollectionViewCell", for: indexPath) as! Section3CollectionViewCell
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Section4CollectionViewCell", for: indexPath) as! Section4CollectionViewCell
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Section1CollectionViewCell", for: indexPath) as! Section1CollectionViewCell
                return cell
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
                return cell
            }
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Section1CollectionViewCell", for: indexPath) as! Section1CollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section{
        case 1:
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return CGSize(width: width, height: width * 0.8)
            case 1:
                return CGSize(width: width, height: 162)
            case 2:
                return CGSize(width: width, height: 70)
            case 3:
                return CGSize(width: width, height: 55)
            default:
                return CGSize(width: width / 2, height: 80)
            }
        case 1:
            let width2 = (collectionView.frame.width - 50) / 2
            let height = width * 0.85
            let size = CGSize(width: width2, height: height)
            return size
        default:
            return CGSize(width: width / 2, height: 80)
        }
    }
}
