//
//  String+Extensions.swift
//  CallAPIExample
//
//  Created by Leo Ho on 2023/2/3.
//

import Foundation

extension String {
    
    func toInt() -> Int {
        return Int(self) ?? 0
    }
}
