//
//  RangeViewModel.swift
//  SchlauerParken
//
//  Created by Josef Materi on 09.03.15.
//  Copyright (c) 2015 iPOL GmbH. All rights reserved.
//
import Bond


public protocol RowViewModel {
    
    var headline : Dynamic<String> { get set }
    var title : Dynamic<String> { get set }
    var subtitle: Dynamic<String> { get set }
    var cellIdentifier: String? { get set }
    
}

public class CellViewModel : RowViewModel {
    
    public var headline : Dynamic<String>
    public var title : Dynamic<String>
    public var subtitle: Dynamic<String>
    public var cellIdentifier: String?
    
    init() {
        self.title = Dynamic<String>("")
        self.subtitle = Dynamic<String>("")
        self.headline = Dynamic<String>("")
    }
}

public class RangeViewModel : CellViewModel {

    typealias Mapping = ((Dynamic<Float>, Dynamic<String>, Dynamic<String>) -> ())
    
    internal var inboundMapping: Mapping?
    internal var outboundMapping: Mapping?
    
    var min: Dynamic<Float>
    var max: Dynamic<Float>
    var value: Dynamic<Float>
    
    init(min: Float, max: Float, mapping: ( (viewModel: RangeViewModel) -> () ) )  {
        self.min = Dynamic<Float>(min)
        self.max = Dynamic<Float>(max)
        self.value = Dynamic<Float>(0)
        super.init()
        mapping(viewModel: self)
        self.enforceValidValues()
    }
    
    func mapTitle(map: ((value: Float) -> String )) -> RangeViewModel {
        self.value.map(map) ->> self.title
        return self
    }
    
    func enforceValidValues() {
        reduce(self.min, self.max, self.value) { [weak self] min, max, value in
            if value < min {
                return min
            } else if value > max {
                return max
            } else {
                return value
            }
            } ->> self.value
    }
    
}