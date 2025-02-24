//
//  WWAcknowledgementViewController.swift
//  WWAcknowledgementViewController
//
//  Created by William.Weng on 2025/2/24.
//

import UIKit
import JavaScriptCore
import WebKit
import WWJavaScriptContext
import WWJavaScriptContext_Markdown

// MARK: - 簡單的感謝文字顯示
open class WWAcknowledgementViewController: UIViewController {
    
    private var webView: WKWebView!
        
    open override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
}

// MARK: - WKNavigationDelegate, WKUIDelegate
extension WWAcknowledgementViewController: WKNavigationDelegate, WKUIDelegate {}
public extension WWAcknowledgementViewController {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else { decisionHandler(.cancel); return }
                
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            decisionHandler(.cancel); return
        }
        
        decisionHandler(.allow)
    }
}

// MARK: - 公開函式
public extension WWAcknowledgementViewController {
    
    /// 顯示內容
    /// - Parameter type: ContentType
    func displayContent(_ type: ContentType) {
        
        switch type {
        case .html(let html): displayHTML(html)
        case .markdown(let markdown): displayMarkdown(markdown)
        }
    }
}

// MARK: - 小工具
private extension WWAcknowledgementViewController {
    
    /// [WebView初始化設定](https://zh.pngtree.com/freebackground/simple-thanksgiving-wallpaper-wind-thanksgiving_968883.html)
    func initSetting() {
        
        webView = WKWebView._build(delegate: self, frame: view.bounds, isInspectable: false, contentInsetAdjustmentBehavior: .always)
        webView.scrollView.showsHorizontalScrollIndicator = false
        
        self.view = webView
    }
    
    /// 顯示HTML
    /// - Parameter html: String
    /// - Returns: Result<Bool, Error>
    func displayHTML(_ html: String) -> Result<Bool, Error> {
        loadViewIfNeeded()
        webView.loadHTMLString(html, baseURL: nil)
        return .success(true)
    }
    
    /// 顯示Markdown => HTML
    /// - Parameter markdown: String
    /// - Returns: Result<Bool, Error>
    func displayMarkdown(_ markdown: String) -> Result<Bool, Error> {
        
        guard let htmlBody = WWJavaScriptContext.Markdown.shared.convert(markdown: markdown, tables: true) else { return .failure(AcknowledgeError.markdown) }
        
        let html = rwdHtml(body: htmlBody)
        return displayHTML(html)
    }
    
    /// [產生RWD的HTML](https://www.ibest.tw/page01.php)
    /// - Parameter htmlBody: String
    func rwdHtml(body: JSValue) -> String {
        
        let html = """
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
        </head>
        <style>
            table {
              border-collapse: collapse;
              width: 100%;
            }

            th, td {
              border: 1px solid #ddd;
              padding: 8px;
              text-align: left;
            }

            th {
              background-color: #f2f2f2;
            }

            tr:nth-child(even) {
              background-color: #f9f9f9;
            }
        
            tr:hover {
              background-color: #f5f5f5;
            }
        </style>
        <body>
            \(body)
        </body>
        </html>
        """
        
        return html
    }
}
