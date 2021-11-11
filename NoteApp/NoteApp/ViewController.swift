//
//  ViewController.swift
//  NoteApp
//
//  Created by Avudari Sudheer Babu on 25/09/21.
//

import UIKit
import  UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Mark: - Initializations
    
    @IBOutlet weak var notesTableView: UITableView!
    var notesArray = [Note]()
    
    //Mark: - Segue Data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNoteViewController
        // passes the note and tells the view controller to update instead of add
        if segue.identifier == "updateNoteSegue" {
            vc.note = notesArray[notesTableView.indexPathForSelectedRow!.row]
            vc.update = true
        }
    }
    
    
    //Mark: - LifeCycle Hooks
    override func viewWillAppear(_ animated: Bool) {
        // Update the notes array
        APIFunctions.functions.FetchNotes()
    }
    override func viewDidAppear(_ animated: Bool) {
        // Update the notes array
        APIFunctions.functions.FetchNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIFunctions.functions.delegate = self
        APIFunctions.functions.FetchNotes()
        print(notesArray)
        notesTableView.delegate = self
        notesTableView.dataSource = self
        
    }
    
    //Marks: - TableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! NotePrototypeCell
        // Customizes Cell to set date,note & title
        cell.title.text = notesArray[indexPath.row].title
        cell.note.text = notesArray[indexPath.row].note
        cell.date.text = notesArray[indexPath.row].date

        return cell
    }
    func showActionSheet()  {
        let actionSheet = UIAlertController(title: "title", message: "Do you want to delete", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
            print("done")
        }))
    }
    @objc func switchChanged(_ sender: UISwitch)
    {
        if (sender.isOn == true){


        }
        print("\(sender.isOn ? "On" : "Off")")
    }
}

//Mark : - Custom Delegates
protocol DataDelegate {
    func updateArray(newArray: String)
    
}
extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        do{
            notesArray = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
            print(notesArray)
        } catch {
            print("Failed to Decode")
        }
        self.notesTableView?.reloadData()
    }
}

