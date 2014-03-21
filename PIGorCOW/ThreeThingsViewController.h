//
//  ThreeThingsViewController.h
//  iDecider
//
//  Created by Juliane Reschke on 06.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ThreeThingsViewController : UIViewController< UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *takePicButton;
@property (strong, nonatomic) IBOutlet UIButton *takePicTwoButton;
@property (strong, nonatomic) IBOutlet UIButton *takePicThreeButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewOne;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewTwo;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewThree;
@property (strong, nonatomic) IBOutlet UIButton *decideButton;
@property (strong, nonatomic) IBOutlet UIImageView *randomImageView;

@property (strong, nonatomic) NSMutableArray *imageArray;

- (IBAction)pressedTakePic:(id)sender;
- (IBAction)pressedTakePicTwo:(id)sender;
- (IBAction)pressedTakePicThree:(id)sender;
- (IBAction)pressedDecide:(id)sender;

- (IBAction)decideNew:(id)sender;


@end
