//
//  SettingsViewController.m
//  The Movies
//
//  Created by siva lingam on 14/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#import "SettingsViewController.h"
#import <RestifyTMDb/RestifyTMDb.h>

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *apiKeyTextField;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Settings";
}

- (IBAction)saveButtonPressed:(id)sender {
    
    if (_apiKeyTextField.text.length > 0) {
        [RestifyTMDbConfig configureWithKey:_apiKeyTextField.text];
        [self.navigationController popViewControllerAnimated:true];
    }
    
}


@end
