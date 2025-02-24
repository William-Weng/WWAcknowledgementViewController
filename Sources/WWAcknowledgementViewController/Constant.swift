//
//  Constant.swift
//  WWAcknowledgementViewController
//
//  Created by William.Weng on 2025/2/24.
//

import Foundation

// MARK: - 常數
public extension WWAcknowledgementViewController {
    
    /// 輸入的文字類型
    public enum ContentType {
        case markdown(_ markdown: String)
        case html(_ html: String)
    }
    
    /// 自定義錯誤
    public enum AcknowledgeError: Error {
        case markdown   // markdown轉換錯誤
    }
}
