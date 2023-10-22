//
//  ViewController+alertController.swift
//  Notifications
//
//  Created by mac on 22.10.2023.
//  Copyright © 2023 Heorhii. All rights reserved.
//

import UIKit

extension TableViewController {
    func presentAlertController(with notificationType: String) {
        let alert = UIAlertController(title: notificationType,
                                      message: "After 5 seconds " + notificationType + " will appear",
                                      preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
