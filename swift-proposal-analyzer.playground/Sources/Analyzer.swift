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
    private let directory: URL

    public init(directory: URL) {
        self.directory = directory
        self.proposals = parseProposals(inDirectory: directory)
    }
}