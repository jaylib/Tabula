//
//  FloatValue.swift
//  Pods
//
//  Created by Josef Materi on 08.03.15.
//
//

import UIKit
import Bond

public protocol RowValue {
    
}

public struct FloatValue : RowValue {
    
    public var min: Float = -100.0
    public var max: Float = 100.0
    public var value: Float = 0.0
    
    public init(min: Float, max: Float, value: Float) {
        self.min = min;
        self.max = max;
        self.value = value;
    }
    
    public func updateValue(value: Float) -> FloatValue {
        return FloatValue(min: self.min, max: self.max, value: value)
    }
    
}
