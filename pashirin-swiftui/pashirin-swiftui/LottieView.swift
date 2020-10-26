//
//  LottieView.swift
//  Animation
//
//  Created by Eri Koyano on 2020/10/13.
//
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable{
    @State var filename:String
    func makeUIView(context:
            UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        //LottieView
        let animationView = AnimationView()
        let animation = Animation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .repeat(.infinity)
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
                        animationView.widthAnchor.constraint(equalTo:
                            view.widthAnchor),
                        animationView.heightAnchor.constraint(equalTo:
                             view.heightAnchor)
        ])
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    typealias UIViewType = UIView
}
