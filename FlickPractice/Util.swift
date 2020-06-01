//
//  Util.swift
//  FlickPractice
//
//  Created by 김동준 on 2020/05/25.
//  Copyright © 2020 김동준. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit
import RxCocoa
import RxSwift

struct Util {
    func checkNetwork()->String{
    if(Util().isInternetAvailable()){
        return "connect"
    }else{
        return "disconnect"
    }
    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()

        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {

            return false

        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }    
    
}
