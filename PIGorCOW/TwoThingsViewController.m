//
//  TwoThingsViewController.m
//  iDecider
//
//  Created by Juliane Reschke on 06.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TwoThingsViewController.h"

@interface TwoThingsViewController ()

@end

@implementation TwoThingsViewController{

    int imageViewFlag;
}


@synthesize takePicButten;
@synthesize takePicTwoButton;
@synthesize decideButton;
@synthesize imageView;
@synthesize secondImageView;
@synthesize randomImageView;
@synthesize pictureArray;

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
    
    NSLog(@"2 Things!");
    self.title = @"Select Photos";
    
    pictureArray = [[NSMutableArray alloc]init];  //initialise the picture array
    imageViewFlag = 0;                            //set imageViewFlag
    
    
    //New UIBarButton
    UIBarButtonItem *new = [[UIBarButtonItem alloc]initWithTitle:@"New" style:UIBarButtonItemStyleBordered target:self action:@selector(decideNew:)];
    self.navigationItem.rightBarButtonItem = new;
    
    //Configure the ImageViews with backgroundpics and borders
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundpic"]];
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    [imageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [imageView.layer setBorderWidth: 2.0];
    [imageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"decideframe_left.png"]]];
    
    [secondImageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [secondImageView.layer setBorderWidth: 2.0];
    [secondImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"decideframe_right.png"]]];
    
    //NSLog(@"Size ImageView width: %f height: %f", imageView.frame.size.width, imageView.frame.size.height);
    
    //NSLog(@"Size SecondImageView width: %f height: %f", secondImageView.frame.size.width, secondImageView.frame.size.height);
}

- (void)viewDidUnload
{
    [self setTakePicButten:nil];
    [self setImageView:nil];
    [self setSecondImageView:nil];
    [self setTakePicTwoButton:nil];
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

//UIImagePickerController Interface
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

// taking the pictures, ImagePicker is called
- (IBAction)pressedTakePic:(id)sender {
    
    imageViewFlag = 1;
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
}

- (IBAction)pressedTakePicTwo:(id)sender {
    
    imageViewFlag = 2;
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
}


// Deciding process
- (IBAction)pressedDecide:(id)sender {
    
    if ([pictureArray count]==0){
        
        NSLog(@"No pictures to decide from!");
        
        imageView.image = [UIImage imageNamed:@"decideframe_left.png"];
        secondImageView.image = [UIImage imageNamed:@"decideframe_right.png"];
        
        [randomImageView.layer setBorderWidth: 0.0];
        randomImageView.image = nil;
        
        [pictureArray removeAllObjects];
    
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
        
        [imageView.layer setBorderWidth: 0.0];
        [secondImageView.layer setBorderWidth:0.0];
        
        imageView.image = nil;
        secondImageView.image = nil;
        
        
        [randomImageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
        [randomImageView.layer setBorderWidth: 2.0];
        randomImageView.image = [self randomImage];
        
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        
        NSLog(@"Shows picked image");
    }
    
}

- (IBAction)decideNew:(id)sender{
    
     NSLog(@"Decide NEW!");
    
    [imageView.layer setBorderWidth: 2.0];
    [secondImageView.layer setBorderWidth:2.0];
    
    imageView.image = [UIImage imageNamed:@"decideframe_left.png"];
    secondImageView.image = [UIImage imageNamed:@"decideframe_right.png"];
    
    [randomImageView.layer setBorderWidth: 0.0];
    randomImageView.image = nil;

    [pictureArray removeAllObjects];
    
}

// resize the image when taking and using it, otherwise app gets memory warning and wait-fence
-(UIImage *)resizeImage:(UIImage *)image
{
    if(imageViewFlag ==1){
    UIGraphicsBeginImageContext(imageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [image drawInRect: CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();   
    
    return smallImage;
    }
    
    else {
        UIGraphicsBeginImageContext(secondImageView.frame.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [image drawInRect: CGRectMake(0, 0, secondImageView.frame.size.width, imageView.frame.size.height)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();   
        
        return smallImage;
    }
    
    return nil;
}

// the random number generator
-(UIImage*)randomImage {    
    
    NSUInteger randomIndex = arc4random()% [pictureArray count];
    NSLog(@"Picked image indexnumber %i", randomIndex);
    return [[self pictureArray]objectAtIndex:randomIndex];

}


# pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

  [self.navigationController dismissModalViewControllerAnimated:YES];
    
	UIImage *image = (UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage];

    
    if(imageViewFlag ==1){
        
        self.imageView.image = [self resizeImage: image];
        //self.imageView.image = image;
        //self.imageView.contentMode = UIViewContentModeScaleToFill;
        [pictureArray addObject:image];
        NSLog(@"added Image 1 %@",[image description]);
    }
    
    
    if(imageViewFlag ==2){
        
        self.secondImageView.image = [self resizeImage: image];
        //self.secondImageView.image = image;
        //self.secondImageView.contentMode = UIViewContentModeScaleToFill;
        [pictureArray addObject:image];
        NSLog(@"added Image 2 %@",[image description]);
    }
    

}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissModalViewControllerAnimated:YES]; 
}

@end
