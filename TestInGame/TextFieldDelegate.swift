//
//  TextFieldDelegate.swift
//  TestInGame
//
//  Created by Денис Ледовский on 31.03.2022.
//

import UIKit
import SnapKit

// MARK: При вводе слова, если оно встречается в одном из тегов, то окрашиваем данный тег

extension MainView: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text
        if titles.contains(text!) {
            selected.append(text!)
            self.collectionView.reloadData()
        }
    }
}
