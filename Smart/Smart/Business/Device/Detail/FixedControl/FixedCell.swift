//
//  FixedCell.swift
//  Cultivation
//
//  Created by apple on 2018/5/9.
//  Copyright © 2018年 张光富. All rights reserved.
//

import UIKit
import RxSwift
import ViewModels

class FixedControlCell: UITableViewCell {

    private(set) var disposeBag = DisposeBag()
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var maxRangeLabel: UILabel!
    @IBOutlet weak var minRangeLabel: UILabel!
    @IBOutlet weak var setRangeButton: UIButton!
    @IBOutlet weak var valueSlider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    var info: FixedInfo? {
        willSet {
            self.selectionStyle = .none
            nameLabel?.text = newValue?.name
            valueLabel?.text = newValue?.value
            minRangeLabel?.text = newValue?.min
            maxRangeLabel?.text = newValue?.max
            valueSlider?.minimumValue = Float((newValue?.min)!)!
            valueSlider?.maximumValue = Float((newValue?.max)!)!
            valueSlider?.value = Float((newValue?.value)!)!
        }
    }
    
    
    
    
    
    
    
    
    
    
}
