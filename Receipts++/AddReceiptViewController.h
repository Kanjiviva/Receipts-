//
//  AddReceiptViewController.h
//  Receipts++
//
//  Created by Steve on 2015-09-17.
//  Copyright © 2015 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receipt.h"
#import "Tag.h"
#import <CoreData/CoreData.h>
#import "DataStack.h"

@interface AddReceiptViewController : UIViewController

@property (nonatomic) Receipt *receipt;
@property (nonatomic) DataStack *dataStack;

@end
