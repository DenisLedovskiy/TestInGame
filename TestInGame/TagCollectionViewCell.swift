//
//  TagCollectionViewCell.swift
//  TestInGame
//
//  Created by Денис Ледовский on 29.03.2022.
//

import UIKit
import SnapKit

// MARK: Класс ячейки CollectionView

class TagCollectionViewCell: UICollectionViewCell {

    var tagLabel: UILabel = {
        let cellLabel = UILabel(frame: .zero)
        cellLabel.textColor = .white
        cellLabel.font = UIFont(name: "Arial", size: 16)
        return cellLabel
    }()

    override init(frame: CGRect) {
            super.init(frame: .zero)
            setupViewsCell()
            setupLayouts()
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewsCell() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = .lightGray
        contentView.addSubview(tagLabel)
    }

    private func setupLayouts() {
        tagLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }

    func configure(text: String) {
        tagLabel.text = text
    }
}

extension TagCollectionViewCell: ReusableView {
    static var identifire: String {
        return String(describing: self)
    }
}



