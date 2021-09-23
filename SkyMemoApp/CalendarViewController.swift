//
//  CalendarViewController.swift
//  SkyMemoApp
//
//  Created by 이유진 on 2021/09/22.
//

import UIKit

class CalendarViewController: UIViewController {
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let selectedDate = Date()
    let totalSquares = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
    }
    
    private func setCellsView(){
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    @IBAction func prevMonth(_ sender: Any) {
        
    }
    
    @IBAction func nextMonth(_ sender: Any) {
    }
    
}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        cell.dayOfMonthLabel.text = totalSquares[indexPath]
    }
}
