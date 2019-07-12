//
//  DetailView.h
//  Instagram
//
//  Created by festusojo on 7/11/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailView : UIViewController

//this is a Post, which is the data post holding the info from each particular post
@property (nonatomic, strong) Post *igPost;

@end

NS_ASSUME_NONNULL_END
