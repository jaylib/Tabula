//
//  Operators.swift
//  SchlauerParken
//
//  Created by Josef Materi on 11.03.15.
//  Copyright (c) 2015 iPOL GmbH. All rights reserved.
//

import UIKit

infix operator |- { associativity left }

//public func |- (left: Tabula, right: TabulaSection) -> TabulaSection {
//    left.addSection(right)
//    return right
//}
//
//public func |- (left: Tabula, right: String) -> TabulaSection {
//    var section = TabulaSection(title: right)
//    left.addSection(section)
//    return section
//}
//
//public func |- (left: TabulaSection, right: CellViewModel) -> TabulaSection {
//    left.addRow(right)
//    return left
//}
//
//public func |- (left: RowViewModel, right: TabulaSection) -> TabulaSection {
//    left.section?.tabula?.addSection(right)
//    return right
//}
//
//public func |- (left: TabulaSection, right: String) -> TabulaSection {
//    var section = TabulaSection(title: right)
//    left.tabula?.addSection(section)
//    return section
//}
