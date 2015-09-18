//
//  CustomTableViewCell.m
//  Receipts++
//
//  Created by Steve on 2015-09-17.
//  Copyright © 2015 Steve. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setReceipt:(Receipt *)receipt {
    
    _receipt = receipt;
    
    [self setup];
}

- (void)setup {
    
    self.amountLabel.text = [NSString stringWithFormat:@"%.2f", self.receipt.amount];
    self.descriptionLabel.text = self.receipt.receiptDescription;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    
    self.timeLabel.text = [dateFormatter stringFromDate:self.receipt.timeStamp];
    
}
@end
