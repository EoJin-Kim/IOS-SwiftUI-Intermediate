//
//  UIViewRepresentableInter.swift
//  SwiftUIIntermediate
//
//  Created by 김어진 on 3/18/24.
//

import SwiftUI


struct FirstUIViewRepresentable: UIViewRepresentable{
    
    
    
    // UIKit 의 UIView 을 생성하는 함수
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }
    
    
    // UIKit 에 업데이트
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct UITextFieldViewRepresentabl: UIViewRepresentable{
    @Binding var text: String
    
    let placeholder: String
    let placeholderColor: UIColor
    
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor : placeholderColor,
                
            ]
        )
        textField.attributedPlaceholder = placeholder
        return textField
    }
    
    
    // coordinator 는 UIKit -> SwiftUI 로 데이터 전달 사실상 UIKit의 delegate 의 역할
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
        
    }
    
    class Coordinator: NSObject, UITextFieldDelegate{
        @Binding
        var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

struct UIViewRepresentableInter: View {
    
    @State
    private var text: String = ""
    
    var body: some View {
        VStack{
            Text(text)
            HStack{
                Text("swiftui")
                TextField("Swift ui text field",text: $text)
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(5.0)
            } //:VSTACK
            
            HStack{
                Text("UIKIT")
                UITextFieldViewRepresentabl(text: $text, placeholder: "uiKit TextField", placeholderColor: .red)
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(5)
            }
        } //:VSTACK
    }
}

#Preview {
    UIViewRepresentableInter()
}
