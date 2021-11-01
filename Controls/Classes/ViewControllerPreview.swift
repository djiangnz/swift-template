//
//  ViewControllerPreview.swift
//  Controls
//
//  Created by djiang on 10/10/21.
//

#if DEBUG
import SwiftUI

struct ViewControllerPreview<VC: UIViewController>: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        VC()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
#endif
