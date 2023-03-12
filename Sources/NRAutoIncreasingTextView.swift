//
//  NRAutoIncreasingTextView.swift
//  NRAutoIncreasingTextView
//
//  Created by Nalinee on 12/03/2023.
//

import UIKit

public class NRAutoIncreasingTextView:UITextView{
    ///Holds the number of lines to show completly. Default is 4 i.e til 4 lines textview will keep increasing height. After that it will make the scroll enable.
    public var maxLinesWithoutScroll = 4
    ///This holds the multiplier of line height. This is used for the mininum height that textview should keep. Default is 1 i.e height equal to 1 lines will be shown as minimum
    public var minHeightLineMultiplier = 2
    
    //MARK: init
    public convenience init(frame: CGRect) {
        self.init(frame: frame, textContainer: nil)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    private func initialSetup(){
        
        //-----remove padding-----
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
        //-----other properties
        isScrollEnabled = false
        let nameVal = UITextView.textDidChangeNotification
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: nameVal, object: nil)
        textDidChange()
    }
    
    @objc private func textDidChange(){
        let maxSize = CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        var newSize = sizeThatFits(maxSize)
        let lineHeight = font!.lineHeight
        let lines = newSize.height / (lineHeight)
        if lines >= 5{
            //when something is paste in textV and that exceeds 5 lines get height for only 4 lines
            newSize.height = (lineHeight * 4)
        }
        else if newSize.height < lineHeight * CGFloat(minHeightLineMultiplier){
            newSize.height = (lineHeight * CGFloat(minHeightLineMultiplier))
        }
        updateHeight(height: newSize.height)
        isScrollEnabled = (lines > CGFloat(maxLinesWithoutScroll))
    }
    /// update the text frame
    private func updateHeight(height:CGFloat){
        UIView.animate(withDuration: 0.2) {[weak self] in
            guard let ws = self else{return}
            
            if let index = ws.constraints.lastIndex(where: {$0.firstAttribute == .height && $0.relation == .equal}){
                UIView.animate(withDuration: 0.2) {
                    ws.constraints[index].constant = height
                }
            }
        }
    }
}
