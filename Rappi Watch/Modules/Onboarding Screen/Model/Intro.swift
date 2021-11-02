//
//  Intro.swift
//  Rappi Watch
//
//  Created by Bryan Caro on 11/2/21.
//

import Foundation

struct Intro: Identifiable{
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
}

var intros: [Intro] = [
    Intro(image: "screen_once", title: "first_onboarding_title".localized, description: "first_onboarding_description".localized),
    Intro(image: "screen_two", title: "second_onboarding_title".localized, description: "second_onboarding_description".localized)
]
