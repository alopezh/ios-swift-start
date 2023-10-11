//
//  AlertErrorViewModifier.swift
//  ios-swift-start
//
//  Created by Jorge Martinez on 20/01/23.
//  Copyright © 2023 com.minsait. All rights reserved.
//

import SwiftUI

struct AlertErrorViewModifier: ViewModifier {
	@Binding var isPresented: Bool
	var error: Error?
	var defaultMessage: String?
	
	init(isPresented: Binding<Bool>, error: Error?, defaultMessage: String? = nil) {
		self._isPresented = isPresented
		self.error = error
		self.defaultMessage = defaultMessage
	}
	
	func body(content: Content) -> some View {
			content
			.alert(isPresented: $isPresented) {
				Alert(title: Text( defaultMessage ?? error?.localizedDescription ?? "Error"))
			}
		}
}

extension View {
	func alertError(isPresented: Binding<Bool>, error: Error?, defaultMessage: String? = nil) -> some View {
		modifier(AlertErrorViewModifier(isPresented: isPresented, error: error, defaultMessage: defaultMessage))
	}
}
