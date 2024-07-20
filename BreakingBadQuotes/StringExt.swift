//
//  StringExt.swift
//  BreakingBadQuotes
//
//  Created by Anup Saud on 2024-07-19.
//

import Foundation

extension String{
    func removeSpace() -> String{
        return self.replacingOccurrences(of: " ", with: "")
    }
    func removeCaseAndSpace() -> String{
        self.removeSpace().lowercased()
    }
}
