//
//  Extensions.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/26/21.
//

import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }

    var height: CGFloat {
        return frame.size.height
    }

    var left: CGFloat {
        return frame.origin.x
    }

    var right: CGFloat {
        return left + width
    }

    var top: CGFloat {
        return frame.origin.y
    }

    var bottom: CGFloat {
        return top + height
    }
}

extension Data {
    var printPrettyJSON: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let printPrettyJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return printPrettyJSON
    }
}


