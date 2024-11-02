//
//  custom_ui_control.swift
//  ui_paste_component
//
//  Created by Shahzod Atabayev on 09/08/24.
//

import Foundation

@available(iOS 16.0, *)
class CustomPasteControl: UIPasteControl {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Traverse the view hierarchy to find and customize the label
        if let label = findLabel(in: self) {
            label.font = UIFont.systemFont(ofSize: 2)
            label.textColor = .red
        }
    }
    
    private func findLabel(in view: UIView) -> UILabel? {
        for subview in view.subviews {
            if let label = subview as? UILabel {
                return label
            } else if let found = findLabel(in: subview) {
                return found
            }
        }
        return nil
    }
}
