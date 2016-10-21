//
//  CartTableViewCell.h
//  RetailStore
//
//  Created by Kaustubh on 22/10/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *productNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

@end
