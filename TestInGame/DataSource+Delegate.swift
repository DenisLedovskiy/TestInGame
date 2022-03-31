//
//  CollectionViewDataSource+Delegate.swift
//  TestInGame
//
//  Created by Денис Ледовский on 31.03.2022.
//

import UIKit

extension ViewController:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: Функция на градиент
    func gradient(frame: CGRect) -> CAGradientLayer {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.purple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        return gradientLayer
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 30)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifire,
                                                            for: indexPath) as? TagCollectionViewCell else {
            return TagCollectionViewCell()
        }
        cell.configure(text: titles[indexPath.row])
        cell.tagLabel.preferredMaxLayoutWidth = collectionView.frame.width - 16

// MARK: Здесь происходит окрашивание. Если просмто менять фон, то все работает четко. А вот градиент чудит.

        if selected.contains(titles[indexPath.row]) {
//            cell.layer.insertSublayer(gradient(frame: cell.bounds), at: 0)
            cell.backgroundColor = UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 1)
        } else {
            cell.layer.removeAllAnimations()
            cell.backgroundColor = .lightGray
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell,
              let text = cell.tagLabel.text else {return}

        if selected.contains(text) {
            selected = selected.filter{$0 != text}
        } else {
            selected.append(text)
        }
        collectionView.reloadData()
    }
}
