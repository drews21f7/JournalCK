//
//  EntryController.swift
//  JournalCK
//
//  Created by Drew Seeholzer on 7/8/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    static let sharedInstance = EntryController()
    
    var entries: [Entry] = []
    
    func save(entry: Entry, completion: @escaping (Bool) -> ()) {
        
        let record = CKRecord(entry: entry)
        
        CKContainer.default().privateCloudDatabase.save(record) { (record, error) in
            if let error = error {
                print ("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
                completion(false)
            }
            
            guard let foundRecord = record else { completion(false); return } //; completion(false) }
            
            guard let finalEntry = Entry.init(record: foundRecord) else { completion(false); return } //; completion(false) }
 
            self.entries.append(finalEntry)
            
            completion(true)
        
        }
    }
    
    func addEntryWith(title: String, bodyText: String, completion: @escaping (Bool) -> ()) {
        let entry = Entry(title: title, bodyText: bodyText)
        save(entry: entry) { (success) in
            if success {
                print ("Entry saved successfully")
                completion(true)
            } else {
                print ("Entry not saved :(")
                completion(false)
            }
        }
    }
    
    func fetchEntries(completion: @escaping (Bool) -> ()) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: EntryConstants.typeKey , predicate: predicate)
        
        CKContainer.default().privateCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print ("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
                completion(false)
            }
            
            guard let foundEntry = records else { completion(false); return }
            
            let fetchedEntry = foundEntry.compactMap({Entry(record: $0)})
            
            self.entries = fetchedEntry
            
            completion(true)
            
        }
    }
}
