//
//  Dictionary+Extension.swift
//  VirgoProject
//
//  Created by Administrator on 24/05/22.
//

import Foundation

extension Dictionary {
    var convertQueryString: String {
        let urlParams = self.compactMap ({ (key, value) -> String in
            return "\(key)=\(value)"
        }).sorted().joined(separator: "&")
        return "?\(urlParams)"
    }
}
