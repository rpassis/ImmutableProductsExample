//
//  Storyboard.swift
//  CoreDataRx
//
//  Created by Rogerio de Paula Assis on 1/12/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable {
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UIViewController: StoryboardIdentifiable {}
extension UITableViewCell: StoryboardIdentifiable {}

enum Storyboard: String {

    // swiftlint:disable identifier_name
    case Main

    func instantiate<VC: UIViewController>(
        _ viewController: VC.Type,
        inBundle bundle: Bundle = Bundle.main)
        -> VC {
            let identifier = viewController.storyboardIdentifier
            let sb = UIStoryboard(name: self.rawValue, bundle: bundle)
            guard let vc = sb.instantiateViewController(withIdentifier: identifier) as? VC else {
                fatalError("Unable to instantiate VC with identifier \(identifier)")
            }
            return vc
    }
}
