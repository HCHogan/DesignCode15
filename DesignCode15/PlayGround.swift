//
//  PlayGround.swift
//  DesignCode15
//
//  Created by Hank Hogan on 2024/2/8.
//

import Foundation
import Alamofire

func connect() {
    let url = "http://47.115.205.46:5000/api/cas_login/nnu"
    let parameters: [String: Any] = [
        "username": "21220513",
        "password": "283511"
    ]

    AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Response: \(value)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
}

struct Foo {
    var a: Int
    var b: Int

    init(a: Int, b: Int) {
        self.a = a
        self.b = b
    }
}

class Foo2 {
    var a: Int

    init(_ a: Int) {
        self.a = a
    }
}

struct Foo3<Element> 
where
    Element: Equatable
{
    var a: Element
}

protocol Moveable {
    func move(by: Int)
    var hasMoved: Bool { get }
    var distanceFromStart: Int { get set }
}

enum Result<T, E> {
    case Ok(T)
    case Error(E)
}

func test() -> Int {
    var arr3 = Array([1, 2, 3]);
    let a: Int = 1
    var i: Int = 1
    var s: String = "Hank"
    let arr = [1, 2, 3]
    let arr2 = (0...10).map{x in print("fuck \(x)"); return (x * x, x * 2)}
    for (i, j) in arr2 {
        print(i, j);
    }
    let (_, _) = (1, 2)
    var f = Foo2(1);
    
    return a
}

enum Bar {
    case empty, bitch, dog
}

func test2(_ bar: Bar) -> Int {
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
    test2(.dog)
    test2(.bitch)
    var f = test4;
}

func test4(f: (Int, Int) -> Bool) {
    let _ = f(1, 0)
}

func testFFI() -> String {
    rustGreeting(text: "swift")
}
