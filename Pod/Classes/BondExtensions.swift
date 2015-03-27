//
//  BondExtensions.swift
//  TabulaTests
//
//  Created by Josef Materi on 21.03.15.
//  Copyright (c) 2015 iPOL GmbH. All rights reserved.
//

import Bond

infix operator <<- { associativity left }
infix operator ->> { associativity left }
infix operator  <<->> { associativity left }

public func <<-<T>(left: Dynamic<T>, right: T) {
    left.value = right
}

public func <<-<T>(inout left: T, right: Dynamic<T>) {
    pointerBind(&left, right)
}

public func <<->><T>(inout left: T, right: Dynamic<T>) {
    right.value = left
    pointerBind(&left, right)
}

public func <<->><T>(left: Dynamic<T>, inout right: T) {
    left.value = right
    pointerBind(&right, left)
}

public func pointerBind<T>(left: UnsafeMutablePointer<T>, right: Dynamic<T>) {
    observe(right) { v in
        left.memory = v
    }
}

func observe<T>(value: Dynamic<T>, onChange: ((T) -> () )) {
    var dynamic = Dynamic<T>(value.value)
    value ->> dynamic
    var bond = Bond<T>()
    dynamic.valueBond.listener = onChange
    dynamic.bindTo(dynamic.valueBond, fire: true, strongly: true)
}
