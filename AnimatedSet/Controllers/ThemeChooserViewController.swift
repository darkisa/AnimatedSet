//
//  ThemeChooserViewController.swift
//  AnimatedSet
//
//  Created by Darko Mijatovic on 3/9/19.
//  Copyright © 2019 Darko Mijatovic. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destinationViewController = segue.destination as? ConcentrationViewController {
      destinationViewController.selectedTheme = Int(segue.identifier!) ?? 0
      previousViewController = destinationViewController
    }
  }
  
  override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
    if previousViewController != nil {
      navigationController?.pushViewController(previousViewController!, animated: true)
      previousViewController!.selectedTheme = Int(identifier!) ?? 0
      return false
    }
    return true
  }
  
  private var previousViewController: ConcentrationViewController?
  
}
