//
//  StringGenerator.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/17/24.
//

import Foundation

struct StringGenerator {
    static func generateLongString() -> String {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }

    static func generateShortString() -> String {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }

    static func generateStringOne() -> String {
        return "Lorem ipsum"
    }

    static func generateStringTwo() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing"
    }

    static func generateStringThree() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt"
    }

    static func generateStringFour() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
    }

    static func generateRandomActivityString() -> String {
        let text = [
            StringGenerator.generateStringOne(),
            StringGenerator.generateStringTwo(),
            StringGenerator.generateStringThree(),
            StringGenerator.generateStringFour()
        ].shuffled().randomElement()!

        let ending = ["!","...",".","?",""]
        let emojiEnding = [" #NGO", " 🌎", " 🚧", " 🚜", " 🌾", " 🏥"," 🏡"]
        let stringToTrim = text

        return String(
            stringToTrim.trimmingCharacters(in: .whitespaces) + (ending.shuffled().randomElement()!)) + (Bool.random() ? "" : emojiEnding.shuffled().first!)
    }

}
