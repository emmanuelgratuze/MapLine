//
//  ProfileController.h
//  MapLine
//
//  Created by Emmanuel on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController1 : UIViewController <UINavigationBarDelegate>

@property(retain, nonatomic) NSString *userId;
@property BOOL isMainUserProfileView;

- (id)initForUser:(NSString *)userId;
- (void)loadUserDatas:(NSString *)idUser;

@end
