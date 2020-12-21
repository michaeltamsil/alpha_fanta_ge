//
//  extensions.swift
//  alpha_fanta_ge
//
//  Created by michael tamsil on 21/12/20.
//

import Foundation

extension Dictionary {
    func iterateThroughAllKeyValues(execute execution: ((Key, Value))->()) {
        for element in self {
            if let dictionary = element.value as? [Key: Value] {
                dictionary.iterateThroughAllKeyValues(execute: execution)
            } else {
                execution(element)
            }
        }
    }
}
