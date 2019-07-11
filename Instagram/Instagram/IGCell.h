//
//  IGCell.h
//  Instagram
//
//  Created by festusojo on 7/10/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IGCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *captionBody;
@property (weak, nonatomic) IBOutlet UILabel *usernameText;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;

@end

NS_ASSUME_NONNULL_END
