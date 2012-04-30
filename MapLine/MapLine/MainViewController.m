//
//  ViewController.m
//  MapLine
//
//  Created by Emmanuel on 05/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "ConnectionViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "UserProfileViewController.h"
#import "UserSearchViewController.h"

@implementation MainViewController

BOOL haveEverLaunched = NO;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationBar.hidden = NO;
    
    //NSLog(@"%@",self.title);
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewDidAppear:animated];
    
    if(haveEverLaunched == NO) {
        [self displayViewConnection];
    }
    haveEverLaunched = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)displayViewConnection
{
    NSLog(@"CONNECTION");
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"mainUserId"]) {
        
        [self displayUserProfile:[[NSUserDefaults standardUserDefaults] objectForKey:@"mainUserId"]];
    }
    else {
        
        ConnectionViewController *connectionViewController = [[[ConnectionViewController alloc] initWithNibName:@"ConnectionViewController" bundle:nil] retain];
        NSLog(@"eheh10");
        connectionViewController.delegate = self;
        
        
        [self presentModalViewController:connectionViewController animated:YES];
    }
}

- (void)displayUserProfile:(NSString *)userId {
    
    //MainUserProfileViewController *mainUserProfileViewController = [[[MainUserProfileViewController alloc] initForUser:userId] autorelease];
    
    self.navigationBar.hidden = NO;
    
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"mainUserId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self->mainUserProfileViewController = [[[MainUserProfileViewController alloc] initWithNibName:@"MainUserProfileViewController" bundle:nil] retain];
    
    self->userSearchViewController = [[[UserSearchViewController alloc] initWithNibName:@"UserSearchViewController" bundle:nil] retain];
    
    self->tabBarController = [[[UITabBarController alloc] init] retain];
    self->tabBarController.title = @"Mapline";
    
    
    UIBarButtonItem *logOut = [[UIBarButtonItem alloc] 
                               initWithTitle:@"Se déconnecter"                                            
                               style:UIBarButtonItemStyleBordered 
                               target:self
                               action:@selector(logOut:)];
    self->tabBarController.navigationItem.rightBarButtonItem = logOut;
    [logOut release];
    
    
    [tabBarController addChildViewController:self->mainUserProfileViewController];
    [tabBarController addChildViewController:self->userSearchViewController];
    
    

    [self pushViewController:self->tabBarController animated:NO];
    
    //[self presentModalViewController:self->tabBarController animated:NO];
}

- (IBAction)logOut:(id)sender {
    NSLog(@"eheh11");
    /*CATransition *tr=[CATransition animation];
    tr.duration=0.75;
    tr.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    tr.type=kCATransitionMoveIn;
    tr.subtype=kCATransitionFromRight;*/
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"mainUserId"];
    
    [self->userSearchViewController release];
    [self->mainUserProfileViewController release];
    [self->tabBarController release];
    [self displayViewConnection];
    
}

- (void)dealloc {
    
    [super dealloc];
}
@end
