//
//  ViewController.swift
//  MySecondApp
//
//  Created by Alex Zheng on 2017-12-02.
//  Copyright © 2017 MyOrg. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingBackground: UIView!
    @IBOutlet weak var stopLoadingButton: UIButton!
    private let siteURL = URL(string: "https://uoit-cssoc.ca/forums/")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Force request desktop site (Enables swipe from left/right edge to navigate pages)
        webView.customUserAgent = "Safari";
        
        // Handle WKWebView delegates
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        // Load the webpage
        let siteRequest = URLRequest(url: siteURL!)
        webView.load(siteRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Started loading a new page
    func webView(_ webView: WKWebView,
                 didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started loading") // MARK: DEBUG
        loadingBackground.isHidden = false;
        stopLoadingButton.isHidden = false;
    }
    
    // Finished loading a page
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading") // MARK: DEBUG
        loadingBackground.isHidden = true;
        stopLoadingButton.isHidden = true;
    }

    // Navigate to previous page: Swipe right from left edge
    @IBAction func navToPrevPage(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .ended && webView.canGoBack {
            print("Nav Back") // MARK: DEBUG
            webView.goBack()
        }
    }
    
    // Navigate to forward page: Swipe left from right edge
    @IBAction func navToForwardPage(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .ended && webView.canGoForward {
            print("Nav Forward") // MARK: DEBUG
            webView.goForward()
        }
    }
    
    // Reload page: Swipe down from top edge
    @IBAction func swipeFromTopEdgeReload(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .recognized {
            print("Reloading page") // MARK: DEBUG
            webView.reload()
        }
        
    }
    
    // Double tap anywhere to zoom in
    @IBAction func doubleTapZoom(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            //TODO: Find out where setMagnification() is (and maybe allowMagnification)
        }
    }
    
    // Stop loading current webpage
    @IBAction func stopLoadingWebpage(_ sender: UIButton) {
         print("Stopping page loading") // MARK: DEBUG
        webView.stopLoading()
        loadingBackground.isHidden = true
        stopLoadingButton.isHidden = true
    }
}

