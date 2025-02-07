//
//  StylesManager.swift
//  Doordie
//
//  Created by Arseniy on 04.02.2025.
//

import UIKit

struct Style: Decodable {
    var name: String
    var backgroundColor: String
    var cornerRadius: CGFloat
}

final class StylesManager {
    func style(for name: String) -> Style? {
        guard
            let path = Bundle.main.path(forResource: "Styles", ofType: "txt"),
            let data = try? String(contentsOfFile: path, encoding: .utf8).data(using: .utf8),
            let styles = try? JSONDecoder().decode([Style].self, from: data)
        else {
            return nil
        }
        
        for style in styles where style.name == name {
            return style
        }
        
        return nil
    }
}
