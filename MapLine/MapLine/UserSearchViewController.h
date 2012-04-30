//
//  UserSearchViewController.h
//  MapLine
//
//  Created by Emmanuel on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestDelegate.h"

@interface UserSearchViewController : UIViewController <UISearchDisplayDelegate, ASIHTTPRequestDelegate>
{
    
    NSArray *searchResultArray;
}
@property (retain, nonatomic) IBOutlet UISearchBar *searchBarOutlet;

- (void)getSearchContent:(NSString *)searchBarContent;

@end
