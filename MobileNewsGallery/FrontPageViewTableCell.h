//
//  FrontPageViewTableCell.h
//  MobileNewsGallery
//
//  Created by Tommy Su on 11-11-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrontPageViewTableCell : UITableViewCell {
    UIImageView *titleImage;
    UILabel *title;
    UILabel *content;
    UILabel *date;
    UILabel *pics;
    UIView *picsBackground;
}

@property (nonatomic, retain) IBOutlet UIImageView *titleImage;
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *content;
@property (nonatomic, retain) IBOutlet UILabel *date;
@property (nonatomic, retain) IBOutlet UILabel *pics;
@property (nonatomic, retain) IBOutlet UIView *picsBackground;

@end
