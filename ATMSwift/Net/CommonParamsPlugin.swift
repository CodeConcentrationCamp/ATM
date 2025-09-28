import Moya
import Alamofire

/// 公共参数仅拼在URL上，POST业务参数保留在body中的插件
struct CommonParamsPlugin: PluginType {
    /// 定义需要添加到URL的公共参数
    private var commonParameters: [String: Any] {
            return  [
                "proposed":"ios",
                "unknown": "1.0.0",
                "equipment": "2",
                "scantiness":"3",
                "smallness": "4",
                "overland": "loangabay",
                "undertaking": ToolManager.shared.getData(forKey: "ATM_SessionId") as? String ?? "",
                "project":"6",
                "boyfine":String.randomAlphanumeric(),
            ]
        }
    
    /// 生成签名（示例方法）
//    private func generateSign() -> String {
//        // 实际项目中根据后端要求生成签名
//        return "sample_sign_\(Int(Date().timeIntervalSince1970) % 1000)"
//    }
    
    /// 准备请求时处理URL参数
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        // 解析并修改URL中的查询参数
        guard let url = request.url,
              var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return request
        }
        
        // 获取已有的查询参数
        var queryItems = components.queryItems ?? []
        
        // 添加公共参数到URL
        commonParameters.forEach { key, value in
            let valueString = paramToString(value)
            
            // 若参数已存在则替换，否则添加
            if let existingIndex = queryItems.firstIndex(where: { $0.name == key }) {
                queryItems[existingIndex] = URLQueryItem(name: key, value: valueString)
            } else {
                queryItems.append(URLQueryItem(name: key, value: valueString))
            }
        }
        
        // 更新URL
        components.queryItems = queryItems
        request.url = components.url
        
        return request
    }
    
    /// 将参数值转换为字符串
    private func paramToString(_ value: Any) -> String {
        if let num = value as? NSNumber {
            return num.stringValue
        } else if let bool = value as? Bool {
            return bool ? "1" : "0"
        } else {
            return "\(value)"
        }
    }
    
    /// 打印请求信息（方便调试）
    func willSend(_ request: RequestType, target: TargetType) {
        if let url = request.request?.url?.absoluteString {
            print("🚀 [\(target.method)] 请求URL: \(url)")
        }
        
        // 打印POST请求的body参数
        if target.method == .post,
           let body = request.request?.httpBody,
           let bodyStr = String(data: body, encoding: .utf8) {
            print("📦 POST Body参数: \(bodyStr)")
        }
    }
}



