//
//  OnboardingViewController.swift
//  NoteApp
//
//  Created by Avudari Sudheer Babu on 28/09/21.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            
                
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    var slides: [OnboardingSlide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = [OnboardingSlide(title: "🗒Well Come🗒", description: "Write and save keep notes", image: #imageLiteral(resourceName: "Note.png")),OnboardingSlide(title: "Presented by PICOC...", description: "Take notes and find them in any device", image: #imageLiteral(resourceName: "Two.jpg"))]
//        collectionView.delegate = self
//        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
           // print("Go to the Next Page")
            var controller  = storyboard?.instantiateViewController(identifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            UserDefaults.standard.hasOnboarded = true
            present(controller, animated: true, completion: nil)
        
        } else {
            currentPage += 1
        let indexpath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)

        }
     
    }
    

}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier , for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        let width = scrollView.frame.width
//        //currentPage = Int(scrollView.contentOffset.x)
//        currentPage = Int(scrollView.contentOffset.x / width)
//
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        //currentPage = Int(scrollView.contentOffset.x)
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
