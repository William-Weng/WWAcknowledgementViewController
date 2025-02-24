//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2025/2/24.
//

import UIKit
import WWAcknowledgementViewController

// MARK: - ViewController
final class ViewController: UIViewController {

    private let storyboardId = "AcknowledgementVC"
    
    private let markdown = """
    # Acknowledgement
    
    ## Contributors
    - [William-Weng](https://william-weng.github.io/)
    - [Swift Package Index](https://swiftpackageindex.com/William-Weng)
    
    ## These third-party libraries are used
    |Package|License|
    |---|---|
    |[Showdown](https://github.com/showdownjs/showdown)|MIT|
    |[WWJavaScriptContext](https://github.com/William-Weng/WWJavaScriptContext/)|MIT|
    |[WWJavaScriptContext+Markdown](https://github.com/William-Weng/WWJavaScriptContext_Markdown/)|MIT|
    """
    
    @IBAction func displayHTML(_ sender: UIButton) {
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: storyboardId) as AcknowledgementViewController
        viewController.displayContent(.markdown(markdown))
        
        present(viewController, animated: true)
    }
}

// MARK: - AcknowledgementViewController
final class AcknowledgementViewController: WWAcknowledgementViewController {}
