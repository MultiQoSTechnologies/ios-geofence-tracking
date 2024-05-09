//
//  AppLogs.swift
//  noble
//
//  Created by MQF-1 on 14/08/23.
//

import Foundation

class AppLogs {
    static func debugPrint(_ message: Any = "") {
#if DEBUG
        print(message)
#endif
    }
}
