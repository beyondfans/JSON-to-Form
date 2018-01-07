
import UIKit

class CheckBox: UIButton {
    /* for show Images on the left and title on the right
    let checkedImage = UIImage(named: "checked12x12")! as UIImage
    let uncheckedImage = UIImage(named: "uncheck12x12")! as UIImage
    var image_right: CGFloat = 0
    var text_left: CGFloat = 0
    *****************/
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                if let title = self.title(for: .normal) {
                    /* for show image on the left and title on the right
                    self.setImage(checkedImage, for: .normal)
                    self.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,0)
                    self.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,self.image_right)
                    self.sizeToFit()   //size to fix will show you the image actual size, use the actual to calculate title's 'Left' value.
                    ***************/
                    
                    self.setTitle("☑️ \(title.replacingOccurrences(of: "🔲 ", with: ""))", for: .normal)
                }
            }
            else {
                if let title = self.title(for: .normal){
                    /* for show image on the left and title on the right
                    self.setImage(uncheckedImage, for: .normal)
                    self.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,0)
                    self.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,self.image_right)
                    self.sizeToFit()   //size to fix will show you the image actual size, use the actual to calculate title's 'Left' value.
                    **************/
                    self.setTitle("🔲 \(title.replacingOccurrences(of: "☑️ ", with: ""))", for: .normal)
                }
            }
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        //print("test")
        /* for show image on the left and title on the right
        self.image_right = self.frame.width - self.frame.height
        self.text_left = self.frame.height
        self.setImage(uncheckedImage, for: .normal)
        self.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,0)
        self.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,self.image_right)
        ******************/
        
        self.isChecked = false  //don't think this is need, but for sure need to set to 'false' in button setup script.
        self.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// not sure what this func is for, we can disable it without issue.
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
            
        }
    }
    
}













