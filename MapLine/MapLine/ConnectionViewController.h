//
//  ConnectionViewController.h
//  MapLine
//
//  Created by Emmanuel on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectionViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *usernameField;
@property (retain, nonatomic) IBOutlet UITextField *passwordField;

@property (retain, nonatomic) IBOutlet UILabel *errorLabel;

- (IBAction)onSubmitClick:(id)sender;

@end
