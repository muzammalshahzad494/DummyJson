//
//  ImageDownloader.swift
//  DummyJSON
//
//  Created by Muzammal Shahzad on 6/26/23.
//

import UIKit


class ImageDownloader: NSObject, URLSessionDownloadDelegate {
    var progressHandler: ((Float) -> Void)?
    var completionHandler: ((UIImage?) -> Void)?
    
    func downloadImage(from url: URL, progressHandler: ((Float) -> Void)?, completionHandler: ((UIImage?) -> Void)?) {
        self.progressHandler = progressHandler
        self.completionHandler = completionHandler
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let imageData = try? Data(contentsOf: location), let image = UIImage(data: imageData) {
            completionHandler?(image)
        } else {
            completionHandler?(nil)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        progressHandler?(progress)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            // Handle the error here
            print("Error downloading image: \(error)")
            completionHandler?(nil)
        }
    }
}
