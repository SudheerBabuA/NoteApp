//
//  APIFunctions.swift
//  NoteApp
//
//  Created by Avudari Sudheer Babu on 25/09/21.
//

import Foundation
import Alamofire

//Mark: - Custom notes Struct
struct Note: Decodable {
    var title:String
    var date:String
    var _id:String
    var note:String
    
    
}

//Mark: - functions that interact with API
class APIFunctions {
    
    // sets over custom data delegates
    var delegate: DataDelegate?
    //Create an instance of the class so the other files can ineract with it
    static let functions = APIFunctions()
    
    // Fetch notes from database
    func FetchNotes() {
        AF.request("http://192.168.0.176:8081/fetch").response {
            response in
            print(response.data!)
            //converts the response int utf8 string form
            let data = String(data: response.data!, encoding:  .utf8)
            //Fires off the custom delegate in the view controller
            self.delegate?.updateArray(newArray: data!)
        }
    }
    
    // Add a note to the server, passing the arguments as headers
    func AddNote(title:String, date:String, note:String) {
        AF.request("http://192.168.0.176:8081/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note]).responseJSON {
            response in
            print(response)
        }
    }
    
    // updates a note to the server, passing the arguments as header
    func UpdateNote(title:String, date:String, note:String, id:String){
        AF.request("http://192.168.0.176:8081/update", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note, "id": id]).responseJSON {
            response in
            print(response)
        }
        
    }
    
    // delete a note from the server,passing the notes id as a header
    func DeleteNote(id:String){
        AF.request("http://192.168.0.176:8081/delete", method: .post, encoding: URLEncoding.httpBody, headers: ["id": id]).responseJSON {
            response in
            print(response)
        }
    }

}

