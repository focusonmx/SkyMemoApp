//
//  EditViewController.swift
//  SkyMemoApp
//
//  Created by 이유진 on 2021/09/13.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var removeButton: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dateLabel.text="210903"
        textField.text = "오늘하늘 너무 이쁘다 >_<"
        
        picker.delegate = self
        textField.delegate = self
   
        makeImageView()
        setKeyboardUpAndDown()
        
    }
    

    func makeImageView() {
        //이미지뷰를 동그랗게 만들고 처음 이미지 설정
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.clipsToBounds = true
        imageView.layer.borderColor = CGColor(red: 191.0/255, green: 232.0/255, blue: 255.0/255, alpha: 1.0)
        imageView.layer.borderWidth = 5
        imageView.image = UIImage(named: "SampleSky1.png")
        imageView.contentMode = .scaleAspectFill

        //이미지뷰에 클릭이벤트 추가
        let tapGR = UITapGestureRecognizer(target:self, action: #selector(self.imageTapped))
        imageView.addGestureRecognizer(tapGR)
        imageView.isUserInteractionEnabled = true
        
        
    }
    
    func setKeyboardUpAndDown() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        
    }
    
    //이미지뷰 탭했을 때 UIImagePicker 띄우기
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended{
            
            let alert = UIAlertController(title: "하늘사진 수정하기",message: "", preferredStyle: .actionSheet)
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
        textField.resignFirstResponder()
    }

}

extension EditViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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

extension EditViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            imageView.image = image
            
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
 
}
