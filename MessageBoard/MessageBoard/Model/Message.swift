//
//  Message.swift
//  MessageBoard
//
//  Created by Leo Ho on 2023/1/17.
//

import Foundation

struct Message {
    
    /// 留言人
    var name: String
    
    /// 留言內容
    var content: String
    
    /// 留言時間
    var createTimestamp: Int64
    
    /// 更新留言時間
    var updateTimestamp: Int64
}
