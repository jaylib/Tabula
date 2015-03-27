//
//  Tabula.swift
//  SchlauerParken
//
//  Created by Josef Materi on 09.03.15.
//  Copyright (c) 2015 iPOL GmbH. All rights reserved.
//

import UIKit

protocol TabulaCellProvider {
    func cellForIdentifier(cellIdentifier: String, viewModel: RowViewModel) -> TabulaTableViewCell?
}

public class TabulaCellFactory : TabulaCellProvider {
    
    typealias CellClosure = ((RowViewModel) -> (TabulaTableViewCell)?)
    var cellIdentifiers = [ String : CellClosure]()
    var tempIdentifiers = [ String : TabulaTableViewCell.Type ]()

    func register(cellIdentifier: String, factoryClosure: CellClosure) {
        self.cellIdentifiers[cellIdentifier] = factoryClosure
    }
    
    func register(cellIdentifier: String, cellType: TabulaTableViewCell.Type) {
        self.tempIdentifiers[cellIdentifier] = cellType
    }

//    func register(cellIdentifier: String, factoryClosure: CellClosure) {
//        self.cellIdentifiers[cellIdentifier] = factoryClosure
//    }
    
    func cellForIdentifier(cellIdentifier: String, viewModel: RowViewModel) -> TabulaTableViewCell? {
        if let cellClosure = self.cellIdentifiers[cellIdentifier] {
            return cellClosure(viewModel)
        } else {
            return nil
        }
    }
    
    func altCellForIdentifier(cellIdentifier: String, viewModel: RowViewModel) -> TabulaTableViewCell? {
        if let cellType = self.tempIdentifiers[cellIdentifier] {
            var cell = cellType(viewModel: viewModel)
            return cell
        }
        return nil
    }
}

public class Tabula : NSObject, UITableViewDelegate, UITableViewDataSource {
   
    var sections = [TabulaSection]()
    var tableView : UITableView
    var cells : [String : UITableViewCell] = [String : UITableViewCell]()
    var cellFactory : TabulaCellProvider?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func addSection(section: TabulaSection) {
        section.tabula = self
        self.sections.append(section)
    }
    
    func addSections(sections: [TabulaSection]) {
        for section in sections {
            addSection(section)
        }
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].rows.count
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = self.cells[indexPath.description]
        var viewModel = self.sections[indexPath.section].rows[indexPath.row]
        
        if cell == nil {
            cell = self.cellForViewModel(viewModel)
            self.cells[indexPath.description] = cell
        }
        
        return cell!
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].title
    }
    
    func cellForViewModel(viewModel: RowViewModel) -> UITableViewCell {
        if let cellIdentifier = viewModel.cellIdentifier {
            if let cellFactory = self.cellFactory {
                if let cell = cellFactory.cellForIdentifier(cellIdentifier, viewModel: viewModel) {
                    return cell
                }
            }
        }
        return  UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "")
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func save() {

    }
}

public class TabulaSection {
    
    var rows = [RowViewModel]()
    var title = ""
    weak var tabula : Tabula?
    
    init(title: String = "", rows: [RowViewModel] = []) {
        self.rows = rows;
        self.title = title
    }
    
    func addRow(row: RowViewModel) {
        self.rows.append(row)
    }
    
}
