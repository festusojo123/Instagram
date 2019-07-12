//
//  Post.h
//  Instagram
//
//  Created by festusojo on 7/10/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
@interface Post : PFObject<PFSubclassing>

//these properties are the ones the Parse database is looking for in each post
@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

//allows the Post functionality to be used in other functions
+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end
