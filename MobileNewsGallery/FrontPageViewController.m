//
//  FrontPageViewController.m
//  MobileNewsGallery
//
//  Created by Tommy Su on 11-11-11.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "FrontPageViewController.h"
static NSUInteger kNumberOfPages = 10;



@implementation UINavigationBar (CustomImage)  
- (void )drawRect:(CGRect)rect {  
    UIImage *image = [UIImage imageNamed: @"NavigationBarBackground.png" ];  
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];  
}  
@end  



@implementation FrontPageViewController

@synthesize scrollView, pageControl, viewControllers;

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




- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
    
    // replace the placeholder if necessary
    FrontPageImageView *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[FrontPageImageView alloc] initWithPageNumber:page];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        [controller release];
    }
    
    // add the controller's view to the scroll view
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}





#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    
    self.navigationItem.title = @"手机新闻画报";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];    
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    
    CGSize itemSize = CGSizeMake(68, 30);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);

    [logo drawInRect:imageRect];
    [logo release];
    logo = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //UIBarButtonItem *myButton = [UIBarButtonItem buttonWithType:UIButtonTypeCustom];
    myButton.frame = CGRectMake(0, 0, 68, 30); // CGRectMake(圖示x座標, 圖示y座標, 圖示寬度, 圖示高度)
    
    [myButton setImage:logo forState:UIControlStateNormal];
    [logo release];
    [myButton addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside]; // 設定按鈕動作, 按了就執行 "action"
    UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithCustomView:myButton];
    self.navigationItem.leftBarButtonItem = customItem;
    [customItem release];
    
    
    /*
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:logo style:UIBarButtonItemStyleBordered target:self action:nil];
    [leftButton setWidth:-1];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    [leftButton release];
    */
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    [scrollView setFrame:CGRectMake(0, 0, 320, 300)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
    
    //这一行很重要，把pageControl放到最上层
    [pageControl.superview bringSubviewToFront:pageControl];
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


//自定义的TableViewCell不能使用系统的重用机制，否则会造成数据重复
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellNib = @"FrontPageViewTableCell";
    
    //FrontPageViewTableCell *cell = (FrontPageViewTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    FrontPageViewTableCell *cell = nil; 
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
        cell = (FrontPageViewTableCell *)[nib objectAtIndex:0];
        cell.picsBackground.layer.cornerRadius = 7.0f;
        NSUInteger row = [indexPath row];
        cell.title.text = [NSString stringWithFormat:@"优雅摩登，一手开启时尚%d",row];
        NSString *fileName = [NSString stringWithFormat:@"%d", row+1];
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"jpg"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [cell.titleImage setImage:image];

    }
    
    // perform additional custom work...
    
    return cell;
}




@end
