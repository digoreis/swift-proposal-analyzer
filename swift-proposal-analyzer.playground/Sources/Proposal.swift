//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  GitHub
//  https://github.com/jessesquires/swift-proposal-analyzer
//
//
//  License
//  Copyright © 2016 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import Foundation


public struct Proposal {
    public let title: String
    public let seNumber: String
    public let fileName: String
    public let authors: [String]
    public let status: String

    public init(title: String, seNumber: String, fileName: String, authors: [String], status: String) {
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.seNumber = seNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        self.fileName = fileName.trimmingCharacters(in: .whitespacesAndNewlines)
        self.authors = authors
        self.status = status.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}


extension Proposal: CustomStringConvertible {
    public var description: String {
        return seNumber + ": " + title
            + "\nAuthor(s): " + authors.joined(separator: ", ")
            + "\nStatus: " + status
            + "\n"
    }
}


fileprivate let baseURL: URL = URL(string: "https://github.com/apple/swift-evolution/blob/master/proposals")!
extension Proposal {
    public var githubURL: URL {
        return baseURL.appendingPathComponent(fileName)
    }
}


extension Proposal {
    public var number: Int {
        let start = seNumber.index(seNumber.startIndex, offsetBy: 3)
        let str = seNumber.substring(from: start)
        return Int(str)!
    }
}
