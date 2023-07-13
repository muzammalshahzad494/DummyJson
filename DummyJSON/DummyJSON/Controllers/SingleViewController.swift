//
//  SingleViewController.swift
//  DummyJSON
//
//  Created by Muzammal Shahzad on 6/23/23.
//

import UIKit

class SingleViewController: UIViewController {

    var data : SingleUser?
    var imageDownloader: ImageDownloader?
    private var progressView: CustomProgressView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = data?.username {
            title = "\(data)"
        }
        usernameLabel.alpha = 0.0
        
        
        progressView = CustomProgressView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 2))
        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)
        
        // Set constraints for the progress view
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 2.0)
        ])
        
        // Set initial progress
        progressView.resetProgress()
        
        
        // Perform the animation to fade in the usernameLabel
        UIView.animate(withDuration: 1.0, animations: { [self] in
            // Set the final state of the usernameLabel
            usernameLabel.text = data?.username
            usernameLabel.alpha = 1.0
        }) { [self] _ in
            // Animation completion block, start downloading the image
            downloadImage()
        }
        
    }

    @IBAction func tapUserCart(_ sender: Any) {
        if let userid = data?.id {
            NetworkService.shared.fetchUserCart(for: userid) { result in
                switch result {
                case .success(let success):
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
                    nextViewController.cartData = "\(success)"
                    self.navigationController?.pushViewController(nextViewController, animated: true)

                case .failure(let failure):
                    print(failure)
                }
            }
        }
       
    }
    
    @IBAction func tapUserPost(_ sender: Any) {
        
        if let userId = data?.id{
            NetworkService.shared.fetchUserPost(for: userId) { result in
                switch result {
                case .success(let success):
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
                    nextViewController.postData = "\(success)"
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    @IBAction func tapUserTodo(_ sender: Any) {
        if let userId = data?.id {
            NetworkService.shared.fetchUserTodo(for: userId) { result in
                switch result {
                case .success(let success):
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
                    nextViewController.todoData = "\(success)"
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }

    
    func downloadImage() {
        guard let imageUrl = URL(string: data?.image ?? "") else {
            print("Invalid image URL")
            return
        }
        
        imageDownloader = ImageDownloader()
        imageDownloader?.downloadImage(from: imageUrl, progressHandler: { [weak self] progress in
            DispatchQueue.main.async {
                self?.startProgress()
            }
        }, completionHandler: { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        })
    }
    
    // Use the progress view methods as needed
       func startProgress() {
           progressView.show()
       }
       
       func updateProgress(_ progress: Float) {
           progressView.updateProgress(progress)
       }
       
       func finishProgress() {
           progressView.hide()
       }
    
}
