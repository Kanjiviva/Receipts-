//
//  DataStack.h
//  Receipts++
//
//  Created by Steve on 2015-09-17.
//  Copyright © 2015 Steve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataStack : NSObject

@property (nonatomic, strong) NSManagedObjectContext *context;

@end
