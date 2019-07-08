//
//  Entry.swift
//  JournalCK
//
//  Created by Drew Seeholzer on 7/8/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation
import CloudKit

class Entry {
    
    struct EntryConstants {
        static let TypeKey = "Entry"
        static let TitleKey = "title"
        static let BodyKey = "body"
        static let TimestampKey = "timestamp"
        static let recordType = "ckRecordID"
    }
    
    var cloudKitRecord: CKRecord {
        
        let record = CKRecord(recordType: EntryConstants.TypeKey)
        
        record.setValue(title, forKey: EntryConstants.TitleKey)
        record.setValue(bodyText, forKey: EntryConstants.BodyKey)
        record.setValue(timestamp, forKey: EntryConstants.TimestampKey)
        record.setValue(ckRecordID, forKey: EntryConstants.recordType)
        
        return record
    }
    
    init?(record: CKRecord) {
        guard let title = record[EntryConstants.TitleKey] as? String, let bodyText = record[EntryConstants.BodyKey] as? String, let timestamp = record[EntryConstants.TimestampKey] as? Date, let ckRecordID = record[EntryConstants.recordType] as? CKRecord.ID else {return nil}
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
    
    let title: String
    let bodyText: String
    let timestamp: Date
    let ckRecordID: CKRecord.ID
    
    init(title: String, bodyText: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
    
}


