//
//  ConnectionViewController.m
//  MapLine
//
//  Created by Emmanuel on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConnectionViewController.h"
#import "AppDelegate.h"

@implementation ConnectionViewController
@synthesize usernameField = _usernameField;
@synthesize passwordField = _passwordField;
@synthesize errorLabel = _errorLabel;

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
    // On initialise errorLabel par ""
    _errorLabel.text = @"";
}

- (void)viewDidUnload
{
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [self setErrorLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onSubmitClick:(id)sender {
    
    if([_usernameField.text isEqualToString: @""] || [_passwordField.text isEqualToString:@""]) {
        _errorLabel.text = @"Les deux champs sont obligatoires";
        NSLog(@"AH + %@",_usernameField.text);
    }
    else {
        _errorLabel.text = @"Champs bien précisés";
        
    }
    
}
- (void)dealloc {
    [_usernameField release];
    [_passwordField release];
    [_errorLabel release];
    [super dealloc];
}
@end
