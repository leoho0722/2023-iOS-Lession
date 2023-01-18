//
//  LocalDatabase.swift
//  MessageBoard
//
//  Created by Leo Ho on 2023/1/18.
//

import Foundation
import RealmSwift

class LocalDatabase: NSObject {
    
    /// Singleton
    static let shared = LocalDatabase()
    
    /// 新增留言到 Realm Database 內
    /// - Parameter message: Message 資料結構
    func add(message: Message) {
        let realm = try! Realm()
        
        let table = MessageTable()
        table.name = message.name
        table.content = message.content
        table.createTimestamp = message.createTimestamp
        table.updateTimestamp = message.updateTimestamp
        
        do {
            try realm.write {
                realm.add(table)
                print("File URL：\(String(describing: realm.configuration.fileURL?.absoluteString))")
            }
        } catch {
            print("Realm Add Failed：\(error.localizedDescription)")
        }
    }
    
    
    /// 從 Realm Database 內讀取留言
    /// - Parameter finish: 從 Realm Database 內讀取留言後要做的事
    /// - Returns: Results<MessageTable>，從 Realm Database 內讀取到的留言陣列
    func fetch(finish: @escaping (Results<MessageTable>) -> Void) {
        DispatchQueue.global().async {
            let realm = try! Realm()
            let results = realm.objects(MessageTable.self)
            finish(results)
        }
    }
    
    /// 更新留言到 Realm Database 內
    /// - Parameter message: Message 資料結構
    func update(message: Message) {
        let realm = try! Realm()
        let updateMessage = realm.objects(MessageTable.self).where {
            $0.createTimestamp == message.createTimestamp
        }
        do {
            try realm.write {
                if updateMessage.count > 0 {
                    updateMessage[0].name = message.name
                    updateMessage[0].content = message.content
                    updateMessage[0].updateTimestamp = message.updateTimestamp
                } else {
                    print("查無需更新的資料")
                }
            }
        } catch {
            print("Realm Update Failed：\(error.localizedDescription)")
        }
    }
    
    /// 從 Realm Database 內刪除留言
    /// - Parameter message: Message 資料結構
    func delete(message: Message) {
        let realm = try! Realm()
        let deleteMessage = realm.objects(MessageTable.self).filter {
            $0.createTimestamp == message.createTimestamp
        }.first
        
        do {
            try realm.write {
                realm.delete(deleteMessage!)
            }
        } catch {
            print("Realm Delete Failed：\(error.localizedDescription)")
        }
    }
}

class MessageTable: Object {
    
    /// 留言人
    @Persisted var name: String
    
    /// 留言內容
    @Persisted var content: String
    
    /// 留言時間
    @Persisted var createTimestamp: Int64
    
    /// 更新留言時間
    @Persisted var updateTimestamp: Int64
}
