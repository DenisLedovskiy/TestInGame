//
//  ViewController.swift
//  TestInGame
//
//  Created by Денис Ледовский on 29.03.2022.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {

    var selected = [String]()
    var titles = [String]()
    private var tapScreen: UIGestureRecognizer!
    private var keyboardHeight = 0


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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        registerForKeyboardNotification()

        self.view.addSubview(collectionView)
        self.view.addSubview(textField)
        configureTextField()
        configureCollectionView()
        setLayoutCollectionView()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifire)
        self.textField.delegate = self

        self.tapScreen = UITapGestureRecognizer(target: self, action: #selector(tapFunc))
        self.tapScreen.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapScreen)

        requestData()

    }

    deinit {
        removeKeyboardNotification()
    }

    func registerForKeyboardNotification() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {

        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {

            let keyboardHeight = keyboardFrame.cgRectValue.height
            let fullHeight = keyboardHeight + textField.frame.height

            textField.snp.removeConstraints()
            textField.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview().inset(keyboardHeight)
            }

            collectionView.snp.removeConstraints()
            collectionView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(20)
                make.bottom.equalToSuperview().inset(fullHeight)
                make.left.equalToSuperview()
                make.right.equalToSuperview().inset(2)
            }
        }
    }

    @objc func keyboardWillHide() {

    }

    @objc func tapFunc() {
        self.view.endEditing(true)
    }

    func configureCollectionView() {

        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
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

    func requestData() {

        let urlDrinks = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"

        AF.request(urlDrinks).responseData { data in
            guard let data = data.value else { return }

            do {
                let response = try JSONDecoder().decode(DrinksResponse.self, from: data)
                let drinks = response.drinks
                DispatchQueue.main.async {
                    self.fillTitlesArray(drinks)
                    self.collectionView.reloadData()
                }
            } catch (let error) {
                print (error)
            }
        }
    }

    func fillTitlesArray(_ titlesDinks: [Drinks]) {
        let titlesDrinksCount = titlesDinks.count

        for i in 0...titlesDrinksCount - 1 {
            let title = titlesDinks[i].strDrink
            titles.append(title)
        }
    }
}

