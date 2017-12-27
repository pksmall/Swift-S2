//
//  ViewController.swift
//  Weather20171220
//
//  Created by Pavel Korzhenko on 12/22/17.
//  Copyright © 2017 pavelkorzhenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var permission: UILabel!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let mylogin: String = "admin"
    let mypassword: String = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // добавим  жест  нажатия к   нашему  UIScrollView:
        //  жест  нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        //  присваиваем  его  UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if login.text! == mylogin && password.text! == mypassword {
            permission.text = "Access granted."
            permission.textColor = UIColor.green
            return true
        } else {
            permission.text = "Permission denied."
            permission.textColor = UIColor.red
            let alter = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
            // Создаем к нопку  для  UIAlertController
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            // Добавляем к нопку  на  UIAlertController
            alter.addAction(action)
            // показываем  UIAlertController
            present(alter, animated: true, completion: nil)
            return false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // когда клавиатура  появляется
    @objc func  keyboardWasShown(notification: Notification)  {
        //  получаем  размер к лавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        //  добавляем  отступ  внизу  UIScrollView  равный  размеру к лавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // когда к лавиатура  исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        //  устанавливаем  отступ  внизу  UIScrollView  равный  0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // подписаться на уведомления из центра уведомлений, которые рассылает клавиатура
    override func  viewWillAppear(_  animated: Bool) {
        super.viewWillAppear(animated)
        //  Подписываемся  на  два  уведомления,  одно  приходит  при  появлении к лавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown),  name: NSNotification.Name.UIKeyboardWillShow,  object:  nil)
        //  Второе к огда  она  пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)),  name:  NSNotification.Name.UIKeyboardWillHide, object:  nil)
    }
    
    // Добавим метод отписки при наступлении события исчезновения к онтроллера  с  экрана.
    override func viewWillDisappear(_  animated: Bool) {
        super.viewWillDisappear(  animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // Добавим исчезновение клавиатуры при клике по пустому  месту  на  экране.  Добавим  метод, к оторый  будет  вызываться  при к лике.
    @objc func hideKeyboard() { self.scrollView?.endEditing(true) }
    
    
}

