//
//  File.swift
//  
//
//  Created by Nico Prananta on 17.09.21.
//

import CoreFoundation

func timeElapsedInSecondsWhenRunningCode(operation: ()->()) -> Double {
  let startTime = CFAbsoluteTimeGetCurrent()
  operation()
  let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
  return Double(timeElapsed)
}
