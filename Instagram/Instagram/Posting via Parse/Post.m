//
//  Post.m
//  Instagram
//
//  Created by festusojo on 7/10/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "ProgressHUD.h"
#import "Post.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    //this allows for a new post and sets the values for each of the required properties Parse is looking for
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    //this is where the pulling of data ends for this new post, so I added the code to dismiss the HUD here as it would be done trying to post the IG post at this time
    [newPost saveInBackgroundWithBlock: completion];
    [ProgressHUD dismiss];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    //this is what this returns, allowing an image with the correct data to be posted 
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}


@end
