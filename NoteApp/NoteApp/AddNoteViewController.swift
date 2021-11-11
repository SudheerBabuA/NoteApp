//
//  AddNoteViewController.swift
//  NoteApp
//
//  Created by Avudari Sudheer Babu on 26/09/21.
//

import UIKit
import UserNotifications

class AddNoteViewController: UIViewController {
    //    Mark: - Intialization
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deletButton: UIBarButtonItem!
    var note: Note?
    var update = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // prepopulate the text field if the user is updating a note
        
        if update == true {
            titleTextField.text = note!.title
            bodyTextField.text = note!.note
        }
    }
    
    //Mark: -  UI Buttons
    @IBAction func savecClick(_ sender: Any) {
        // Creates a date string thet we can pass in to the database
        
       let currenDateTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .long
  //    dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.string(from: currenDateTime)
        
       
        // if the user is updating, update the note rather than saving
        if update == true {
            showAlert()
            APIFunctions.functions.UpdateNote(title: titleTextField.text!, date: date, note: bodyTextField.text!, id: note!._id)
            
        } else if titleTextField.text != "" && bodyTextField.text != "" {
            
            APIFunctions.functions.AddNote(title: titleTextField.text!, date: date, note: bodyTextField.text!)
            saveAlert()
            
        }
    }
    
    @IBAction func deleteClick(_ sender: Any) {
        showActionSheet()
        
    }
    //Mark: - LifeCycle Hooks
    
    override func viewWillAppear(_ animated: Bool) {
        // disables the delete button if the user is adding a note(con't delete something that doesn't exist
        if update == false {
            self.deletButton.isEnabled = false
            
        }
    }
    
    // On deleting ActionSheet
    func showActionSheet()  {
        let actionSheet = UIAlertController(title: "Notes", message: "Do you want to delete", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { _ in self.navigationController?.popViewController(animated: true)}))
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [self] action in
            APIFunctions.functions.DeleteNote(id: self.note!._id)
            // returns the screen back to the main screen
            self.navigationController?.popViewController(animated: true)
        }))
        present(actionSheet, animated: true)
    }
    
    // On Updating alert
    func showAlert()  {
        let alert = UIAlertController(title: "Notes", message: "Updated Succesfully", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { [self] action in
            
            self.navigationController?.popViewController(animated: true)
            
        }))
        present(alert, animated: true)
    }
    
    // On Saving alert
    func saveAlert()  {
        let alert = UIAlertController(title: "Notes", message: "Saved Succesfully", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { [self] action in
            
            self.navigationController?.popViewController(animated: true)
            
        }))
        present(alert, animated: true)
    }
}
