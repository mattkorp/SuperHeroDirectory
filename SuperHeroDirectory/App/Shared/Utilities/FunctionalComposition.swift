//
//  FunctionalComposition.swift
//  SuperHeroDirectory
//
//  Created by Matthew Korporaal on 8/8/20.
//  Copyright © 2020 Matthew Korporaal. All rights reserved.
//
// https://www.pointfree.co/episodes/ep1-functions

import Foundation

func + <A: AnyObject>(
    f: @escaping (A) -> Void,
    g: @escaping (A) -> Void
    ) -> (A) -> Void {
    return { a in f(a); g(a) }
}
//swiftlint:enable identifier_name

precedencegroup ForwardApplication {
    associativity: left
    higherThan: AssignmentPrecedence
}

infix operator |> : ForwardApplication

/// Forward function application.
///
/// Applies the function on the right to the value on the left. Functions of >1 argument can
/// be applied by placing their arguments in a tuple on the left hand side.
///
/// This is a useful way of clarifying the flow of data through a series of functions. For example,
/// you can use this to count the base-10 digits of an integer:
///
///        let digits = 100 |> toString |> count // => 3
public func |> <T, U> (left: T, right: (T) -> U) -> U {
    right(left)
}
