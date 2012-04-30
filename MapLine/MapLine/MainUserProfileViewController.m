//
//  MainUserProfileViewController.m
//  MapLine
//
//  Created by Emmanuel on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainUserProfileViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@implementation MainUserProfileViewController

@synthesize userId;
@synthesize isMainUserProfileView;
@synthesize loadingView;
@synthesize loadingIndicator;
@synthesize loadingLabel;

@synthesize firstnameLabel = _firstnameLabel;
@synthesize lastnameLabel = _lastnameLabel;
@synthesize currentcityLabel = _currentcityLabel;
@synthesize ageLabel = _ageLabel;
@synthesize profileimageView = _profileimageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"mainUserId"];
        self.title = @"Profil";
    }
    return self;
}

- (id)initForUser:(NSString *)userIdExt
{
    self = [super initWithNibName:@"MainUserProfileViewController" bundle:nil];
    if (self) {
        
        // Page de profil de l'utilisateur connecté
        self.userId = userIdExt;
        
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


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isMainUserProfileView = TRUE;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.loadingView.hidden = NO;
    [loadingIndicator startAnimating];
    
    NSString *urlToWebService = @"http://emmanuelgratuze.com/autres/MapLine/getUserDatas.php?id=";
    urlToWebService = [urlToWebService stringByAppendingString:self.userId];
    
    NSURL *url = [NSURL URLWithString:urlToWebService];
    ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:url];
    
    request1.tag = 1;
    [request1 setDelegate:self];
    [request1 startAsynchronous];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag == 1) {
        
        NSString *responseString = [request responseString];
        //NSLog(@"%@",[responseString substringWithRange:NSMakeRange(1, responseString.length-2)]);
        
        // On retire les crochets
        responseString = [responseString substringWithRange:NSMakeRange(0, responseString.length-0)];
        
        //NSLog(@"%@",responseString);
        
        NSDictionary *userDataDictionnary = [responseString JSONValue];
        
        self->userDatas = [userDataDictionnary objectForKey:@"result"];
        
        
        [self displayUserDatasInLabels];
    }
    else if (request.tag == 2) {
        
        //NSLog(@"%@",[request responseData]);
        
        NSData *responseData = [request responseData];
        
        self->userProfileImage = [[UIImage imageWithData:responseData] retain];
        
        _profileimageView.image = self->userProfileImage;
        self.loadingView.hidden = YES;
        [loadingIndicator stopAnimating];
        
        
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}


- (void)viewDidUnload
{
    [self setLoadingView:nil];
    [self setLoadingIndicator:nil];
    [self setFirstnameLabel:nil];
    [self setLastnameLabel:nil];
    [self setCurrentcityLabel:nil];
    [self setAgeLabel:nil];
    [self setProfileimageView:nil];
    [self setLoadingLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)displayUserDatasInLabels {
    if(!self->userDatas) {
    }
    else {
        [_firstnameLabel setText:[[self->userDatas valueForKey:@"first_name"] objectAtIndex: 0]];
        
        [_lastnameLabel setText:[[self->userDatas valueForKey:@"last_name"] objectAtIndex: 0]];
        [_currentcityLabel setText:[[self->userDatas valueForKey:@"city"] objectAtIndex: 0]];
        
        int ageOfUser = [self calculateAge:[self convertStringToDate:[[self->userDatas valueForKey:@"birthday"] objectAtIndex: 0]]];
        
        [_ageLabel setText:[[NSString stringWithFormat:@"%d", ageOfUser] stringByAppendingString:@" ans"]];
        [self getUserProfileImage:[[self->userDatas valueForKey:@"profile_img_url"]  objectAtIndex: 0]];
    }
}

- (NSInteger)calculateAge:(NSDate *)dateOfBirth {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponentsNow = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *dateComponentsBirth = [calendar components:unitFlags fromDate:dateOfBirth];
    
    if (([dateComponentsNow month] < [dateComponentsBirth month]) ||
        (([dateComponentsNow month] == [dateComponentsBirth month]) && ([dateComponentsNow day] < [dateComponentsBirth day]))) {
        return [dateComponentsNow year] - [dateComponentsBirth year] - 1;
    } else {
        return [dateComponentsNow year] - [dateComponentsBirth year];
    }
}

- (NSDate *)convertStringToDate:(NSString *)birthday {
    NSDateFormatter *dateFormater = [[[NSDateFormatter alloc] init] retain];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    return [dateFormater dateFromString: birthday];
}

-(void)getUserProfileImage:(NSString *)pathURL {
    NSURL *url = [NSURL URLWithString:pathURL];
    ASIHTTPRequest *request2 = [ASIHTTPRequest requestWithURL:url];
    request2.tag = 2;
    [request2 startAsynchronous];
    [request2 setDelegate:self];
}

- (void)dealloc {
    [self->userProfileImage release];
    [userId release];
    [loadingView release];
    [loadingIndicator release];
    [_firstnameLabel release];
    [_lastnameLabel release];
    [_currentcityLabel release];
    [_ageLabel release];
    [_profileimageView release];
    [loadingLabel release];
    [super dealloc];
}

@end
