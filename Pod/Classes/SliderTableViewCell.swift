//
//  SliderCellTableViewCell.swift
//  SchlauerParken
//
//  Created by Josef Materi on 09.03.15.
//  Copyright (c) 2015 iPOL GmbH. All rights reserved.
//

import UIKit
import Bond
import PureLayout

public class TabulaTableViewCell : UITableViewCell {
    
    var viewModel : RowViewModel?
    
    required public init(viewModel: RowViewModel) {
        self.viewModel = viewModel
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "")
    }
    
    
    func configureWithViewModel<T: RowViewModel>(viewModel: T) {
        self.configureWithViewModel(viewModel)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

public class SliderTableViewCell : TabulaTableViewCell {

    var slider : UISlider = UISlider(frame: CGRect(x: 0,y: 0, width: 100, height: 40))

    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(slider)
        
        slider.autoConstrainAttribute(ALAttribute.Right, toAttribute: ALAttribute.Right, ofView: self.contentView, withOffset: -10)
        slider.autoConstrainAttribute(ALAttribute.Horizontal, toAttribute: ALAttribute.Horizontal, ofView: self.contentView, withOffset: 0)
        slider.autoConstrainAttribute(ALAttribute.Left, toAttribute: ALAttribute.Left, ofView: self.contentView, withOffset: 90)
        
    }
    
    convenience init(viewModel: RangeViewModel) {
        self.init(style: UITableViewCellStyle.Default, reuseIdentifier: "")

        self.viewModel = viewModel

        
        slider.minimumValue = viewModel.min.value
        slider.maximumValue = viewModel.max.value
        
        viewModel.value <->> slider
        viewModel.title ->> self.textLabel!
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required public init(viewModel: RowViewModel) {
        fatalError("init(viewModel:) has not been implemented")
    }

}
