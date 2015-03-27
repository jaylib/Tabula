//
//  SwtichViewModel.swift
//  SchlauerParken
//
//  Created by Josef Materi on 10.03.15.
//  Copyright (c) 2015 iPOL GmbH. All rights reserved.
//

import UIKit
import Bond

public class SwitchViewModel : CellViewModel {
    
    var value: Dynamic<Bool>

    init(mapping: ((viewModel: SwitchViewModel) -> () ) )  {
        self.value = Dynamic<Bool>(false)
        super.init()
        mapping(viewModel: self)
    }

    init(onLabel: String, offLabel: String, mapping: ((viewModel: SwitchViewModel) -> () ))  {
        self.value = Dynamic<Bool>(false)
        super.init()
        self.value.map { value in
            if value == true {
                return onLabel
            } else { return offLabel }
        } ->> self.title
        mapping(viewModel: self)
    }
}