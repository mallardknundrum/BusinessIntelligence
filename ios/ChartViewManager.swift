//
//  ChartViewManager.swift
//  BusinessIntelligence
//
//  Created by Jeremiah Hawks on 7/14/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation

@objc(ChartViewManager)
class ChartViewManager: RCTViewManager {
  override func view() -> UIView! {
    return ChartView()
  }
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
