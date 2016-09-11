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

    public let proposals: [Proposal]

    public lazy var authors: [String] = {
        var allAuthors = Set<String>()
        for p in self.proposals {
            for a in p.authors {
                allAuthors.insert(a)
            }
        }
        return Array<String>(allAuthors).sorted()
    }()

    public lazy var proposalsPerAuthor: NSCountedSet = {
        var allAuthors = NSCountedSet()
        for p in self.proposals {
            allAuthors.addObjects(from: p.authors)
        }
        return allAuthors
    }()

    private let directory: URL

    public init(directory: URL) {
        self.directory = directory
        self.proposals = parseProposals(inDirectory: directory)
    }
}
