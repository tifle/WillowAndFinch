//
//  CustomTextEditor.swift
//  WillowAndFinch
//
//  Created by Yanelly Mego on 5/11/25.
//

import Foundation
import SwiftUI


struct CustomTextEditor: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.text = text
        textView.font = UIFont(name: "Georgia", size: 25)
        textView.backgroundColor = .clear
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 3
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 5, bottom: 5, right: 5)
        
        textView.delegate = context.coordinator
         
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject,    UITextViewDelegate {
        var text: Binding<String>

        init(text: Binding<String>) {
            self.text = text
        }
        
        // updates text when the text view changes
        func textViewDidChange(_ textView: UITextView) {
            text.wrappedValue = textView.text
        }
    }
}
