//
//  WebPageViewCtroller.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/29.
//

import UIKit
import WebKit

class WebPageViewController: BaseViewController {
    
    // MARK: - 控件属性
    private let webView: WKWebView = {
        // 配置JS交互控制器
        let userContentController = WKUserContentController()

        // 配置WebView偏好设置
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
       // configuration.preferences.javaScriptEnabled = true  // 启用JS
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        // 创建WKWebView
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.backgroundColor = Default_BackGround_Color
        webView.scrollView.backgroundColor = Default_BackGround_Color
        webView.scrollView.bounces = false // 禁用回弹
        return webView
    }()
    
    // 进度条
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.tintColor = .systemRed // 进度条颜色
        progressView.trackTintColor = .clear // 轨道颜色
        return progressView
    }()
    
    // 加载的URL
    public var urlString: String?
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        ShowTip.showLoading()
        // 注册JS调用原生的方法名（需与JS端一致）
        webView.configuration.userContentController.add(self, name: "garlicPap")
        webView.configuration.userContentController.add(self, name: "kebabGarl")
        webView.configuration.userContentController.add(self, name: "palmfruit")
        webView.configuration.userContentController.add(self, name: "yogurtTur")
        webView.configuration.userContentController.add(self, name: "camelTrou")
        webView.configuration.userContentController.add(self, name: "xylophoni")
        setupUI()
        setupWebView()
        loadUrl()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 移除JS交互监听，避免内存泄漏
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "callNative")
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "closePage")
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "palmfruit")
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "yogurtTur")
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "camelTrou")
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "xylophoni")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
     
    }
    
 
    
    // MARK: - UI设置
    private func setupUI() {
        view.backgroundColor =  Default_BackGround_Color
        title = ""
        
        // 添加进度条
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }

        // 添加WebView
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(progressView.snp.bottom)
            make.height.equalTo(KScreenHeight - navigationFullHeight)
        }
        
    }
    
    // MARK: - WebView设置
    private func setupWebView() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        // 监听进度条变化（KVO）
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    // 加载URL
    private func loadUrl() {
        guard let urlString = urlString,
              let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrl) else {
            showError(message: "无效的URL")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // MARK: - 事件处理
    override func backClick() {
        if webView.canGoBack {
            webView.goBack() // 网页返回
        } else {
            navigationController?.popViewController(animated: true) // 控制器返回
        }
    }
    
    
    // 显示错误信息
    private func showError(message: String) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
    
    // MARK: - KVO监听进度
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            // 进度完成后隐藏进度条
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3) {
                    self.progressView.alpha = 0
                } completion: { _ in
                    self.progressView.progress = 0
                    self.progressView.alpha = 1
                }
            }
        }
    }
    
    // 原生调用JS方法
    func callJavaScript(method: String, parameters: [Any]? = nil) {
        // 拼接参数（示例：parameters为["123", true]时，生成"('123', true)"）
        let paramsString = parameters?.map { param in
            if let str = param as? String {
                return "'\(str)'" // 字符串参数加引号
            } else if let bool = param as? Bool {
                return bool ? "true" : "false"
            } else {
                return "\(param)"
            }
        }.joined(separator: ", ") ?? ""
        
        let jsCode = "\(method)(\(paramsString));"
        webView.evaluateJavaScript(jsCode) { result, error in
            if let error = error {
                print("JS调用失败：\(error.localizedDescription)")
            } else if let result = result {
                print("JS调用结果：\(result)")
            }
        }
    }
}

// MARK: - WKNavigationDelegate（页面导航代理）
extension WebPageViewController: WKNavigationDelegate {
    // 页面开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.alpha = 1
    }
    
    // 页面加载失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ShowTip.hideLoading()
        showError(message: "加载失败：\(error.localizedDescription)")
    }
    
    // 页面标题变化
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ShowTip.hideLoading()
        webView.evaluateJavaScript("document.title") { [weak self] result, _ in
            if let title = result as? String {
                self?.title = title
            }
        }
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload() // 进程终止后强制刷新
    }

    
    // 拦截URL请求（可选）
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            // 可以在这里拦截特定URL做处理
            print("即将加载URL：\(url)")
        }
        ShowTip.hideLoading()
        decisionHandler(.allow) // 允许加载
    }
}

// MARK: - WKUIDelegate（UI交互代理）
extension WebPageViewController: WKUIDelegate {
    // JS弹窗
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { _ in
            completionHandler()
        }))
        present(alert, animated: true)
    }
    
    // JS确认框
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel) { _ in
            completionHandler(false)
        })
        alert.addAction(UIAlertAction(title: "确定", style: .default) { _ in
            completionHandler(true)
        })
        present(alert, animated: true)
    }
}

// MARK: - WKScriptMessageHandler（JS调用原生代理）
extension WebPageViewController: WKScriptMessageHandler {
    // 接收JS发送的消息
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("收到JS消息：\(message.name)，参数：\(message.body)")
        
        switch message.name {
        case "callNative":
            // 处理JS调用原生的通用方法
            if let params = message.body as? [String: Any] {
                let action = params["action"] as? String ?? ""
                let data = params["data"] as? [String: Any] ?? [:]
                handleNativeAction(action: action, data: data)
            }
            
        case "closePage":
            // 处理JS调用关闭页面
            navigationController?.popViewController(animated: true)
            
        default:
            break
        }
    }
    
    // 处理JS传递的具体动作
    private func handleNativeAction(action: String, data: [String: Any]) {
        switch action {
        case "showToast":
            let message = data["message"] as? String ?? "收到JS消息"
            print("显示Toast：\(message)") // 可替换为实际Toast实现
            
        case "openDetail":
            if let id = data["id"] as? String {
                print("打开详情页，ID：\(id)")
                // 这里可以跳转到原生详情页
            }
            
        default:
            print("未知动作：\(action)")
        }
    }
}
