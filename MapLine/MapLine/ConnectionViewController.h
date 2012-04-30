//
//  ConnectionViewController.h
//  MapLine
//
//  Created by Emmanuel on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@protocol ConnectionViewDelegate;

@interface ConnectionViewController : UIViewController {
    id<ConnectionViewDelegate> delegate;
}

@property (retain, nonatomic) IBOutlet UITextField *usernameField;
@property (retain, nonatomic) IBOutlet UITextField *passwordField;
@property (retain, nonatomic) IBOutlet UILabel *errorLabel;
@property (nonatomic, assign) id<ConnectionViewDelegate> delegate;

- (IBAction)onSubmitClick:(id)sender;
- (NSString *)checkIfUserIsRegistered:(NSString *)username :(NSString *)password;

@end
