//  IGCell.m
//  Instagram
//
//  Created by festusojo on 7/10/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "IGCell.h"

@implementation IGCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//this allows for the animation of one of the cells individually being selected
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // Configure the view for the selected state
    [super setSelected:selected animated:animated];
}

@end
