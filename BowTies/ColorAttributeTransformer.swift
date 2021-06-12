//
//  ColorAttributeTransformer.swift
//  BowTies
//
//  Created by Anon Account on 12.06.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import UIKit

class ColorAttributeTransformer: NSSecureUnarchiveFromDataTransformer {

  override static var allowedTopLevelClasses: [AnyClass] {
    [UIColor.self]
  }
  
  static func register() {
    let className = String(describing: ColorAttributeTransformer.self)
    let name = NSValueTransformerName(className)
    let transformer = ColorAttributeTransformer()
    ValueTransformer.setValueTransformer(transformer, forName: name)
  }
  
}
