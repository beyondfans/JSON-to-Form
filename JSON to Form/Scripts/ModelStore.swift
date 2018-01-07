//
//  ModelStore.swift
//  JSON to Form
//
//  Created by User on 1/6/18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

class ModelStore {
    static let shared = ModelStore()
    
    //for storing all the button field properties
    var buttonDictionary: [String:Field] = [String:Field]()
    
    //for storing all the checkbox field properties
    var checkboxDictionary: [String:Field] = [String:Field]()
    
    //for storing all the label field properties
    var labelDictionary: [String:Field] = [String:Field]()
    
    //for storing all the text field properties
    var textDictionary: [String:Field] = [String:Field]()
    
    //for storing all the radio button properties, need to initialize [Field]() for each key in dictionary
    var radioBtnDictionary: [String:[Field]] = [String:[Field]]()    
    
}
