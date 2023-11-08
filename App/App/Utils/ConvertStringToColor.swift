//
//  ColorTransformation.swift
//  App
//
//  Created by Thanh Hien on 02/11/2023.
//

import Foundation
import SwiftUI
class ConvertStringToColor {
    func convertStringToColor(color: String) -> Color {
        switch color {
               case "Đỏ", "đỏ", "red", "Red":
                   return Color("EE0000")
               case "Xanh lá cây", "xanh lá cây", "green", "Green":
                   return Color("00EE00")
               case "Xanh da trời", "blue", "Blue":
                   return Color("00BFFF")
               case "Vàng", "yellow", "Yellow":
                   return Color("EEEE00")
               case "Trắng", "white", "White":
                   return Color("FFFFFF")
               case "Đen", "black", "Black":
                   return Color("000000")
               case "Hồng", "pink", "Pink":
                   return Color("FF1493")
               case "Xám", "gray", "Gray":
                   return Color("808080")
               case "Tím", "purple", "Purple":
                   return Color("EE82EE")
               case "Cam", "orange", "Orange":
                   return Color("FFA500")
               case "Nâu", "brown", "Brown":
                   return Color("A52A2A")
               case "Xanh nước biển","sea green":
                   return Color("0000EE")
               default:
                   return Color.black // Màu mặc định
        }
    }
}
