//
//  ViewController.swift
//  FlexiblePageControlDemo
//
//  Created by Ekaterina Ryzhova on 04/09/2019.
//  Copyright © 2019 Ekaterina Ryzhova. All rights reserved.
//

import UIKit
import FlexiblePageControl

class ViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: UIScreen.main.bounds.width,
                                  height: UIScreen.main.bounds.height - 0)
        return scrollView
    }()

    private let pageControl = FlexiblePageControl()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        view.addSubview(pageControl)

        let images = [#imageLiteral(resourceName: "crow"), #imageLiteral(resourceName: "jackdaw"), #imageLiteral(resourceName: "magpie"), #imageLiteral(resourceName: "jay"), #imageLiteral(resourceName: "blue_jay"), #imageLiteral(resourceName: "blue_sparrow"), #imageLiteral(resourceName: "kingsfisher"), #imageLiteral(resourceName: "blue_bird"), #imageLiteral(resourceName: "wavy_parrots")]

        pageControl.frame = CGRect(x: 0, y: view.bounds.height - 200, width: view.bounds.width, height: 16)
        pageControl.numberOfPages = images.count
        configurePageControlAppearance()
        fillScrollView(with: images)
    }

    private func fillScrollView(with images: [UIImage]) {
        for i in 0..<images.count {
            let xPosition = view.bounds.width * CGFloat(i)
            let imageView = UIImageView(frame: CGRect(x: xPosition,
                                                      y: 0,
                                                      width: scrollView.frame.width,
                                                      height: scrollView.frame.height))
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFit
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 32
            imageView.layer.shadowRadius = 8
            imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
            imageView.layer.shadowOpacity = 0.5
            imageView.layer.shadowColor = UIColor.black.cgColor

            imageView.contentMode = .scaleAspectFit
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)

            scrollView.delegate = self
        }
    }

    private func configurePageControlAppearance() {
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black

        let config = FlexiblePageControl.Config(displayCount: 7,
                                                dotSize: 6,
                                                dotSpace: 4,
                                                smallDotSizeRatio: 0.5,
                                                mediumDotSizeRatio: 0.7)
        pageControl.setConfig(config)
    }
}

extension ViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.setProgress(contentOffsetX: scrollView.contentOffset.x, pageWidth: scrollView.bounds.width)
    }
}
