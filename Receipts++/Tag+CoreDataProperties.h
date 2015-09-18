//
//  Tag+CoreDataProperties.h
//  Receipts++
//
//  Created by Steve on 2015-09-17.
//  Copyright © 2015 Steve. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tag.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tag (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *tagName;
@property (nullable, nonatomic, retain) NSSet<Receipt *> *relationship;

@end

@interface Tag (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(Receipt *)value;
- (void)removeRelationshipObject:(Receipt *)value;
- (void)addRelationship:(NSSet<Receipt *> *)values;
- (void)removeRelationship:(NSSet<Receipt *> *)values;

@end

NS_ASSUME_NONNULL_END
