//
//  ConnectionViewController.m
//  MapLine
//
//  Created by Emmanuel on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConnectionViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

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
        
        // Les deux champs ne sont pas précisés
        _errorLabel.text = @"Les deux champs sont obligatoires";
    }
    else {
        // Les champs sont précisés on va vérifier si l'utilisateur est sur la bdd
        _errorLabel.text = @"Champs bien précisés";
        
        NSString *username = _usernameField.text;
        NSString *password = _passwordField.text;
        
        BOOL permission = [self checkIfUserIsRegistered:username :password];
        NSLog(@"%@", permission ? @"YES" : @"NO");
        
        
    }
    
}

- (BOOL)checkIfUserIsRegistered:(NSString *)username :(NSString *)password {
    
    BOOL result;
    
    NSURL *url = [NSURL URLWithString:@"http://emmanuelgratuze.com/autres/MapLine/getAccess.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:_usernameField.text forKey:@"username"];
    [request setPostValue:_passwordField.text forKey:@"password"];
    
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        if([response isEqualToString: @"true"]) {
            result = YES;
        }
        else {
            result = NO;
        }
    }
    else {
        result = NO;
        // add here function about error connection
    }
    return result;
}

- (void)dealloc {
    [_usernameField release];
    [_passwordField release];
    [_errorLabel release];
    [super dealloc];
}
@end
