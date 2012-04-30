//
//  UserSearchViewController.m
//  MapLine
//
//  Created by Emmanuel on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserSearchViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@implementation UserSearchViewController
@synthesize searchBarOutlet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Rechercher un Mapliner";
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
}

- (void)viewDidUnload
{
    [self setSearchBarOutlet:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSInteger numberOfRows = [self->searchResultArray count];
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSLog(@"%@",[[self->searchResultArray objectAtIndex:indexPath.row] objectForKey:@"first_name"]);
    
    NSString *firstname = [[self->searchResultArray objectAtIndex:indexPath.row] objectForKey:@"first_name"];
    NSString *lastname = [[self->searchResultArray objectAtIndex:indexPath.row] objectForKey:@"last_name"];
    
    cell.textLabel.text = [[firstname stringByAppendingString:@" "] stringByAppendingString:lastname];
    
    
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    
}

#pragma mark - Search View delegate

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    NSLog(@"%@",searchBarOutlet.text);
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self getSearchContent:searchBarOutlet.text];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}


// return YES to reload table.
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    NSLog(@"%@",searchString);
    return NO;
}

#pragma mark - Get Users content

- (void)getSearchContent:(NSString *)searchBarContent
{
    NSString *urlToWebService = @"http://emmanuelgratuze.com/autres/MapLine/getUserDatas.php?searchBarResult=";
    urlToWebService = [urlToWebService stringByAppendingString:searchBarContent];
    
    urlToWebService = [urlToWebService stringByReplacingOccurrencesOfString:@" "
                                   withString:@"%20"];
    
    NSURL *url = [NSURL URLWithString:urlToWebService];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    
    // supprime les [] sils sont présents responseString = [responseString substringWithRange:NSMakeRange(0, responseString.length-0)];
    
    NSRange textRange =[responseString rangeOfString:@"result"];
    
    if(textRange.location != NSNotFound)
    {
        NSDictionary *dictionaryResponse = [[responseString JSONValue] retain];
        
        self->searchResultArray = [[dictionaryResponse valueForKey:@"result"] retain];
        
        [self numberOfSectionsInTableView:self.searchDisplayController.searchResultsTableView];
        [self.searchDisplayController.searchResultsTableView reloadData];
        [dictionaryResponse release];
    }
    else {
        [self.searchDisplayController.searchResultsTableView reloadData];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error);
}

- (void)dealloc {
    //
    [self->searchResultArray release];
    [searchBarOutlet release];
    [super dealloc];
}
@end
