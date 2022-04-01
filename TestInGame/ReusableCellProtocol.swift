//
//  ReusableCellProtocol.swift
//  TestInGame
//
//  Created by Денис Ледовский on 01.04.2022.
//

import Foundation

//MARK: Протокол для удобноого написания идентификаторов

protocol ReusableView: AnyObject {
    static var identifire: String {get}
}
