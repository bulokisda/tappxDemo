import UIKit
import WebKit
import GoogleMobileAds

class InterstitialViewController: UIViewController,
    TappxInterstitialViewControllerDelegate
{
    @IBOutlet weak var loadingLabel: UILabel!
    private var tappxInterstitial: TappxInterstitialViewController! = nil
    private var loadText = "Loading Advert..."
    private var closed: Bool = false
    private var transitioning: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingLabel.text = loadText
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !closed && !transitioning{
            resetInterstitial()
        } else if transitioning {
            transitionInterstitial()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        transitioning = true
    }
    
    private func transitionInterstitial() {
        tappxInterstitial?.delegate = nil
        self.presentedViewController?.dismiss(animated: false, completion: {
            self.tappxInterstitial = nil
            self.closed = true
            self.transitioning = false
            self.createInterstitial()
        })
    }
    
    private func closeInterstitial() {
        closed = true
        tappxInterstitial?.delegate = nil
        self.presentedViewController?.dismiss(animated: false, completion: {
            self.navigationController?.popViewController(animated: false)
        })
        tappxInterstitial = nil
    }
    
    private func createInterstitial() {
        tappxInterstitial = TappxInterstitialViewController(delegate: self)
        tappxInterstitial.setAutoShowWhenReady(false)
        tappxInterstitial.load()
    }
    
    func resetInterstitial() {
        loadText = "Loading Tappx Advert..."
        if tappxInterstitial != nil {
            closeInterstitial()
        }
        createInterstitial()
    }
        
    // for TappX
    func presentViewController() -> UIViewController! {
        return self
    }

    func tappxInterstitialViewControllerDidFinishLoad(_ viewController: TappxInterstitialViewController!) {
        if viewController.isReady {
            viewController.show()
        } else {
            loadingLabel.text = "Advert not available"
            closeInterstitial()
        }
    }

    func tappxInterstitialViewControllerDidClose(_ viewController: TappxInterstitialViewController!) {
        loadingLabel.text = "Closing Advert"
        if !transitioning {
            closeInterstitial()
        }
    }

    func tappxInterstitialViewControllerDidFail(_ viewController: TappxInterstitialViewController!, withError error: TappxErrorAd!) {
        loadingLabel.text = "Advert not provided"
        closeInterstitial()
    }
}
