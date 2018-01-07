
import UIKit

class RadioBtn: UIButton {
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                if let title = self.title(for: .normal) {
                    self.setTitle("\(title.replacingOccurrences(of: "⚪️ ", with: "⚫️ "))", for: .normal)
                }
            } else {

                if let title = self.title(for: .normal){
                    if(title.contains("⚫️")) {
                        self.setTitle("\(title.replacingOccurrences(of: "⚫️ ", with: "⚪️ "))", for: .normal)
                    } else {
                        self.setTitle("⚪️ \(title.replacingOccurrences(of: "⚪️ ", with: ""))", for: .normal)
                    }
                    
                }
            }
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.isChecked = false
        self.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override func awakeFromNib() {
//        //print("click")
//        //self.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
//        //self.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
//        self.isChecked = false
//    }
    
    ///*
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
            
            let radioBtn_id = sender.restorationIdentifier!

            let values = radioBtn_id.split(separator: "+", maxSplits: 1, omittingEmptySubsequences: false)
            
            if (values.count > 1 && isChecked) {
                let default_value = ModelStore.shared.radioBtnDictionary["\(values[0])"]![Int(values[1])!].default_value
                
                //print("\(sender.restorationIdentifier!) \(values[0]).\(values[1])")
                var count = 0
                
                for i in ModelStore.shared.radioBtnDictionary["\(values[0])"]! {
                    ModelStore.shared.radioBtnDictionary["\(values[0])"]![count].current_value = default_value
                    
                    if(default_value != i.default_value) {
                        i.addedField?.buttonClicked(sender: self)
                        //print("def: \(default_value), i: \(i.default_value)")
                    }
                    count += 1
                }
                
//                for i in ModelStore.shared.radioBtnDictionary["\(values[0])"]! {
//                    print("title: \(i.picture), def: \(i.default_value), current: \(i.current_value)")
//                }
            }
        } else {isChecked = false}
    }
    
}














