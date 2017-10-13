
import UIKit
import Vision
import CoreML


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    @IBAction func onButtonPress(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = true

        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            classify(image)
        }

        dismiss(animated: true, completion: nil)
    }

    func classify(_ image: UIImage) {
        let model = MobileNet()

        if
            let pixelBuffer = image.pixelBuffer(width: 224, height: 224),
            let prediction = try? model.prediction(image: pixelBuffer)
        {
            label.text = "It's a \(prediction.classLabel)"
            print(prediction.classLabel)
        }
    }

}

