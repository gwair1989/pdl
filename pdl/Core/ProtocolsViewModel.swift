//
//  ProtocolsViewModel.swift
//  pdl
//
//  Created by Oleksandr Khalypa on 05.09.2022.
//

import SwiftUI

protocol ProtocolsViewModel {
    func getWidthEqualScreen(_ currentWidth: CGFloat) -> CGFloat
}

extension ProtocolsViewModel {
    func getWidthEqualScreen(_ currentWidth: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let ratio: CGFloat = currentWidth / 390
        let widthEqualScreen = screenWidth * ratio
        return widthEqualScreen
    }
}
