//: Playground - noun: a place where people can play

import UIKit
import Darwin

let pi = M_PI

var str = "Hello, playground"

var compassReading:Double = 0

func compass(x1:Double, y1:Double, x2:Double, y2:Double) {
    
    var radians = atan2((y2 - y1), (x2 - x1));
    
    compassReading = radians * (180 / pi);
    
}

compass(50.963467, 5.348901, 50.959358, 5.363664)



println(compassReading)



