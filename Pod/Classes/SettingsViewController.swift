//
//  SettingsViewControllerTableViewController.swift
//  SchlauerParken
//
//  Created by Josef Materi on 09.03.15.
//  Copyright (c) 2015 iPOL GmbH. All rights reserved.
//

import UIKit
import Bond

public struct Settings {
    
    var minimumSpotLength: Float = 0
    var reloadInterval: NSTimeInterval = 0
    var maximumSpotDataAge: NSTimeInterval = 0
    public var simulationMode: Bool = false
    
    init() {
        
    }
    
}

public protocol SettingsViewControllerProtocol {
    func settingsViewControllerDidFinishWithSettings(settings: Settings)
}




class SettingsViewController: UITableViewController {
    
    var settings = Settings()
    var cells: [UITableViewCell] = [UITableViewCell]()
    var delegate : SettingsViewControllerProtocol?
    var rowViewModels : [RowViewModel] = [RowViewModel]()
    var tabula : Tabula?
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Übernehmen", style: UIBarButtonItemStyle.Plain, target: self, action: "done")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Schließen", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        
        self.loadWithSettings(Settings())
    }

    func loadWithSettings(settings: Settings) {
        
        self.settings = settings
        
        self.tabula = Tabula(tableView: self.tableView)
        
        self.settings.minimumSpotLength = 0.6
        
        var rangeViewModel = RangeViewModel(min: 0.4, max: 3) { viewModel in
           viewModel.value <<->> self.settings.minimumSpotLength
           viewModel.value.map { "\($0)" } ->> viewModel.title
        }
        rangeViewModel.cellIdentifier = "sliderCell"
    
        self.settings.simulationMode = true
        
        var switchViewModel = SwitchViewModel(onLabel: "An", offLabel: "Aus") { viewModel in
            viewModel.value <<->> self.settings.simulationMode
        }
        switchViewModel.cellIdentifier = "switchCell"

        var section0 = TabulaSection(title: "Mindestlänge eines als frei definierten Parkraumes", rows: [rangeViewModel])
        var section1 = TabulaSection(title: "dsfsdf", rows: [switchViewModel])
        
        self.tabula?.addSections([section0, section1])
        
        
        var cellFactory = TabulaCellFactory()
     
        cellFactory.register("sliderCell") { viewModel in
           return SliderTableViewCell(viewModel: viewModel as! RangeViewModel)
        }
        
        cellFactory.register("switchCell") { viewModel in
            return SwitchTableViewCell(viewModel: viewModel as! SwitchViewModel)
        }

        self.tabula?.cellFactory = cellFactory
        
        self.tabula?.reloadData()
        
    }
    
    func close() {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func done() {
        println(self.settings.minimumSpotLength)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

