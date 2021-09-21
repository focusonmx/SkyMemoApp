//
//  CreateViewController.swift
//  SkyMemoApp
//
//  Created by 이유진 on 2021/09/13.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet weak var todayLabel: UILabel!
    

    
    @IBOutlet weak var memoTextField: UITextField!
    
    @IBOutlet weak var selectImageView: UIImageView!
    
    @IBOutlet weak var createButton: UIButton!
    
    let picker = UIImagePickerController()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        memoTextField.delegate = self
        
        setTodayDate()
        makeImageView()
        setKeyboardUpAndDown()
        
        
        
        
    }
    
    func setTodayDate(){
        //오늘 날짜로 날짜라벨 설정
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyMMdd"
    
        todayLabel.text = dateFormatter.string(from: today)
    }
    
    func makeImageView() {
        //이미지뷰를 동그랗게 만들고 처음 이미지 설정
        selectImageView.layer.masksToBounds = true
        selectImageView.layer.cornerRadius = selectImageView.frame.width/2
        selectImageView.clipsToBounds = true
        selectImageView.layer.borderColor = CGColor(red: 191.0/255, green: 232.0/255, blue: 255.0/255, alpha: 1.0)
        selectImageView.layer.borderWidth = 5
        selectImageView.image = UIImage(named: "AddIcon")
        selectImageView.contentMode = .scaleAspectFill

        //이미지뷰에 클릭이벤트 추가
        let tapGR = UITapGestureRecognizer(target:self, action: #selector(self.imageTapped))
        selectImageView.addGestureRecognizer(tapGR)
        selectImageView.isUserInteractionEnabled = true
        
        
    }
    
    func setKeyboardUpAndDown() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        
    }
    
    //이미지뷰 탭했을 때 UIImagePicker 띄우기
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended{
            
            let alert = UIAlertController(title: "하늘사진 추가하기",message: "", preferredStyle: .actionSheet)
            let library = UIAlertAction(title: "앨범에서 가져오기", style:.default){ (action) in self.openLibrary()}
            let camera = UIAlertAction(title: "카메라로 촬영하기", style: .default){ (action) in self.openCamera()}
            
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(library)
            alert.addAction(camera)
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    //갤러리에서 사진 가져오기
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    //카메라에서 찍어서 가져오기
    func openCamera() {
        
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
            
        }
        else{
            print("Camera not available")
        }
        
        
    }
    
    @objc func keyboardWillShow(_ sender:Notification){
        self.view.frame.origin.y = -180
    }
    
    @objc func keyboardWillHide(_ sender:Notification){
        self.view.frame.origin.y = 0
    }
    
    @objc func endEditing(){
        memoTextField.resignFirstResponder()
    }
    
}

extension CreateViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        memoTextField.resignFirstResponder()
        return true
    }
    
    //텍스트 필드 최대 문자수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if (textField.text?.count)! + string.count > 20 {
                
                return false
            } else {
                return true
            }
    
    }
    
}

//imagepickercontroller를 위한 delegate
extension CreateViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            selectImageView.image = image
            
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
 
}
