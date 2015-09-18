//
//  AddReceiptViewController.m
//  Receipts++
//
//  Created by Steve on 2015-09-17.
//  Copyright © 2015 Steve. All rights reserved.
//

#import "AddReceiptViewController.h"

#define FOOD @"Food"
#define PHONEBILL @"Phone Bill"
#define OTHERS @"Others"

@interface AddReceiptViewController ()
@property (weak, nonatomic) IBOutlet UIButton *checkFood;
@property (weak, nonatomic) IBOutlet UIButton *checkPhoneBill;
@property (weak, nonatomic) IBOutlet UIButton *checkOthers;
@property (weak, nonatomic) IBOutlet UILabel *foodLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *othersLabel;
@property (weak, nonatomic) IBOutlet UITextField *totalAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *DescriptionTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (assign, nonatomic) BOOL foodChecked;
@property (assign, nonatomic) BOOL phoneChecked;
@property (assign, nonatomic) BOOL othersChecked;

@end

@implementation AddReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.checkFood setTitle:@"\u2B1C" forState:UIControlStateNormal];
    [self.checkPhoneBill setTitle:@"\u2B1C" forState:UIControlStateNormal];
    [self.checkOthers setTitle:@"\u2B1C" forState:UIControlStateNormal];
    self.foodLabel.text = @"Food";
    self.phoneLabel.text = @"Phone Bill";
    self.othersLabel.text = @"Others";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods -

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - IBActions -
- (IBAction)foodBtn:(UIButton *)sender {
    
    if (self.foodChecked == YES) {
        
        self.foodChecked = NO;
        [self.checkFood setTitle:@"\u2B1C" forState:UIControlStateNormal];
    } else {
        self.foodChecked = YES;
        [self.checkFood setTitle:@"\u2611" forState:UIControlStateNormal];
    }
    
}
- (IBAction)phoneBtn:(UIButton *)sender {
    if (self.phoneChecked == YES) {
        self.phoneChecked = NO;
        [self.checkPhoneBill setTitle:@"\u2B1C" forState:UIControlStateNormal];
    } else {
        self.phoneChecked = YES;
        [self.checkPhoneBill setTitle:@"\u2611" forState:UIControlStateNormal];
    }
}
- (IBAction)othersBtn:(UIButton *)sender {
    if (self.othersChecked == YES) {
        self.othersChecked = NO;
        [self.checkOthers setTitle:@"\u2B1C" forState:UIControlStateNormal];
    } else {
        self.othersChecked = YES;
        [self.checkOthers setTitle:@"\u2611" forState:UIControlStateNormal];
    }
}

- (IBAction)datePicker:(UIDatePicker *)sender {
}
- (IBAction)doneBtn:(UIBarButtonItem *)sender {
    
    if (self.foodChecked == NO && self.phoneChecked == NO && self.othersChecked == NO) {
        return;
    }
    
    
    Receipt *receipt = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt" inManagedObjectContext:self.dataStack.context];
    
    receipt.amount = [self.totalAmountTextField.text intValue];
    receipt.receiptDescription = self.DescriptionTextField.text;
    receipt.timeStamp = self.datePicker.date;
    
    if (self.foodChecked == YES) {
        [self tagReceipt:receipt tagName:@"Food"];
    }
    
    if (self.phoneChecked == YES) {
        [self tagReceipt:receipt tagName:@"Phone Bill"];
    }
    
    if (self.othersChecked == YES) {
        [self tagReceipt:receipt tagName:@"Others"];
    }
//    
//    if (self.foodChecked == NO && self.phoneChecked == NO && self.othersChecked == NO) {
//        [self.dataStack.context deleteObject:receipt];
//    } else {
    
        NSError *saveError = nil;
        if (![self.dataStack.context save:&saveError]) {
            NSLog(@"error is: %@", saveError);
        }
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
    
    
}



-(void)tagReceipt:(Receipt *)receipt tagName:(NSString *)tagName {
    
    // look for an existing Tag object with the .tagName == tagName
    // if it exists, add it to the receipt
    // if it doesn't, create it and then add it to the receipt.
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    
    fetch.predicate = [NSPredicate predicateWithFormat:@"tagName = %@", tagName];
    //    fetch.fetchLimit = 1;
    NSError *fetchError = nil;
    NSArray *allTags = [self.dataStack.context executeFetchRequest:fetch error:&fetchError];
    
    
    if ([allTags count] > 0) {
        Tag *foundTag = [allTags firstObject];
        
        [receipt addRelationshipObject:foundTag];
    } else {
        Tag *tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:self.dataStack.context];
        
        tag.tagName = tagName;
        [receipt addRelationshipObject:tag];
        
    }
    
    
//    Tag *foundTag = nil;
//    
//    for (Tag *eachTag in allTags) {
//        
//        if ([eachTag.tagName isEqualToString:tagName]) {
//            foundTag = eachTag;
//            NSLog(@"found %@",tagName);
//            break;
//        } else {
//            NSLog(@"Didn't find %@", tagName);
//        }
//    }
//    
//    if (foundTag == nil) {
//        
//    } else {
//        
//    }
    
}

@end
