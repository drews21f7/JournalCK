//
//  Entry.swift
//  JournalCK
//
//  Created by Drew Seeholzer on 7/8/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation
import CloudKit

struct EntryConstants {
    static let typeKey = "Entry"
    static let titleKey = "title"
    static let bodyKey = "body"
    static let timestampKey = "timestamp"
    static let recordIDKey = "ckRecordID"
}

class Entry {
    
    
    init?(record: CKRecord) {
        guard let title = record[EntryConstants.titleKey] as? String, let bodyText = record[EntryConstants.bodyKey] as? String, let timestamp = record[EntryConstants.timestampKey] as? Date, let ckRecordID = record[EntryConstants.recordIDKey] as? CKRecord.ID else {return nil}
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

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryConstants.recordIDKey, recordID: entry.ckRecordID)
        self.setValue(entry.title, forKey: EntryConstants.titleKey)
        self.setValue(entry.bodyText, forKey: EntryConstants.bodyKey)
        self.setValue(entry.timestamp, forKey: EntryConstants.timestampKey)
    }
}
