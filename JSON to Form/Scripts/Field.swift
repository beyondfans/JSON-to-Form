//
//  field.swift
//  JSON to Form
//
//  Created by User on 12/29/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

struct Field {
    var table_name: String?
    var field_name: String?
    var field_type: String?
    var field_length: CGFloat?
    var posx: CGFloat?
    var posy: CGFloat?
    var width: CGFloat?
    var height: CGFloat?
    var font_name: String?
    var font_bold_ind: String?
    var font_italic_ind: String?
    var font_size: CGFloat?
    var fore_color_normal: String?
    var back_color_normal: String?
    var picture: String?
    var default_value: String?
    var modifiable_ind: String?
    var required_ind: String?
    var bhidden_ind: String?
    var display_as: String?
    var current_value: String?
    var addedField: AnyObject?
    
    init?(dictionary: [String: AnyObject]) {
        //Optional Values
        let table_name = dictionary["table_name"] as? String
        let field_name = dictionary["field_name"] as? String
        let field_type = dictionary["field_type"] as? String
        let field_length = dictionary["field_length"] as? CGFloat
        let posx = dictionary["posx"] as? CGFloat
        let posy = dictionary["posy"] as? CGFloat
        let width = dictionary["width"] as? CGFloat
        let height = dictionary["height"] as? CGFloat
        let font_name = dictionary["font_name"] as? String
        let font_bold_ind = dictionary["font_bold_ind"] as? String
        let font_italic_ind = dictionary["font_italic_ind"] as? String
        let font_size = dictionary["font_size"] as? CGFloat
        let fore_color_normal = dictionary["fore_color_normal"] as? String
        let back_color_normal = dictionary["back_color_normal"] as? String
        let picture = dictionary["picture"] as? String
        let default_value = dictionary["default_value"] as? String
        let modifiable_ind = dictionary["modifiable_ind"] as? String
        let required_ind = dictionary["required_ind"] as? String
        let bhidden_ind = dictionary["bhidden_ind"] as? String
        let display_as = dictionary["display_as"] as? String
        
        //below fields for storing button details
        let current_value = dictionary["current_value"] as? String
        let addedField = dictionary["addedField"] as AnyObject
        
        //Pass the values to the full initializer
        self.init(table_name: table_name, field_name: field_name, field_type: field_type, field_length: field_length, posx: posx, posy: posy, width: width, height: height, font_name: font_name, font_bold_ind: font_bold_ind, font_italic_ind: font_italic_ind, font_size: font_size, fore_color_normal: fore_color_normal, back_color_normal: back_color_normal, picture: picture, default_value: default_value, modifiable_ind: modifiable_ind, required_ind: required_ind, bhidden_ind: bhidden_ind, display_as: display_as, current_value: current_value, addedField: addedField)
    }
    
    init(table_name: String?, field_name: String?, field_type: String?, field_length: CGFloat?, posx: CGFloat?, posy: CGFloat?, width: CGFloat?, height: CGFloat?, font_name: String?, font_bold_ind: String?, font_italic_ind: String?, font_size: CGFloat?, fore_color_normal: String?, back_color_normal: String?, picture: String?, default_value: String?, modifiable_ind: String?, required_ind: String?, bhidden_ind: String?, display_as: String?, current_value: String?, addedField: AnyObject) {
        
        self.table_name = table_name
        self.field_name = field_name
        self.field_type = field_type
        self.field_length = field_length
        self.posx = posx
        self.posy = posy
        self.width = width
        self.height = height
        self.font_name = font_name
        self.font_bold_ind = font_bold_ind
        self.font_italic_ind = font_italic_ind
        self.font_size = font_size
        self.fore_color_normal = fore_color_normal
        self.back_color_normal = back_color_normal
        self.picture = picture
        self.default_value = default_value
        self.modifiable_ind = modifiable_ind
        self.required_ind = required_ind
        self.bhidden_ind = bhidden_ind
        self.display_as = display_as
        self.current_value = current_value
        self.addedField = addedField
    }

}











