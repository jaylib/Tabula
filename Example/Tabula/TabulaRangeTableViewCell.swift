//
//  TabulaRangeTableViewCell.swift
//  Tabula
//
//  Created by Josef Materi on 08.03.15.
//  Copyright (c) 2015 Josef Materi. All rights reserved.
//

import UIKit
import Bond

class TabulaRangeTableViewCell: UITableViewCell {

    var slider : UISlider = UISlider(frame: CGRect(x: 0,y: 0, width: 100, height: 40))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var viewModel : TabulaRowViewModel<FloatValue>
    
    init(viewModel: TabulaRowViewModel<FloatValue>) {
        self.viewModel = viewModel
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "")
        self.contentView.addSubview(slider)
        
       self.configure(viewModel)
    }
    
    func configure(viewModel: TabulaRowViewModel<FloatValue>) {
        
        slider.minimumValue = viewModel.value.value.min
        slider.maximumValue = viewModel.value.value.max
        
        viewModel.value.map { $0.value } ->> self.slider
        self.slider.dynValue.map { FloatValue(min: 0, max: 10, value: $0) } ->> viewModel.value
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
