//
//  TextFieldDelegate.swift
//  TestInGame
//
//  Created by Денис Ледовский on 31.03.2022.
//

import UIKit
import SnapKit

extension ViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {

        self.textField.layer.cornerRadius = 0
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        textField.layer.cornerRadius = 10
        textField.snp.removeConstraints()
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(700)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 30))
        }
        self.collectionView.snp.removeConstraints()
        configureCollectionView()
}

    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text
        if titles.contains(text!) {
            selected.append(text!)
            self.collectionView.reloadData()
        }
    }
}
