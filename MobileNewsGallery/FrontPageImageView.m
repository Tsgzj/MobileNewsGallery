//
//  FrontPageImageView.m
//  MobileNewsGallery
//
//  Created by Tommy Su on 11-11-12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FrontPageImageView.h"


@implementation FrontPageImageView

@synthesize pageImageView;




// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"FrontPageImageView" bundle:nil]) {
        pageNumber = page;
    }
    return self;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *fileName = [NSString stringWithFormat:@"%d", pageNumber+1];
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    pageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    pageImageView.image = image;
    [self.view addSubview:pageImageView];
    //[pageImageView setFrame:CGRectMake(0, 0, 320, 150)];
    //self.view.backgroundColor = [FrontPageImageView pageControlColorWithIndex:pageNumber];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
