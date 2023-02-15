//
//  PosterFullViewController.swift
//  FilmsApp
//
//  Created by Nikolay T on 10.08.2022.
//

import UIKit

class PosterFullViewController: UIViewController {

    @IBOutlet weak var fullPosterImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!

    var detailIndexPath: Int = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        fullPosterImageView.image = UIImage(named: testArray[detailIndexPath].testPic ?? "image1")
        // Do any additional setup after loading the view.
    }
    @IBAction func closeButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
