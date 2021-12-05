//
//  BatchProcessing.swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 02/12/2021.
//

import Foundation



final class BatchProcessing {
    static func process<T>(_ all: [T], batchSize: Int, pipe:@escaping (([T]) -> Void) , done: @escaping (() -> Void)) {
        
        let count = all.count
        var batch = [T]()
        let batchCount = all.count / batchSize
        var batchIndex = 1
        let queue = DispatchQueue.init(label: "batch-processing", attributes: .concurrent)
        let semaphore = DispatchSemaphore.init(value: 5)
        
        
        
        for index in 0..<count {
            batch.append(all[index])
            
            let count = index + 1
            let valid = count == batchSize * batchIndex
            
            if valid {
                batchIndex += 1
                
                queue.async {
                    
                    semaphore.wait()
                    DispatchQueue.main.async {
                        pipe(batch)
                        batch.removeAll()
                        semaphore.signal()
                        
                        if index == count - 1 {
                            Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: {_ in
                                done()
                            })
                        }
                    }
                }
            }
        }
    }
}




enum Resource {
    case shared
    case none
}

final class Task {
    private let resource : Resource
    private let queue : DispatchQueue
    private let semaphore : DispatchSemaphore
    
    
    
    init(label: String, resource : Resource, kMaxConcurrent : Int = 3) {
        self.resource = resource
        self.queue = DispatchQueue.init(label: label, attributes: .concurrent)
        self.semaphore = DispatchSemaphore.init(value: kMaxConcurrent)
    }
    
    
    func async<R>(operation: @escaping (() -> R), main: @escaping ((R) -> Void)) {
        switch resource {
        case .none :
            self.asyncWithoutResource(operation: operation, main: main)
        case .shared :
            self.asyncWithResource(operation: operation, main: main)
        }
    }
}



fileprivate extension Task {
    
    func asyncWithoutResource<R>(operation: @escaping (() -> R), main: @escaping ((R) -> Void)) {
        queue.async {
            let value = operation()
            DispatchQueue.main.async {
                main(value)
            }
        }
    }
    
    
    func asyncWithResource<R>(operation: @escaping (() -> R), main: @escaping ((R) -> Void)) {
        queue.async {
           // guard let self = self else { return }
            
            self.semaphore.wait()
            let value = operation()
            DispatchQueue.main.async {
                main(value)
                self.semaphore.signal()
            }
        }
    }
}
