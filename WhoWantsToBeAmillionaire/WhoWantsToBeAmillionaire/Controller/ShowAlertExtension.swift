//
//  ShowAlertExtension.swift
//  WhoWantsToBeAmillionaire
//
//  Created by Alexey on 20.02.2021.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertContoller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: actionHandler)
        alertContoller.addAction(action)
        present(alertContoller, animated: true, completion: nil)
    }
}
