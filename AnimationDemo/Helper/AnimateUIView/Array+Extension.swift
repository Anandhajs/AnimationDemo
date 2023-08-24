//
//  Array+Extension.swift
//  AnimationDemo
//
//  Created by Sparkout on 24/08/23.
//

import Foundation
extension Array {
    /// Creates an array containing all combinations of two arrays.
    static func createAllCombinations<T, U>( from lhs: Array<T>,
        and rhs: Array<U>) -> Array<(T, U)> {
        let result: [(T, U)] = lhs.reduce([]) { (accum, t) in
            let innerResult: [(T, U)] = rhs.reduce([]) { (innerAccum, u) in
                return innerAccum + [(t, u)]
            }
            return accum + innerResult
        }
        return result
    }
}
