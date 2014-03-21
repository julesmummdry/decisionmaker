//
//  ThreeThingsViewController.m
//  iDecider
//
//  Created by Juliane Reschke on 06.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ThreeThingsViewController.h"

@interface ThreeThingsViewController ()

@end

@implementation ThreeThingsViewController{

    int imageViewFlag;
}
@synthesize takePicButton;
@synthesize takePicTwoButton;
@synthesize takePicThreeButton;
@synthesize imageViewOne;
@synthesize imageViewTwo;
@synthesize imageViewThree;
@synthesize decideButton;
@synthesize randomImageView;
@synthesize imageArray;


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
    
    NSLog(@"3 Things!");
    self.title = @"Select Photos";
    
    imageViewFlag = 0;
    imageArray = [[NSMutableArray alloc]init];
    
    UIBarButtonItem *new = [[UIBarButtonItem alloc]initWithTitle:@"New" style:UIBarButtonItemStyleBordered target:self action:@selector(decideNew:)];
    self.navigationItem.rightBarButtonItem = new;
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundpic"]];
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    [imageViewOne setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"decideframe3left.png"]]];
    [imageViewTwo setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"decideframe3middle.png"]]];
    [imageViewThree setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"decideframe3right.png"]]];
    
    [imageViewOne.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [imageViewOne.layer setBorderWidth: 2.0];
    [imageViewTwo.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [imageViewTwo.layer setBorderWidth: 2.0];
    [imageViewThree.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [imageViewThree.layer setBorderWidth: 2.0];
    
    //NSLog(@"Size all three ImageViews width: %f height: %f", imageViewOne.frame.size.width, imageViewOne.frame.size.height);
       
}

- (void)viewDidUnload
{
    [self setTakePicButton:nil];
    [self setTakePicTwoButton:nil];
    [self setTakePicThreeButton:nil];
    [self setImageViewOne:nil];
    [self setImageViewTwo:nil];
    [self setImageViewThree:nil];
    [self setDecideButton:nil];
    [self setRandomImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
   
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    NSLog(@"Camera is ready to use");
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [self.navigationController presentModalViewController: cameraUI animated: YES];
    
    return YES;
}

-(UIImage *)resizeImage:(UIImage *)image
{
    
    UIGraphicsBeginImageContext(imageViewOne.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [image drawInRect: CGRectMake(0, 0, imageViewOne.frame.size.width, imageViewOne.frame.size.height)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();   
    
    return smallImage;
}

-(UIImage*)randomImage {    
    
    NSUInteger randomIndex = arc4random()% [imageArray count];
    NSLog(@"Picked image indexnumber %i", randomIndex);
    return [[self imageArray]objectAtIndex:randomIndex];
    
}

- (IBAction)pressedTakePic:(id)sender {
    
    imageViewFlag = 1;
    
    [self startCameraControllerFromViewController:self  
                                    usingDelegate:self];
}

- (IBAction)pressedTakePicTwo:(id)sender {
    
    imageViewFlag = 2;
    
    [self startCameraControllerFromViewController:self  
                                    usingDelegate:self];
}

- (IBAction)pressedTakePicThree:(id)sender {
    
    imageViewFlag = 3;
    
    [self startCameraControllerFromViewController:self  
                                    usingDelegate:self];
}

- (IBAction)pressedDecide:(id)sender {
    
    if([imageArray count]==0){
        
        NSLog(@"No pictures to decide from!");
        imageViewOne.image = [UIImage imageNamed:@"decideframe3left.png"];
        imageViewTwo.image = [UIImage imageNamed:@"decideframe3middle.png"];
        imageViewThree.image = [UIImage imageNamed:@"decideframe3right.png"];
        
        [randomImageView.layer setBorderWidth: 0.0];
        randomImageView.image = nil;
        
        [imageArray removeAllObjects];
    }
    
    else{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Deciding"
                                                            message:@"\n"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:nil];
        
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];   
        spinner.center = CGPointMake(139.5, 75.5); // .5 so it doesn't blur
        [alertView addSubview:spinner];
        [spinner startAnimating];
        [alertView show];

        
        [imageViewOne.layer setBorderWidth: 0.0];
        [imageViewThree.layer setBorderWidth: 0.0];
        
        imageViewOne.image = nil;
        imageViewThree.image = nil;
    
        [randomImageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        [randomImageView.layer setBorderWidth: 3.0];
        randomImageView.image = [self randomImage];
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        
        NSLog(@"Shows picked image");
    }
}

- (IBAction)decideNew:(id)sender{

    NSLog(@"Decide NEW!");
    
    [imageViewOne.layer setBorderWidth: 2.0];
    [imageViewThree.layer setBorderWidth: 2.0];
    
    imageViewOne.image = [UIImage imageNamed:@"decideframe3left.png"];
    imageViewTwo.image = [UIImage imageNamed:@"decideframe3middle.png"];
    imageViewThree.image = [UIImage imageNamed:@"decideframe3right.png"];
    
    [randomImageView.layer setBorderWidth: 0.0];
    randomImageView.image = nil;
    
    [imageArray removeAllObjects];

    
}

# pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
	UIImage *image = (UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    if(imageViewFlag==1){
        
        self.imageViewOne.image =  [self resizeImage: image];
        [imageArray addObject:image];
        NSLog(@"added Image 1 %@", [image description]);
    
    }
    
    if(imageViewFlag==2){
        
        self.imageViewTwo.image =  [self resizeImage: image];
        [imageArray addObject:image];
        NSLog(@"added Image 2 %@", [image description]);
    }
    
    if(imageViewFlag==3){
        
        self.imageViewThree.image =  [self resizeImage: image];
        [imageArray addObject:image];
        NSLog(@"added Image 3 %@", [image description]);
    }
        
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissModalViewControllerAnimated:YES]; 
}

@end
