//
//  HealthKitManager.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 9/1/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager{
    let healthKitStore: HKHealthStore = HKHealthStore()
    
    func authorizeHealthKit(completion: ((_ success: Bool, _ error: NSError?) -> Void)!){
        //data type we want to read from HealthKit
        let healthDataToRead = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!)
        
        //data we want to write from HealthKit
        let healthDataToWrite = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!)
        
        //iPad
        if !HKHealthStore.isHealthDataAvailable(){
            ELog("Can't access HealthKit")
        }
        
        //request authorize to read/write data
        healthKitStore.requestAuthorization(toShare: healthDataToWrite, read: healthDataToRead, completion: { (success, error) in
            if success {
                print("Authorization complete")
            } else {
                print("Authorization error: \(String(describing: error?.localizedDescription))")
            }
        })
    }
    
    func getTodaysSteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            var resultCount = 0.0
            
            guard let result = result else {
                print("Failed to fetch steps = \(error?.localizedDescription ?? "N/A")")
                completion(resultCount)
                return
            }
            
            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.count())
            }
            
            DispatchQueue.main.async {
                completion(resultCount)
            }
        }
        
        healthKitStore.execute(query)
    }
}
