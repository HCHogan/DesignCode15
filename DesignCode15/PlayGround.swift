//
//  PlayGround.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2024/2/8.
//

import Foundation

struct Foo {
    var a: Int
    var b: Int
}

func test() -> Int {
    let a: Int = 1
    var i: Int = 1
    var s: String = "Hank"
    let arr = [1, 2, 3]
    let arr2 = (0...10).map{x in print("fuck \(x)"); return (x * x, x * 2)}
    for (i, j) in arr2 {
        print(i, j);
    }
    let (_, _) = (1, 2)
    
    return a
}

enum Bar {
    case empty, bitch, dog
}

func test2(bar: Bar) -> Int {
    switch bar {
    case .dog:
        return 1
    case .bitch:
        return 2
    case .empty:
        return 3
    }
}

func test3() {
    test2(bar: .dog)
}
