//
//  UIView+PinEdges.swift
//  vk-api-project
//
//  Created by Nikita Artamonov on 10.09.2022.
//

import UIKit

extension UIView {
    
    func pinEdgesToSuperView(_ distance: CGFloat = 0) {
        
        guard let superview = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: distance),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: distance),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: distance),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: distance)
        ])
    }
    
    func pinEdgesToSuperView(top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        
        guard let superview = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: right)
        ])
    }
    
}
