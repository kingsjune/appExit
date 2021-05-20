//
//  Extension.swift
//  SSOSample
//
//  Created by BHJ on 2021/04/29.
//
import Foundation
import UIKit

// MARK: ViewController
extension UIViewController {
    enum ToastAlignment {
        case bottom, center
    }
    
    /**
     Toast message 보여주기
     - parameter message: 보여줄 메시지
     - parameter font: message에 적용된 폰트
     - parameter align: message의 위치
     - parameter completion: toast 노출 이후 콜백
     */
    func showToast(message : String, font: UIFont = UIFont(name: "NanumBarunGothic", size: 15) ?? UIFont.systemFont(ofSize: 15), align:ToastAlignment = .bottom, completion: @escaping (Bool) -> Void) {
        let toastLabel = EdgeInsetLabel()
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 8;
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        toastLabel.leftTextInset = 10
        toastLabel.rightTextInset = 10
        toastLabel.topTextInset = 8
        toastLabel.bottomTextInset = 8
        
        self.view.addSubview(toastLabel)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        if align == .bottom {
            let bottomConstant:CGFloat = -60
            if #available(iOS 11.0, *) {
                toastLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: bottomConstant).isActive = true
            } else {
                toastLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: bottomConstant).isActive = true
            }
        } else if align == .center {
            toastLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
        
        toastLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20).isActive = true
        toastLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: 20).isActive = true
        
        UIView.animate(withDuration: 0.2, delay: 2, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            completion(isCompleted)
        })
    }
    
    func appExit() {
        self.showToast(message: "앱을 종료합니다.") { _ in
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(0)
            }
        }
    }
}
