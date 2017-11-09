//
//  DataManager.swift
//  Guide
//
//  Created by arbenjusufhayati on 11/9/17.
//  Copyright © 2017 HASELT. All rights reserved.
//

import Foundation

class DataManager {
    static func read() -> Any? {
        if let path = Bundle.main.path(forResource: "data", ofType: "json")  {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                return jsonResult
            } catch {
                // handle error
                
            }
        }else{
            return nil
        }
        
        return nil
    }
}

