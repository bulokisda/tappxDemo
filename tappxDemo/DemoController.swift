import UIKit
import GoogleMobileAds

class DemoController:
    UIViewController
{
    @IBOutlet weak var button: UIButton!
      
    @IBAction func press(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Interstitial", sender: self)
    }
      
    @IBAction func pressedRefreshBanner(_ sender: UIButton) {
        bannerViewController?.refreshBanner()
    }
    
    var bannerViewController : BannerViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let vc = segue.destination as? BannerViewController {
            bannerViewController = vc
        }
    }
}

