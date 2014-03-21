//
//  StartViewController.m
//  iDecider
//
//  Created by Juliane Reschke on 06.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StartViewController.h"
#import "TwoThingsViewController.h"
#import "ThreeThingsViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController
@synthesize twoThingsButton;
@synthesize threeThingsButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"PIGorCOW - Menu");
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.title = @"Menu";
        
   // NSLog(@"Size View width: %f height: %f", self.view.frame.size.width, self.view.frame.size.height);
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menubackgroundpic"]];
    
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
}

- (void)viewDidUnload
{
    [self setTwoThingsButton:nil];
    [self setThreeThingsButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)pressedTwoThings:(id)sender {
    
    TwoThingsViewController *twoVC = [[TwoThingsViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:twoVC animated:YES];
}

- (IBAction)pressedThreeThings:(id)sender {
    
    ThreeThingsViewController *threeVC = [[ThreeThingsViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:threeVC animated:YES];
}
@end
