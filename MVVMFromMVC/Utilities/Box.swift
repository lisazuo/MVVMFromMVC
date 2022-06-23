//
//  Box.swift
//  MTest
//
//  Created by lisa on 20/06/22.
//

import Foundation
final class Box<T> {
  //1
  typealias Listener = (T) -> Void
  var listener: Listener?
  //2
  var value: T {
    didSet {
      listener?(value)
    }
  }
  //3
  init(_ value: T) {
    self.value = value
  }
  //4
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}

//Each Box can have a Listener that Box notifies when the value changes.
//Box has a generic type value. The didSet property observer detects any changes and notifies Listener of any value update.
//The initializer sets Box‘s initial value.
//When a Listener calls bind(listener:) on Box, it becomes Listener and immediately gets notified of the Box‘s current value.
