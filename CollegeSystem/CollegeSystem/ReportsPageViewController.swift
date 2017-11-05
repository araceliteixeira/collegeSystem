//
//  ReportsPageViewController.swift
//  CollegeSystem
//
//  Created by Araceli Teixeira on 05/11/17.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class ReportsPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    private var index = 0
    var views: [UIViewController] = []
    var college: College?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController("InstructorClassAverage"),
                self.newViewController("CountryStudents"),
                self.newViewController("CoursesAverageGrade"),
                self.newViewController("InstructorWeekdayClasses"),
                self.newViewController("ProgramStudentAverage")]
    }()
    
    private func newViewController(_ viewId: String) -> UINavigationController {
        return UIStoryboard(name: "Storyboard", bundle: nil) .
            instantiateViewController(withIdentifier: "\(viewId)Navigation") as! UINavigationController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
