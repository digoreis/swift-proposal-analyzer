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

public final class Analyzer {

    public static let shared = Analyzer(directory: #fileLiteral(resourceName: "proposals"))

    public let proposals: [Proposal]

    public lazy var authors: [Author] = {
        var allAuthors = Set<Author>()
        for p in self.proposals {
            for a in p.authors {
                allAuthors.insert(a)
            }
        }
        return Array<Author>(allAuthors).sorted()
    }()

    private let directory: URL

    public init(directory: URL) {
        self.directory = directory
        self.proposals = parseProposals(inDirectory: directory)
    }
}

extension Analyzer {

    public func proposalsWith(status statuses: [Status]) -> [Proposal] {
        return proposals.filter { prop -> Bool in
            return statuses.contains(prop.status)
        }
    }

    public func proposalsWith(status statuses: Status...) -> [Proposal] {
        return proposals.filter { prop -> Bool in
            return statuses.contains(prop.status)
        }
    }

    public func proposalsPerStatus() -> [Status : [Proposal]] {
        var dict = [Status : [Proposal]]()
        for status in Status.allItems {
            let proposals = proposalsWith(status: status)
            if proposals.count > 0 {
                dict[status] = proposals
            }
        }
        return dict
    }

    public func proposalStatus() -> [String] {
        var stats = [String]()
        let dict = proposalsPerStatus()
        for (status, proposals) in dict {
            var str = "\(status): \(proposals.count)\n"
            str += proposals.map { $0.seNumber }.joined(separator: ", ")
            stats.append(str)
        }
        return stats.sorted()
    }

    public func occurrences(of text: String) -> Int {
        var count = 0
        for p in proposals {
            count += p.occurrences(of: text)
        }
        return count
    }
}
