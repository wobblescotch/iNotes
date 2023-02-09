//
//  AddNoteViewController.swift
//  iNotes
//
//  Created by Aakash Kumar on 08/02/23.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    // MMARK: - Initialisation
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    var note: Note?
    var update = false
    
    
    // MARK: - UI Buttons
    @IBAction func deleteClick(_ sender: Any) {
        APIFunctions.functions.deleteNote(id: note!._id)
        // returns the screen back to the main screen
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveClick(_ sender: Any) {
        // creates a date string that we can pass in to the database
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = dateFormatter.string(from: Date())
        
        // if the user is updating, update the note rather than saving
        if update == true {
            APIFunctions.functions.updateNote(date: date, title: titleTextField.text!, note: bodyTextView.text, id: note!._id)
            self.navigationController?.popViewController(animated: true)
        } else if titleTextField.text != "" && bodyTextView.text != "" {
            APIFunctions.functions.addNote(date: date, title: titleTextField.text!, note: bodyTextView.text)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    // MARK: - LifeCycle Hooks
    override func viewWillAppear(_ animated: Bool) {
        // disables the delete button if the user is adding a note (can't delete something that doesn't exist)
        if update == false {
            self.deleteButton.isEnabled = false
            self.deleteButton.title = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Prepoulates the text field if the user is updating the note
        if update == true {
            titleTextField.text = note?.title
            bodyTextView.text = note?.note
        }
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
