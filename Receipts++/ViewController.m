//
//  ViewController.m
//  Receipts++
//
//  Created by Steve on 2015-09-17.
//  Copyright © 2015 Steve. All rights reserved.
//

#import "ViewController.h"
#import "Receipt.h"
#import "Tag.h"
#import "DataStack.h"
#import "CustomTableViewCell.h"
#import "AddReceiptViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) DataStack *dataStack;

@property (nonatomic) NSMutableArray *receipts;

@property (nonatomic) NSMutableArray *tags;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.receipts = [NSMutableArray new];
    self.tags = [NSMutableArray new];
    
    self.dataStack = [DataStack new];
    
    [self reloadReceipts];
        [self fetchAllTags];
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadReceipts];
        [self fetchAllTags];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editReceipt"]) {
        AddReceiptViewController *addReceiptVC = segue.destinationViewController;
        
        addReceiptVC.dataStack = self.dataStack;
        
    }
}

- (void)fetchAllTags {
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];

//    [fetch setFetchLimit:3];
    
//    fetch.sortDescriptors = 

    NSError *fetchError = nil;
    NSArray *allTags = [self.dataStack.context executeFetchRequest:fetch error:&fetchError];

    NSLog(@"all Tags are: %@", allTags);

    self.tags = [allTags mutableCopy];

    [self.tableView reloadData];

}

-(void)reloadReceipts {
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Receipt"];
    
    //    fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"todoTitle" ascending:YES]];
    
    NSError *fetchError = nil;
    NSArray *allReceipts = [self.dataStack.context executeFetchRequest:fetch error:&fetchError];
    
    NSLog(@"all Receipts lists are: %@", allReceipts);
    
    self.receipts = [allReceipts mutableCopy];
    
    [self.tableView reloadData];
}

- (IBAction)addReceiptBtn:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"editReceipt" sender:self];
    
}

#pragma mark - Table view datasource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    
        return [self.tags count];
//    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        Tag *tag = self.tags[section];
    
        return [tag.relationship count];
    
//    return [self.receipts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Tag *tag = self.tags[indexPath.section];
    
    Receipt *receipt = [tag.relationship allObjects][indexPath.row];
    
//    Receipt *receipt = self.receipts[indexPath.row];
    cell.receipt = receipt;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.tags[section] tagName];
}

#pragma mark - Table view Delegate -

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Receipt *receipt = self.receipts[indexPath.row];
        
        [self.dataStack.context deleteObject:receipt];
        
        NSError *saveError = nil;
        
        if (![self.dataStack.context save:&saveError]) {
            NSLog(@"Save failed! %@", saveError);
        }
        
        [self.receipts removeObjectAtIndex:indexPath.row];
        //        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


@end
