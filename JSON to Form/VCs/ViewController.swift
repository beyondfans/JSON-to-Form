//
//  ViewController.swift
//  JSON to Form
//
//  Created by User on 12/29/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var fields: [Field] = [Field]()
    var template_name: String = ""
    var template_width: CGFloat = 0
    var template_height: CGFloat = 0
    var template_ratios_width: CGFloat = 0
    var template_ratios_height: CGFloat = 0
    
    var xRatio: CGFloat = 0     //size
    var yRatio: CGFloat = 0     //size
    var wRatio: CGFloat = 0     //location
    var hRatio: CGFloat = 0     //location
    
    var fontRatio: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //get JSON Message, step 1, create URL
        let url = URL(string:"http://virtual-pc.local:3333/Template")!
        
    //get JSON Message, step 2, create task
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            //error handler
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            //print("data: \(String(describing: data))")
            //do your stuff
            DispatchQueue.main.async {
                
            //Process JSON Message, step 1, put data from JSON message to dictionary
                let JSONDictionary = self.jsonFromData(data)
                //print("\(JSONDictionary)")
                
            //Process JSON Message, step 2, extract data from JSONDictionary
                //---------------------Start - Discrete data from JSON Message start ------------------------
                //to template_name, width and height
                let templateDictionary = JSONDictionary["header"] as! [String:AnyObject]
                self.template_name = templateDictionary["template_name"] as! String
                self.template_width = templateDictionary["template_width"] as! CGFloat
                self.template_height = templateDictionary["template_height"] as! CGFloat
                
                //to fields array
                let fieldDictionaries = JSONDictionary["fields"] as! [[String:AnyObject]]
                self.fields = fieldDictionaries.map() {
                    Field(dictionary: $0)!
                }
                //---------------------End - Discrete data from JSON Message ------------------------
                
                //---------------------Start drwaing out the form -----------------------------------
                let screenSize = UIScreen.main.bounds
                //set size x and size y ratio
                self.xRatio = ((self.template_width < screenSize.width) ? screenSize.width / self.template_width : self.template_width / screenSize.width)
                self.yRatio = ((self.template_height < screenSize.height) ? screenSize.height / self.template_height : self.template_height / screenSize.height)
                self.fontRatio = self.xRatio * 1.3
                
                //set width and height ratio
                self.wRatio = self.xRatio //(self.template_width < screenSize.width) ? screenSize.width / self.template_width : self.template_width / screenSize.width
                self.hRatio = self.yRatio // 1
                
//                print("sw: \(screenSize.width), sh: \(screenSize.height), tw: \(self.template_width), th: \(self.template_height)")
//                print("xRatio: \(self.xRatio), yRatio: \(self.yRatio), wRatio: \(self.wRatio), hRatio: \(self.hRatio)")
                
                for field in self.fields {
//                    if(field.font_bold_ind?.uppercased()=="Y") {
//                        print("bold: '\(field.table_name).\(field.field_name)")
//
//                    }

                    if (field.field_type == "button") {
                        ModelStore.shared.buttonDictionary[field.field_name!] = field
                        
                    } else if (field.field_type == "label") {
                        ModelStore.shared.labelDictionary[field.field_name!] = field
                        
                    } else if (field.display_as == "CheckBox") {
                        ModelStore.shared.checkboxDictionary[field.field_name!] = field
                    
                    } else if (field.field_type == "Text" && field.display_as == "") {
                        ModelStore.shared.textDictionary[field.field_name!] = field
                        
                    } else if (field.display_as == "RadioButton") {
                        //initial dictionary key array if it hasn't been
                        if (ModelStore.shared.radioBtnDictionary["\(field.table_name!).\(field.field_name!)"]?.count == nil) {
                            ModelStore.shared.radioBtnDictionary["\(field.table_name!).\(field.field_name!)"] = [Field]()
                        }
                        
                        ModelStore.shared.radioBtnDictionary["\(field.table_name!).\(field.field_name!)"]?.append(field)
                        //print(self.radioBtnDictionary.keys)
                    }
                    
                }
                
                //draw Buttons
                if (ModelStore.shared.buttonDictionary.count > 0) {
                    for (index, f) in ModelStore.shared.buttonDictionary {
                        let button = self.drawUIButton(field: f)
                        
                        ModelStore.shared.buttonDictionary[index]?.addedField = button
                        self.view.addSubview(ModelStore.shared.buttonDictionary[index]!.addedField as! UIButton)
                        //self.buttonDictionary[index]?.addedField?.setTitle("new title", for: .normal)
                        
                        //print("what is in this button: \(String(describing: self.buttonDictionary[index]))")
                    }
                }
                
                //draw Checkboxes
                if (ModelStore.shared.checkboxDictionary.count > 0) {
                    for (index, f) in ModelStore.shared.checkboxDictionary {
                        let checkbox = self.drawUICheckboxButton(field: f)
                        
                        ModelStore.shared.checkboxDictionary[index]?.addedField = checkbox
                        self.view.addSubview(ModelStore.shared.checkboxDictionary[index]!.addedField as! UIButton)
                        //self.checkboxDictionary[index]?.addedField?.setTitle("new title", for: .normal)
                        
                        //print("what is in this button: \(String(describing: self.checkboxDictionary[index]))")
                    }
                }
                
                //draw Label Field
                if (ModelStore.shared.labelDictionary.count > 0) {
                    for (index, f) in ModelStore.shared.labelDictionary {
                        let label = self.drawUILabel(field: f)
                        
                        ModelStore.shared.labelDictionary[index]?.addedField = label
                        self.view.addSubview(ModelStore.shared.labelDictionary[index]!.addedField as! UILabel)
                        //self.labelDictionary[index]?.addedField?.setTitle("new title", for: .normal)
                        
                        //print("what is in this button: \(String(describing: self.labelDictionary[index]))")
                    }
                }
                
                //draw Text Field
                if (ModelStore.shared.textDictionary.count > 0) {
                    for (index, f) in ModelStore.shared.textDictionary {
                        let text = self.drawUITextField(field: f)
                        
                        ModelStore.shared.textDictionary[index]?.addedField = text
                        
                        self.view.addSubview(ModelStore.shared.textDictionary[index]!.addedField as! UITextField)
                        //self.textDictionary[index]?.addedField?.setTitle("new title", for: .normal)
                        
                        //print("what is in this button: \(String(describing: self.textDictionary[index]))")
                    }
                }
                
                //draw Radio Button
                if (ModelStore.shared.radioBtnDictionary.count > 0) {
                    for (index, field) in ModelStore.shared.radioBtnDictionary {
                        var i: Int = 0   //index for radioBtnDictionary.value
                        
                        //print("i: \(index)")
                        for f in field {
                            //print("f: \(f)")
                            
                            let radioBtn = self.drawUIRadioButton(field: f, radioBtn_ID: "\(f.table_name!).\(f.field_name!)+\(i)")                       
                            ModelStore.shared.radioBtnDictionary[index]![i].addedField = radioBtn   //format looks like this "NEMS_domestic_violence_.opt_item_0+2"
                            
                            self.view.addSubview(ModelStore.shared.radioBtnDictionary[index]![i].addedField as! UIButton)
                            i += 1
                        }
                        
                    }
                    
                }
                //---------------------End of form drawing ------------------------------------------
            }

        }
        
//get JSON Message, step 3, send task
        task.resume()
        
    }
    
    //draw custom radio Button from input
    func drawUIRadioButton (field: Field,radioBtn_ID: String) -> UIButton {
        let radioBtn = RadioBtn(frame: CGRect(x: field.posx! * self.xRatio, y: field.posy! * self.yRatio, width: field.width! * self.wRatio, height: field.height! * self.hRatio))
        
        let text = field.picture!
        //radioBtn.self.tintColor = UIColor.black
        //radioBtn.frame = CGRect(x: x, y: y, width: width, height: height)
        radioBtn.setTitle("\(text)", for: .normal)
        radioBtn.isChecked = false
        radioBtn.setTitleColor(UIColor.black, for: .normal)
        //set to Bold
        if(field.font_bold_ind?.uppercased()=="Y") {
            radioBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: (field.font_size! * self.fontRatio).rounded())
        } else {
            radioBtn.titleLabel?.font = UIFont(name: field.font_name!, size: (field.font_size! * self.fontRatio).rounded())
        }
        //Make read only
        if(field.modifiable_ind?.uppercased()=="N") {
            radioBtn.isUserInteractionEnabled = false
        }
        //set to hide
        if(field.bhidden_ind?.uppercased() == "Y") {
            radioBtn.isHidden = true
        }
        
        radioBtn.restorationIdentifier = radioBtn_ID    //use for find out with radio button need to set on/off
        //radioBtn.addTarget(self, action: #selector(buttonTrigger(button:)), for: .touchUpInside)  //we can use 'addTraget' here or in 'RadioBtn' class, or both
        
        return radioBtn
    }
    
    //draw custom checkbox Button from input
    func drawUICheckboxButton (field: Field) -> UIButton {
        let checkbox = CheckBox(frame: CGRect(x: field.posx! * self.xRatio, y: field.posy! * self.yRatio, width: field.width! * self.wRatio, height: field.height! * self.hRatio))
        //let checkbox = CheckBox(frame: CGRect(x: x, y: y, width: width, height: height))
        
        let text = field.picture!
        checkbox.setTitle("\(text)", for: .normal)
        checkbox.isChecked = false
        checkbox.setTitleColor(UIColor.black, for: .normal)
        //set to Bold
        if(field.font_bold_ind?.uppercased()=="Y") {
            checkbox.titleLabel?.font = UIFont.boldSystemFont(ofSize: (field.font_size! * self.fontRatio).rounded())
        } else {
            checkbox.titleLabel?.font = UIFont(name: field.font_name!, size: (field.font_size! * self.fontRatio).rounded())
        }
        //Make read only
        if(field.modifiable_ind?.uppercased()=="N") {
            checkbox.isUserInteractionEnabled = false
        }
        //set to hide
        if(field.bhidden_ind?.uppercased() == "Y") {
            checkbox.isHidden = true
        }
        //checkbox.addTarget(self, action: #selector(buttonTrigger(button:)), for: .touchUpInside)  //we can use 'addTraget' here or in 'CheckBox' class, or both
        
        return checkbox
    }
    
    //draw UIButton from Input
    func drawUIButton (field: Field) -> UIButton {
        let button = UIButton(frame: CGRect(x: field.posx! * self.xRatio, y: field.posy! * self.yRatio, width: field.width! * self.wRatio, height: field.height! * self.hRatio))
        let text = field.default_value!
        button.setTitle("\(text)", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        //set font bold
        if(field.font_bold_ind?.uppercased()=="Y") {
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: (field.font_size! * self.fontRatio).rounded())
        } else {
            button.titleLabel?.font = UIFont(name: field.font_name!, size: (field.font_size! * self.fontRatio).rounded())
        }
        //Make read only
        if(field.modifiable_ind?.uppercased()=="N") {
            button.isUserInteractionEnabled = false
        }
        //set hidden
        if(field.bhidden_ind?.uppercased() == "Y") {
            button.isHidden = true
        }
        button.addTarget(self, action: #selector(buttonTrigger(button:)), for: .touchUpInside)
        
        return button
    }

    @objc func buttonTrigger (button: UIButton) {
        print("pressed")
    }
    
    //draw UILabel from Input
    func drawUILabel(field: Field) -> UILabel{
        let labelField = UILabel(frame: CGRect(x: field.posx! * self.xRatio, y: field.posy! * self.yRatio, width: field.width! * self.wRatio, height: field.height! * self.hRatio))
        let text = field.default_value!
        labelField.text = "\(text)"
        labelField.textColor = UIColor.black
        //set to Bold
        if(field.font_bold_ind?.uppercased()=="Y") {
            labelField.font = UIFont.boldSystemFont(ofSize: (field.font_size! * self.fontRatio).rounded())
        } else {
            labelField.font = UIFont(name: field.font_name!, size: (field.font_size! * self.fontRatio).rounded())
        }
        //Make read only
        if(field.modifiable_ind?.uppercased()=="N") {
            labelField.isUserInteractionEnabled = false
        }
        //set to hide
        if(field.bhidden_ind?.uppercased() == "Y") {
            labelField.isHidden = true
        }
        
        labelField.sizeToFit()
        
        return labelField
    }
    
    //draw UITextField from Input
    func drawUITextField (field: Field) -> UITextField {
        let textField =  UITextField(frame: CGRect(x: field.posx! * self.xRatio, y: field.posy! * self.yRatio, width: field.width! * self.wRatio, height: field.height! * self.hRatio))
        textField.placeholder = "Answer Here"
        textField.text = field.default_value
        
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextFieldViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        //set to Bold
        if(field.font_bold_ind?.uppercased()=="Y") {
            textField.font = UIFont.boldSystemFont(ofSize: (field.font_size! * self.fontRatio).rounded())
        } else {
            textField.font = UIFont(name: field.font_name!, size: (field.font_size! * self.fontRatio).rounded())
        }
        //Make read only
        if(field.modifiable_ind?.uppercased()=="N") {
            textField.isUserInteractionEnabled = false
        }
        //set to hide
        if(field.bhidden_ind?.uppercased() == "Y") {
            textField.isHidden = true
        }
        //textField.delegate = self
        return textField
    }
    
    // Mark: Parser
    func jsonFromData(_ data: Data?) -> [String : AnyObject] {
        //No data, return an empty array
        guard let data = data else {
            return [String : AnyObject]()
        }
        
        //parse the Data into JSON Object
        let JSONObject = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
        
        //print(JSONObject)
        
        //insist that this object must be a dictionary
        guard let JSONDictionary = JSONObject as? [String : AnyObject] else {
            assertionFailure("Failed to parse data. data.length: \(data.count)")
            return [String : AnyObject]()
        }
        
        // Print the object, for now, so we can take a look
        //print(JSONDictionary)
        
        // Pretty Print the string, for debugging
        //let prettyData = try! JSONSerialization.data(withJSONObject: JSONObject, options: .prettyPrinted)
        //let prettyString = String(data: prettyData, encoding: String.Encoding.utf8)
        //print(prettyString ?? "No String Available")

        //let fieldDictionaries = JSONDictionary["fields"] as! [[String : AnyObject]]
        return JSONDictionary
    }
}

