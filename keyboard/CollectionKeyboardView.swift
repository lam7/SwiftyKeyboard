//
//  EmojiKeyboardView.swift
//  keyboard
//
//  Created by main on 2019/02/11.
//  Copyright © 2019 lam7. All rights reserved.
//

import Foundation
import UIKit

class UILabelCollectionViewCell: UICollectionViewCell{
    weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp(){
        let label = UILabel(frame: bounds)
        addSubview(label)
        self.label = label
        label.textAlignment = .center
    }
}

class CollectionKeyboardView: UINibView{
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UILabelCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var backButton: UIButton!
    var didTap: ((_ text: String)->())?
    
    var words: [[String]] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    @IBAction func touchUpBack(_ sender: Any) {
        self.removeFromSuperview()
    }
}


extension CollectionKeyboardView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UILabelCollectionViewCell
        let word = words[indexPath.section][indexPath.row]
        cell.label.text = word
        cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.6018695415)
        cell.label.font = UIFont.systemFont(ofSize: 18)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTap?(words[indexPath.section][indexPath.row])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return words.count
    }
}

extension CollectionKeyboardView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 35, height: 35)
    }
}
