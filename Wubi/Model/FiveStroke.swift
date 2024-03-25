//
//  FiveStroke.swift
//  Wubi
//
//  Created by yongyou on 2021/1/27.
//  Copyright © 2021 sakuragi. All rights reserved.
//

import Foundation

struct FiveStroke {
    static let components: Dictionary = ["a": ["a","a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a11","a12","a13","a14"],
                                  "b": ["b","b1","b2","b3","b4","b5","b6","b7","b8","b9","b10","b11","b12","b13","b14","b15"],
                                  "c": ["c","c1","c2","c3","c4","c5","c6","c7","c8"],
                                  "d": ["d","d1","d2","d3","d4","d5","d6","d7","d8","d9","d10","d11","d12"],
                                  "e": ["e","e1","e2","e3","e4","e5","e6","e7","e8","e9","e10","e11","e12","e13","e14","e15","e16"],
                                  "f": ["f","f1","f2","f3","f4","f5","f6","f7","f8","f9","f10","f11","f12","f13"],
                                  "g": ["g","g1","g2","g3","g4","g5","g6","g7","g8","g9"],
                                  "h": ["h","h1","h2","h3","h4","h5","h6","h7","h8","h9","h10","h11"],
                                  "i": ["i","i1","i2","i3","i4","i5","i6","i7","i8","i9","i10","i11","i12","i13"],
                                  "j": ["j","j1","j2","j3","j4","j5","j6","j7","j8","j9","j10","j11","j12"],
                                  "k": ["k","k1","k2","k3","k4"],
                                  "l": ["l","l1","l2","l3","l4","l5","l6","l7","l8","l9"],
                                  "m": ["m","m1","m2","m3","m4","m5","m6","m7","m8","m9"],
                                  "n": ["n","n1","n2","n3","n4","n5","n6","n7","n8","n9","n10","n11","n12","n13","n14","n15","n16"],
                                  "o": ["o","o1","o2","o3","o4","o5","o6","o7","o8","o9"],
                                  "p": ["p","p1","p2","p3","p4","p5","p6","p7"],
                                  "q": ["q","q1","q2","q3","q4","q5","q6","q7","q8","q9","q10","q11","q12","q13","q14","q15","q16","q17"],
                                  "r": ["r","r1","r2","r3","r4","r5","r6","r7","r8","r9","r10"],
                                  "s": ["s","s1","s2","s3","s4","s5","s6"],
                                  "t": ["t","t1","t2","t3","t4","t5","t6","t7"],
                                  "u": ["u","u1","u2","u3","u4","u5","u6","u7","u8","u9","u10","u11","u12","u13","u14","u15","u16","u17"],
                                  "v": ["v","v1","v2","v3","v4","v5","v6","v7","v8","v9","v10"],
                                  "w": ["w","w1","w2","w3","w4","w5","w6","w7","w8"],
                                  "x": ["x","x1","x2","x3","x4","x5","x6","x7","x8","x9","x10","x11","x12","x13"],
                                  "y": ["y","y1","y2","y3","y4","y5","y6","y7","y8","y9","y10","y11","y12"]]


    var key: String = "a"

    var imageName: String = "a1"

    var tipsImageName: String {
        get {
            return "\(key)_keyboard"
        }
    }

    mutating func random() {
        self.key = FiveStroke.components.randomElement()?.key ?? "a"
        self.imageName = self.randomImageName(key: self.key)
    }

    func randomImageName(key: String) -> String {
        return (FiveStroke.components[key]?.randomElement())!
    }
}
