//
//  AuthViewControllere.swift
//  SpotifyClone
//
//  Created by Heang Ly on 9/25/21.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    //MARK: - Properties
    var completionHandler: ((Bool) -> Void)?

    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true

        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs

        let webview = WKWebView(frame: .zero, configuration: config)
        return webview
    }()


    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubViewsAndConstraints()
        webView.navigationDelegate = self
        guard let url = AuthManager.shared.signInURL else { return }
        webView.load(URLRequest(url: url))
    }

    func configureUI() {
        title = "Sign In"
        view.backgroundColor = .systemBackground
    }

    //MARK: - Add Subviews & Constraints
    func addSubViewsAndConstraints() {
        view.addSubview(webView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?.first(where: { $0.name == "code" })?.value else { return }
        webView.isHidden = true
        
        AuthManager.shared.exchangeCodeForToken(code: code) {[weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(success)
            }
        }
    }

}


