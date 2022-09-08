//
//  AuthViewController.swift
//  vk-api-project
//
//  Created by Nikita Artamonov on 08.09.2022.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        return webView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        authorizeVK()
    }
    
    // MARK: - Private
    private func setupViews() {
        view.addSubview(webView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        ])
    }
    
    private func authorizeVK() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem.init(name: "client_id", value: "51409299"),
            URLQueryItem.init(name: "display", value: "mobile"),
            URLQueryItem.init(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem.init(name: "scope", value: "friends,photos,audio,video,groups,wall"),
            URLQueryItem.init(name: "response_type", value: "token"),
            URLQueryItem.init(name: "revoke", value: "1"),
            URLQueryItem.init(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest.init(url: url)
        webView.load(request)
    }
    
}

// MARK: - WKNavigationDelegate
extension AuthViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params =
        fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce(Dictionary<String, String>()) { partialResult, param in
                var dict = partialResult
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"], let expiresIn = params["expires_in"], let userId = params["user_id"] else { return }
        
        print("TOKEn->", token)
        
        let friendsViewController = FriendsViewController()
        navigationController?.pushViewController(friendsViewController, animated: true)
        
        decisionHandler(.cancel)
    }
}
