//
//  MainView.swift
//  TestInGame
//
//  Created by Денис Ледовский on 01.04.2022.
//

import UIKit

final class MainView: UIView {

    var selected = [String]()
    var titles = [String]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
        setupDelegates()
        configureTextField()
        configureCollectionView()
        setLayoutCollectionView()
       
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Описание вьюшек

    let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()

    var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.backgroundColor = .white
        textField.textColor = UIColor.black
        textField.layer.cornerRadius = 10
        textField.placeholder = "Coctail name"
        textField.layer.shadowOpacity = 0.2
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 3
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.masksToBounds = false
        textField.textAlignment = .center
        return textField
    }()

    //MARK: Функции добавления вьюшек, натсройка констрейтов

    private func setupViews() {
        self.addSubview(collectionView)
        self.addSubview(textField)
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifire)
    }

    private func setupDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
        textField.delegate = self
    }

    func configureCollectionView() {

        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview().inset(2)
        }
    }

    func setLayoutCollectionView() {

        let layout = TagFlowLayout()
        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        collectionView.collectionViewLayout = layout
    }

    func configureTextField() {

        self.textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(700)
            make.size.equalTo(CGSize(width: 300, height: 30))
        }
    }



}
