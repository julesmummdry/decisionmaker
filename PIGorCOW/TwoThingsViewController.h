//
//  TwoThingsViewController.h
//  iDecider
//
//  Created by Juliane Reschke on 06.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>



@interface TwoThingsViewController : UIViewController < UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *takePicButten;
@property (strong, nonatomic) IBOutlet UIButton *takePicTwoButton;
@property (strong, nonatomic) IBOutlet UIButton *decideButton;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *secondImageView;
@property (strong, nonatomic) IBOutlet UIImageView *randomImageView;

@property (strong, nonatomic) NSMutableArray *pictureArray;

- (IBAction)pressedTakePic:(id)sender;
- (IBAction)pressedTakePicTwo:(id)sender;
- (IBAction)pressedDecide:(id)sender;

- (IBAction)decideNew:(id)sender;



@end
