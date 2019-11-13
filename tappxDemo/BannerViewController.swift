class BannerViewController: UIViewController, TappxBannerViewControllerDelegate {
          
    private var tappxBanner: TappxBannerViewController! = nil
    @IBOutlet weak var bannerLabel: UILabel!
    
    func presentViewController() -> UIViewController! {
        return self
    }

    func tappxBannerViewControllerDidFinishLoad(_ vc: TappxBannerViewController!) {
        bannerLabel.text = "Loaded Ad"
    }
    
    func tappxBannerViewControllerDidPress(_ vc: TappxBannerViewController!) {
    }
    
    func tappxBannerViewControllerDidClose(_ vc: TappxBannerViewController!) {
        bannerLabel.text = "Ad Closed"
    }
    
    func tappxBannerViewControllerDidFail(_ vc: TappxBannerViewController!, withError error: TappxErrorAd?) {
        bannerLabel.text = "Ad Failed"
        cleanTappxBanner()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cleanTappxBanner()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        cleanTappxBanner()
    }
           
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resetTappxBanner(size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height))
    }
       
    private func cleanTappxBanner() {
        if self.tappxBanner != nil {
            tappxBanner.delegate = nil
            self.tappxBanner?.removeBanner()
            self.tappxBanner = nil
        }
    }
    
    var bannerSize = TappxBannerSize.size320x50
    
    private func resetTappxBanner(size: CGSize) {
        if self.tappxBanner == nil {
            let width = size.width //self.view.bounds.width
            let height = size.height //self.view.bounds.height
            var location = CGPoint(x: (width - 320)/2, y: (height - 50))
            if width >= 728 && height >= 90 {
                bannerSize = TappxBannerSize.size728x90
                location = CGPoint(x: (width - 728)/2, y: (height - 90))
//            } else if width >= 300 && height >= 250 {
//                bannerSize = TappxBannerSize.size300x250
//                location = CGPoint(x: (width - 300)/2, y: (height - 250))
            }
           
            self.tappxBanner = TappxBannerViewController(
                delegate: self,
                andSize: bannerSize,
                andLocation: location
            )
            self.tappxBanner?.load()
        }
    }
    
    func refreshBanner() {
        bannerLabel.text = "Ad Refreshing"
        switch bannerSize {
        case TappxBannerSize.size320x50:
            bannerLabel.text! += "(size320x50)"
        case TappxBannerSize.size728x90:
            bannerLabel.text! += "(size728x90)"
        case TappxBannerSize.size300x250:
            bannerLabel.text! += "(size300x250)"
        default:
            bannerLabel.text! += "(size unknown)"
        }
        self.tappxBanner?.load()
    }
}
