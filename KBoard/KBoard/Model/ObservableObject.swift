//
//  ObservableObject.swift
//  KBoard
//
//  Created by Hankyu Lee on 2022/07/28.
//

import Foundation

final class ObservableObject<T> {

    typealias Listener = (T) -> Void
    var value: T {
        didSet {
            print(value)
            listener?(value)
        }
    }

    var listener: Listener?
    
    init(_ value: T) {
        self.value = value
    }

    func bind(_ listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
    
}
