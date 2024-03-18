//
//  UIViewControllerRepresentablInter.swift
//  SwiftUIIntermediate
//
//  Created by kej on 3/18/24.
//

import SwiftUI

struct FirstUIVewControllerRepresentable: UIViewControllerRepresentable{
    
    let labelText: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIViewController()
        
        vc.view.backgroundColor = .green
        
        let label = UILabel()
        label.text = labelText
        label.textColor = UIColor.black
        label.frame = vc.view.frame
        
        vc.view.addSubview(label)
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct UIViewControllerRepresentablInter: View {
    
    @State
    private var showScreen: Bool = false
    
    @State
    private var seletedImage: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 20){
            
            if let seletedImage = seletedImage{
                Image(uiImage: seletedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            }else{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
            }
            Button(
                action: {
                    showScreen.toggle()
                }, label: {
                    Text("사진 선택하기")
                        .withDefaultButtonFormat(backgroundColor: .red)
                }
            ).sheet(isPresented: $showScreen){
//                FirstUIVewControllerRepresentable(labelText: "UIVewController 연결됨")
                UIIMagePickerControllerRepresentable(image: $seletedImage, showScreen: $showScreen)
            }
        }//: VStack
    }
}


struct UIIMagePickerControllerRepresentable: UIViewControllerRepresentable{
    @Binding
    var image: UIImage?
    @Binding
    var showScreen: Bool
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let vc = UIImagePickerController()
        vc.delegate = context.coordinator
        vc.allowsEditing = false
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator{
        return Coordinator(image: $image, showScreen: $showScreen)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
        @Binding
        var image: UIImage?
        @Binding
        var showScreen: Bool
        
        init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let newImage = info[.originalImage] as? UIImage else { return }
            
            image = newImage
            
            showScreen = false
        }
    }
}

#Preview {
    UIViewControllerRepresentablInter()
}
