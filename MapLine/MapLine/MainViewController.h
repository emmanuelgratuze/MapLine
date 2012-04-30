//
//  ViewController.h
//  MapLine
//
//  Created by Emmanuel on 05/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainUserProfileViewController.h"
#import "UserSearchViewController.h"
#import "UserMapViewController.h"

@protocol ConnectionViewDelegate <NSObject>

- (void)displayUserProfile:(NSString *)message;

@end

@interface MainViewController : UINavigationController <ConnectionViewDelegate> {
    UITabBarController *tabBarController;
    MainUserProfileViewController *mainUserProfileViewController;
    UserSearchViewController *userSearchViewController;
    UserMapViewController *userMapViewController;
}

// Fonction d'affichage de la vue de connection
-(void)displayViewConnection;
- (IBAction)logOut:(id)sender;

@end


