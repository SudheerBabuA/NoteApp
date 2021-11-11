//
//  Action.swift
//  NoteApp
//
//  Created by Avudari Sudheer Babu on 29/09/21.
//

import UIKit

class Action: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showActionSheet()  {
        let actionSheet = UIAlertController(title: "title", message: "Do you want to delete", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
            print("done")
        }))
    }
}
