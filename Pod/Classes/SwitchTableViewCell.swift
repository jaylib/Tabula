//
//  SwitchTableViewCell.swift
//  SchlauerParken
//
//  Created by Josef Materi on 10.03.15.
//  Copyright (c) 2015 iPOL GmbH. All rights reserved.
//

import UIKit
import Bond

public class SwitchTableViewCell: TabulaTableViewCell {
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override public func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var switchView : UISwitch = UISwitch(frame: CGRect(x: 0,y: 0, width: 100, height: 40))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    init(viewModel: SwitchViewModel) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "")
        self.viewModel = viewModel
        self.accessoryView = switchView
        viewModel.value <->> switchView
        viewModel.title ->> self.textLabel!
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required public init(viewModel: RowViewModel) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "")
//        self.viewModel = viewModel
//        self.accessoryView = switchView
//        viewModel.value <->> switchView
//        viewModel.title ->> self.textLabel!
    }
}