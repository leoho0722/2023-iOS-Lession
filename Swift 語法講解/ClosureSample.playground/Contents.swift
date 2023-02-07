import UIKit

var closure0: (Int, String) -> Void = { num, str in
    print(str, 123 + num)
}

func functionWithClosure(abc: String, closure1: (Int) -> Void, closure2: (String) -> Void) {
    closure1(123)
    closure2("abc")
}

//functionWithClosure(closure1: closure0)
//
//functionWithClosure { num, str in
//    print(num)
//    print(str)
//    closure0(num, str)
//}

functionWithClosure(abc: "def") { num in
    print(num)
} closure2: { str in
    print(str)
}

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
let reversedNames = names.sorted { $0 > $1 }
