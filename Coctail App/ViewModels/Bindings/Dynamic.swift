//
//  Dynamic.swift
//  Coctail App
//
//  Created by Dmitry Sankovsky on 24.06.22.
//

import Foundation

class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T){
        value = v
    }
}
