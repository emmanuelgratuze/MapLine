//
//  MainUserProfileViewController.h
//  MapLine
//
//  Created by Emmanuel on 29/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestDelegate.h"

@interface MainUserProfileViewController : UIViewController <ASIHTTPRequestDelegate>{
    NSDictionary *userDatas;
    UIImage *userProfileImage;
    int finishedRequestNumber;
}

@property(retain, nonatomic) NSString *userId;
@property BOOL isMainUserProfileView;

//Loading view
@property (retain, nonatomic) IBOutlet UIView *loadingView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (retain, nonatomic) IBOutlet UILabel *loadingLabel;

//Labels
@property (retain, nonatomic) IBOutlet UILabel *firstnameLabel;
@property (retain, nonatomic) IBOutlet UILabel *lastnameLabel;
@property (retain, nonatomic) IBOutlet UILabel *currentcityLabel;
@property (retain, nonatomic) IBOutlet UILabel *ageLabel;
@property (retain, nonatomic) IBOutlet UIImageView *profileimageView;

- (id)initForUser:(NSString *)userId;
- (void)displayUserDatasInLabels;
- (NSInteger)calculateAge:(NSDate *)dateOfBirth;
- (NSDate *)convertStringToDate:(NSString *)birthday;
-(void)getUserProfileImage:(NSString *)pathURL;
@end
