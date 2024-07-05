//
//  OnFirstAppearModifier.swift
//
//
//  Created by AmrFawaz on 04/07/2024.
//

import SwiftUI

public extension View {
    func onFirstAppear(action: @escaping () async -> Void) -> some View {
        modifier(OnFirstAppearModifier(action: action))
    }
}

private struct OnFirstAppearModifier: ViewModifier {
    @State var isFirstAppear = true

    var action: () async -> Void

    func body(content: Content) -> some View {
        content
            .task {
                guard isFirstAppear else {
                    return
                }

                isFirstAppear = false
                await action()
            }
    }
}
