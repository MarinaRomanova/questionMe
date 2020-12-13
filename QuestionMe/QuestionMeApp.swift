//
//  QuestionMeApp.swift
//  QuestionMe
//
//  Created by Marina Romanova on 13/12/2020.
//

import SwiftUI

@main
struct QuestionMeApp: App {
    var body: some Scene {
        WindowGroup {
            CardStacktView().environmentObject(GameViewModel())
        }
    }
}
