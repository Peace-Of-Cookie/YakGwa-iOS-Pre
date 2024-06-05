//
//  File.swift
//  
//
//  Created by Ekko on 6/4/24.
//

import UIKit
import Combine

/// ScrollView를 가지고 있는 VC에서 키보드가 올라오면 이를 감지하고 화면의 위치를 자동 조절
public protocol KeyboardReactable: AnyObject {
  var scrollView: UIScrollView! { get set }
  var cancelBag: Set<AnyCancellable> { get set }
}

public extension KeyboardReactable where Self: UIViewController {
  func setTapGesture() {
      let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
      tap.cancelsTouchesInView = false
      view.addGestureRecognizer(tap)
  }
  
  // 키보드가 올라간 만큼 화면도 같이 스크롤
  func setKeyboardNotification() {
    let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
    let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
    
    
    keyboardWillShow.sink { noti in
      self.handleKeyboardWillShow(noti)
    }.store(in: &cancelBag)
    
    keyboardWillHide.sink { noti in
      self.handleKeyboardWillHide()
    }.store(in: &cancelBag)
  }
  
  private func handleKeyboardWillShow(_ notification: Notification) {
      guard let userInfo = notification.userInfo,
          let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
              return
      }

      let contentInset = UIEdgeInsets(
          top: 0.0,
          left: 0.0,
          bottom: keyboardFrame.size.height,
          right: 0.0)
      scrollView.contentInset = contentInset
      scrollView.scrollIndicatorInsets = contentInset
  }

  private func handleKeyboardWillHide() {
      let contentInset = UIEdgeInsets.zero
      scrollView.contentInset = contentInset
      scrollView.scrollIndicatorInsets = contentInset
  }
}
