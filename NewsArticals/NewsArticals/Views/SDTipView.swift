//
//  SDTipView.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 02/03/25.
//
import TipKit

struct ShowTransalationTip: Tip {
    var title: Text {
        Text("You can see the translation")
    }

    var message: Text? {
        Text("Tap the translation button to see the translation")
    }

    var image: Image? {
        Image(systemName: "globe")
    }
}
