//
//  DetailViewController.swift
//  SkyMemoApp
//
//  Created by 이유진 on 2021/09/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var skyCollectionView: UICollectionView!
    
    @IBOutlet weak var memoLabel: UILabel!

    @IBOutlet weak var pageControl: UIPageControl!
    //이미지 배열
    let imgArray: Array<UIImage> = [UIImage(named: "SampleSky1.png")!,UIImage(named: "SampleSky2.png")!,UIImage(named: "SampleSky3.png")!]
    //메모 배열
    let memoArray: [String] = ["오늘하늘 너무 이쁘다 >_<","구름 안뇽","알바 끝나고 가는길"]

    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skyCollectionView.delegate = self
        skyCollectionView.dataSource = self

        memoLabel.text = memoArray[0]
        
        pageControl.numberOfPages = 3
        
    }
    
}

extension DetailViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)->Int{
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = skyCollectionView.dequeueReusableCell(withReuseIdentifier: "SkyImageCell", for: indexPath) as! SkyImageCell
        cell.skyImgView.image = imgArray[indexPath.row]
        cell.skyImgView.layer.masksToBounds = true
        cell.skyImgView.layer.cornerRadius = cell.skyImgView.frame.width/2
        cell.skyImgView.clipsToBounds = true
        cell.skyImgView.layer.borderColor = CGColor(red: 191.0/255, green: 232.0/255, blue: 255.0/255, alpha: 1.0)
        cell.skyImgView.layer.borderWidth = 5


        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        return CGSize(width: skyCollectionView.frame.size.width , height: skyCollectionView.frame.width)
    }
    
    
    

}

//스크롤 됐을 때 페이지컨트롤 변경되고 글씨 변경
extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let width = scrollView.bounds.size.width
        let x = scrollView.contentOffset.x + (width / 2.0)
        
        let newPage = Int(x/width)
        if pageControl.currentPage != newPage {
            pageControl.currentPage = newPage
        }
        
        memoLabel.text = memoArray[newPage]
    }
}



