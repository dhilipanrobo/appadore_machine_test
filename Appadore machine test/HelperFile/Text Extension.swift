//
//  Text Extension.swift
//  Appadore machine test
//
//  Created by Apple on 07/07/24.
//  Copyright © 2024 Dhilipan. All rights reserved.
//

import Foundation
import SwiftUI

extension Text {
    func boldStyle(color: Color = .black) -> Text {
        self.font(.system(size: 24.24, weight: .bold, design: .default))
            .foregroundColor(color)
    }
    
    func semiBoldStyle(color: Color = .black,size : CGFloat = 18.0) -> Text {
        self.font(.system(size: size, weight: .semibold, design: .default))
            .foregroundColor(color)
    }
    
    func mediumStyle(color: Color = .black,size:CGFloat) -> Text {
        self.font(.system(size: size, weight: .medium, design: .default))
            .foregroundColor(color)
    }
    func normalStyle(color: Color = .black,size:CGFloat) -> Text {
        self.font(.system(size: size, weight: .regular, design: .default))
            .foregroundColor(color)
    }
    
}

extension Double {
    var formattedAsCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "$0.00"
    }
}


extension View {
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}

struct RoundedCorner: Shape {
  
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    return Path(path.cgPath)
  }
}

