//
//  Extension.swift
//  NoteApp
//
//  Created by Avudari Sudheer Babu on 18/10/21.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: Self.self)
    }
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
}
