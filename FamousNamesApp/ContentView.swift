//
//  ContentView.swift
//  FamousNamesApp
//
//  Created by Mark Powell on 11/29/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .onAppear {
                Task {
                    do {
                        try await doMusicWork()
                    } catch let error {
                        print("\(error.localizedDescription)")
                    }

                }
            }
    }

    func doMusicWork() async throws {
        let goodChars = "earthsign"
        let nameUrl = Bundle.main.url(forResource: "tracks_per_year", withExtension: "txt")!
        let nameLines = nameUrl.lines
        var nameIt = nameLines.makeAsyncIterator()
        var line = try await nameIt.next() // skip header
        while line != nil {
            line = try await nameIt.next()
            if let line = line {
                let parts = line.components(separatedBy: "<SEP>")
                let primaryTitle = parts[3].lowercased() // get primary title
                let words = primaryTitle.components(separatedBy: " ")
                if words.count != 4 {
                    continue
                }
                let allWords = "\(words[0])\(words[1])\(words[2])\(words[3])"
                if allWords.count != 19 {
                    continue
                }
                var badChars = false
                for chr in allWords {
                    if chr.isPunctuation {
                        continue
                    }
                    if !goodChars.contains(chr) {
                        badChars = true
                        break
                    }
                }
                if badChars {
                    continue
                }
                print(primaryTitle)
            }
        }
    }

    func doMovieWork() async throws {
        let goodChars = "earthsign"
        let nameUrl = Bundle.main.url(forResource: "title.basics", withExtension: "tsv")!
        let nameLines = nameUrl.lines
        var nameIt = nameLines.makeAsyncIterator()
        var line = try await nameIt.next() // skip header
        while line != nil {
            line = try await nameIt.next()
            if let line = line {
                let parts = line.components(separatedBy: "\t")
                let primaryTitle = parts[2].lowercased() // get primary title
                let words = primaryTitle.components(separatedBy: " ")
                if words.count != 4 {
                    continue
                }
                let allWords = "\(words[0])\(words[1])\(words[2])\(words[3])"
                if allWords.count != 15 {
                    continue
                }
                var badChars = false
                for chr in allWords {
                    if chr.isPunctuation {
                        continue
                    }
                    if !goodChars.contains(chr) {
                        badChars = true
                        break
                    }
                }
                if badChars {
                    continue
                }
                print(primaryTitle)
            }
        }
    }
}
