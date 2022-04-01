//
//  ViewController.swift
//  TestInGame
//
//  Created by Денис Ледовский on 29.03.2022.
//

import UIKit
import Alamofire
import SnapKit

class MainViewController: UIViewController {

    //MARK: MaineView

    var mainView: MainView { return self.view as! MainView }

    override func loadView() {
        self.view = MainView(frame: UIScreen.main.bounds)
    }

    private var tapScreen: UIGestureRecognizer!
    private var keyboardHeight = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        registerForKeyboardNotification()
        setTapGestureRecognizer()
        requestData()
    }

    //MARK: Установка TapGestureRecognizer

    func setTapGestureRecognizer() {
        self.tapScreen = UITapGestureRecognizer(target: self, action: #selector(tapFunc))
        self.tapScreen.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapScreen)
    }

    @objc func tapFunc() {
        self.view.endEditing(true)
    }

    //MARK: Добавление наблюдателей за клавиатурой, методы клавиатуры.

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
            let fullHeight = keyboardHeight + self.mainView.textField.frame.height

            self.mainView.textField.layer.cornerRadius = 0
            self.mainView.textField.snp.removeConstraints()
            self.mainView.textField.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview().inset(keyboardHeight)
            }

            self.mainView.collectionView.snp.removeConstraints()
            self.mainView.collectionView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(35)
                make.bottom.equalToSuperview().inset(fullHeight)
                make.left.equalToSuperview()
                make.right.equalToSuperview().inset(2)
            }
        }
    }

    @objc func keyboardWillHide() {
        
        self.mainView.textField.layer.cornerRadius = 10
        self.mainView.textField.snp.removeConstraints()
        self.mainView.configureTextField()
        self.mainView.collectionView.snp.removeConstraints()
        self.mainView.configureCollectionView()
    }

    //MARK: Запрос данных из сети, декодинг и добавление в CollectionView.
    // Т.к. запрос простой не стал выносить это в отдельный сервис работы с сетью.

    func requestData() {
        let urlDrinks = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"

        AF.request(urlDrinks).responseData { data in
            guard let data = data.value else { return }

            do {
                let response = try JSONDecoder().decode(DrinksResponse.self, from: data)
                let drinks = response.drinks
                DispatchQueue.main.async {
                    self.fillTitlesArray(drinks)
                    self.mainView.collectionView.reloadData()
                }
            } catch (let error) {
                print (error)
            }
        }
    }

    //MARK: Метод для добавление полученных названий напитков из сети в отдельный массив.

    func fillTitlesArray(_ titlesDinks: [Drinks]) {
        let titlesDrinksCount = titlesDinks.count

        for i in 0...titlesDrinksCount - 1 {
            let title = titlesDinks[i].strDrink
            self.mainView.titles.append(title)
        }
    }
}

