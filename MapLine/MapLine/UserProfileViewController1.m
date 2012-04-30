//
//  ProfileController.m
//  MapLine
//
//  Created by Emmanuel on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserProfileViewController1.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@implementation UserProfileViewController1

@synthesize userId;
@synthesize isMainUserProfileView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initForUser:(NSString *)userIdExt
{
    self = [super initWithNibName:@"UserProfileViewController" bundle:nil];
    if (self) {
        
        // Page de profil de l'utilisateur connecté
        self.userId = userIdExt;
        self.isMainUserProfileView = YES;
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
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"Ouverture de la page profile : %@",self.userId);
    
    NSString *urlToWebService = @"http://emmanuelgratuze.com/autres/MapLine/getUserDatas.php?id=";
    urlToWebService = [urlToWebService stringByAppendingString:self.userId];
    NSURL *url = [NSURL URLWithString:urlToWebService];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    NSDictionary *userDataDictionnary = [responseString JSONValue];
    
    NSArray *firstname = [userDataDictionnary valueForKey:@"first_name"];
    NSArray *lastname = [userDataDictionnary valueForKey:@"last_name"];
    
    NSString *deuxnoms = [[firstname objectAtIndex:0] stringByAppendingString:[@" " stringByAppendingString:[lastname objectAtIndex:0]]];
    
    NSLog(@"%@",deuxnoms);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    //NSError *error = [request error];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadUserDatas:(NSString *)userId {
    
    
}

- (void)dealloc {
    [userId release];
    [super dealloc];
}

@end
