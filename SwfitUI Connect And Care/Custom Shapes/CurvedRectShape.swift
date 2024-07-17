//
//  CurvedRectShape.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/14/24.
//

import Foundation
import SwiftUI

struct CurvedRectShape: Shape {

    let cornerRadius: CGFloat
    let photoSize: CGSize

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.height - photoSize.height))
            path.addArc(
                tangent1End: CGPoint(x: rect.minX + photoSize.width, y: rect.height -  photoSize.height),
                tangent2End: CGPoint(x: rect.minX + photoSize.width, y: rect.maxY),
                radius: cornerRadius)

            path.addLine(to: CGPoint(x: rect.minX + photoSize.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }

}
