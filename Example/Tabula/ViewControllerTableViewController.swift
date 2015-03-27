//
//  ViewControllerTableViewController.swift
//  Tabula
//
//  Created by Josef Materi on 07.03.15.
//  Copyright (c) 2015 Josef Materi. All rights reserved.
//

import UIKit
import Tabula
import Bond

func dynamic<T>(value: T) -> Dynamic<T> {
    return Dynamic<T>(value)
}

infix operator <--> {}
func <--> <T>(inout left: T, right: Float) {
    ValueMapping().basicType(&left, object: right)
}

infix operator <---> {}
func <---> <T>(inout left: T, right: Float) {
    ValueMapping().basicType(right, right: &left)
}

class DynamicMapper<T> {
    var value: Dynamic<T>
    
    init(value: Dynamic<T>) {
        self.value = value
    }
    
    func map(value: Dynamic<T>) {
        self.value = value
    }
}

class ValueMapping {
    
    init() {
        
    }
    
    func basicType<FieldType>(inout field: FieldType, object: AnyObject?) {
        basicType(&field, object: object as? FieldType)
    }
    
    func basicType<FieldType>(inout field: FieldType, object: FieldType?) {
        if let value = object {
            field = value
        }
    }
    
    func basicType<FieldType>(field: Float, inout right: FieldType) {
    
    }
}

class RangeViewModel {
    
    typealias StringTransfrom = ((Float) -> (String))
    typealias NumberTransform = ((String) -> (Float))
    
    typealias BackTransform = ((value: Float) -> ())
    typealias Mapping = ((Dynamic<Float>) -> ())
    
    var min: Dynamic<Float>
    var max: Dynamic<Float>
    var value: Dynamic<Float>
    
    var _numberTransform : NumberTransform?
    var _stringTransform: StringTransfrom?
    var _backTransform : BackTransform?
    
    private var inboundMapping: Mapping?
    private var outboundMapping: Mapping?
    
    init(min: Float, max: Float, value: Float) {
        self.min = Dynamic<Float>(min)
        self.max = Dynamic<Float>(max)
        self.value = Dynamic<Float>(value)
        self.enforceValidValues()
    }
    
    init(min: Float, max: Float, value: Dynamic<Float>) {
        self.min = Dynamic<Float>(min)
        self.max = Dynamic<Float>(max)
        self.value = value
        self.enforceValidValues()
    }
    
    init(min: Float, max: Float, valueMapping: (value: Dynamic<Float>) -> ()) {
        self.min = Dynamic<Float>(min)
        self.max = Dynamic<Float>(max)
        self.value = Dynamic<Float>(0)
        valueMapping(value: self.value)
    }
    
    init(min: Float, max: Float, inMapping: Mapping, outMapping: Mapping) {
        self.min = Dynamic<Float>(min)
        self.max = Dynamic<Float>(max)
        self.value = Dynamic<Float>(0)
        inMapping(self.value)
        self.inboundMapping = inMapping
        self.outboundMapping = outMapping
    }
    
    func basicType<FieldType>(inout field: FieldType, object: AnyObject?) {
        basicType(&field, object: object as? FieldType)
    }
    
    func basicType<FieldType>(inout field: FieldType, object: FieldType?) {
        if let value = object {
            field = value
        }
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
    
    func numberTransform(string: String) -> Float {
        if self._numberTransform != nil {
            return self._numberTransform!(string)
        } else {
            return (string as NSString).floatValue
        }
    }
    
    func stringTransform(number: Float) -> String {
        if self._stringTransform != nil {
            return self._stringTransform!(number)
        } else {
            return "\(number)"
        }
    }
    
    func extract() {
        if let out = self.outboundMapping {
            out(self.value)
        }
    }
    
}

class SliderCell: UITableViewCell {

    var viewModel : RangeViewModel
    var slider : UISlider = UISlider(frame: CGRect(x: 0,y: 0, width: 100, height: 40))

    init(viewModel: RangeViewModel) {
        self.viewModel = viewModel
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "")
        
        self.addSubview(slider)
        
        slider.minimumValue = viewModel.min.value
        slider.maximumValue = viewModel.max.value

        viewModel.value <->> slider
        viewModel.value.map(viewModel.stringTransform) ->> self.textLabel!
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct Settings {
    
    var minimumSpotLength: Float = 5.3
    var maximumDataAge: Float = 5 * 60
    
    init(minimumSpotLength: Float) {
        self.minimumSpotLength = minimumSpotLength
    }
    
}

class SettingsViewModel {
    
    var minimumSpotLength: RangeViewModel
    var maximumDataAge : RangeViewModel
    
    init(settings: Settings) {
        self.minimumSpotLength = RangeViewModel(min: -20, max: 20, value: settings.minimumSpotLength)
        self.maximumDataAge = RangeViewModel(min: -20, max: 20, value: settings.maximumDataAge)
    }
    
    func getSettings() -> Settings {
        var newSettings =  Settings(minimumSpotLength: self.minimumSpotLength.value.value)
        newSettings.maximumDataAge = self.minimumSpotLength.value.value
        return newSettings
    }
}


class ViewControllerTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        /*




        */
        
        var settings = Settings(minimumSpotLength: 5.3)

        var settingsViewModel = SettingsViewModel(settings: Settings(minimumSpotLength: 5.3))
        
        var cell1 = SliderCell(viewModel: settingsViewModel.minimumSpotLength)
        var cell2 = SliderCell(viewModel: settingsViewModel.maximumDataAge)
        
        var range = RangeViewModel(min: 0, max: 10, inMapping: { value in
                value.value = settings.minimumSpotLength
            }, outMapping: { value in
                settings.minimumSpotLength = value.value
        })
        
    }
    

    
    func map<T, U>(value: T, transform: (T) -> (U)) -> U {
        return transform(value)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
