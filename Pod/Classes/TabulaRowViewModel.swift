//
//  TabulaRowViewModel.swift
//  Pods
//
//  Created by Josef Materi on 08.03.15.
//
//

import UIKit
import Bond

// View Model
public class TabulaRowViewModel<T>  {
    
    public
    
    var value : Dynamic<T>
    
    // dynamicObservableFor(self.user, keyPath: "name", from: { ($0 as? String) ?? "" }, to: { $0 })
    
    public init(value: T) {
        self.value = Dynamic<T>(value)
    }
    
}