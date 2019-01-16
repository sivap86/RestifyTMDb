//
//  MovieListViewController.m
//  The Movies
//
//  Created by siva lingam on 14/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#import "MovieListViewController.h"
#import <RestifyTMDb/RestifyTMDb.h>

@interface MovieListViewController ()  {
    RestifyTMDbQueryParameters *queryparameter;
}
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property(nonatomic, strong) NSArray *movieList;
@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.title = @"Movie Finder";
    self.tableview.tableFooterView = [UIView new];
    
    queryparameter = [RestifyTMDbQueryParameters queryParameters];
    queryparameter.years = @[@"2017",@"2018"];
    queryparameter.maxRecords = 10;
    queryparameter.orderBy = TMDbOrderByRating;
    queryparameter.sortOrder = TMDbSortOrderDescending;
    
    UIImage* image = [UIImage imageNamed:@"settings-icon"];
    CGRect frameimg = CGRectMake(15,0, 22,22);
    UIButton *settingsBtn = [[UIButton alloc] initWithFrame:frameimg];
    [settingsBtn setBackgroundImage:image forState:UIControlStateNormal];
    [settingsBtn addTarget:self action:@selector(SettingsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [settingsBtn setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *settingsBarButton =[[UIBarButtonItem alloc] initWithCustomView:settingsBtn];
    self.navigationItem.rightBarButtonItem =settingsBarButton;
}

#pragma mark Tableview Delegate Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movieList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    TMDbMovie *movie = self.movieList[indexPath.row];
    cell.textLabel.text = movie.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Ratings: %.1f/10",movie.rating];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsZero;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (IBAction)searchBtnPressed:(id)sender {
    
    if ([RestifyTMDbConfig apiKey].length == 0) {
        [self showAlertWithText:@"Please setup your API Key in settings page."];
        return;
    }
    else if (_searchTextField.text.length == 0) {
        [self showAlertWithText:@"Please enter the movie you wish to search."];
        return;
    }
    
    queryparameter.keyword = _searchTextField.text;

    __block MovieListViewController* weakSelf = self;
    [[RestifyTMDbRequest sharedRequest] queryMoviesWithParameters:queryparameter completion:^(NSArray * _Nullable result, NSError * _Nullable error) {
        if (error) {
            [self showAlertWithText:error.localizedDescription];
        }
        weakSelf.movieList = result;
        [weakSelf.tableview reloadData];
    }];
}

-(void) showAlertWithText:(NSString *) text {
    UIAlertController* _alertController = [UIAlertController alertControllerWithTitle:@"Movie Finder" message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [_alertController addAction:ok];
    [self presentViewController:_alertController animated:YES completion:nil];
}

-(void) SettingsButtonPressed:(id) sender {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
