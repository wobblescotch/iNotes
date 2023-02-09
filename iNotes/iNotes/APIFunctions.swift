//
//  APIFunctions.swift
//  iNotes
//
//  Created by Aakash Kumar on 08/02/23.
//

import Foundation
import Alamofire

// MARK: - Customm Notes Struct

struct Note: Decodable {
    var title: String
    var date: String
    var _id: String
    var note: String
}

// MARK: - Functions that interact with API
class APIFunctions {
    
    // Sets our custom data delegate
    var delegate: DataDelegate?
    // creates an instance of the class so the other files can ninteract with it
    static let functions = APIFunctions()
    
    // fetches notes from database
    func fetchNotes() {
        AF.request("http://ipaddress/fetch").response { response in
            print(response.data)
            // converts the response into utf8 string format
            let data = String(data: response.data!, encoding: .utf8)
            // fires off the custom delegate in the view controller
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    // Adds a note to the server, passing the arguments as headers
    func addNote(date: String, title: String, note: String) {
        AF.request("http://ipaddress/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note]).responseJSON {
            response in
            print(response)
        }
    }
    
    // Updates a note to the server, passing the arguments as headers
    func updateNote(date: String, title: String, note: String, id: String) {
        AF.request("http://ipaddress/update", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note, "id": id]).responseJSON {
            response in
            print(response)
        }
    }
    
    // Deletes a note from the server, passing the notes id as headers
    func deleteNote(id: String) {
        AF.request("http://ipaddress/delete", method: .post, encoding: URLEncoding.httpBody, headers: ["id": id]).responseJSON {
            response in
            print(response)
        }
    }
    
}
