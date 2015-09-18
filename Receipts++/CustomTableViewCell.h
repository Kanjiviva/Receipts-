//
//  CustomTableViewCell.h
//  Receipts++
//
//  Created by Steve on 2015-09-17.
//  Copyright © 2015 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receipt.h"
#import "Tag.h"

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic) Receipt *receipt;

@end
