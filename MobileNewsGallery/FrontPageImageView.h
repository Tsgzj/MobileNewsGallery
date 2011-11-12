//
//  FrontPageImageView.h
//  MobileNewsGallery
//
//  Created by Tommy Su on 11-11-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrontPageImageView : UIViewController {
    UIImageView *pageImageView;
    int pageNumber;
}


@property (nonatomic, retain) IBOutlet UIImageView *pageImageView;

- (id)initWithPageNumber:(int)page;

@end
