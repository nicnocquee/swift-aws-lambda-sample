//
//  File.swift
//  
//
//  Created by Nico Prananta on 17.09.21.
//
import Foundation

func findPrimesUntil(_ limit: Int) -> [Int] {
  guard limit > 1 else {
    return []
  }
  
  var numbers = Array(repeating: true, count: limit + 1)
  
  numbers[0] = false
  numbers[1] = false
  
  var primes = [Int]()
  
  for j in 2..<numbers.count {
    if numbers[j] {
      primes.append(j)
      
      for k in j..<numbers.count {
        if k * j >= numbers.count {
          break
        }
        if numbers[j * k] {
          numbers[j * k] = false
        }
      }
    }
  }
  
  return primes
}
