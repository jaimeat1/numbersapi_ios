//
//  ViewController.m
//  NumbersApi
//
//  Created by Jaime on 12/10/14.
//  Copyright (c) 2014 Jaime Aranaz. All rights reserved.
//

#import "NAPMainViewController.h"
#import "NAPWebServices.h"
#import "NAPNumberFact.h"

@interface NAPMainViewController() <UITextFieldDelegate>

// Segmented control where user selects category
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;
// Field where user enters a number
@property (nonatomic, strong) IBOutlet UITextField *numberTxtFld;
// Label where fact is show to user
@property (nonatomic, strong) IBOutlet UILabel *factLbl;
// Activity view to indicate web service activity
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityView;

- (IBAction)searchButtonPressed:(id)sender;
- (IBAction)tryRandomButtonPressed:(id)sender;

@end

@implementation NAPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _activityView.hidden = YES;
    _factLbl.text = @"";
    [_numberTxtFld addTarget:self action:@selector(becomeFirstResponder) forControlEvents:UIControlEventEditingDidBegin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_numberTxtFld resignFirstResponder];
    _factLbl.text = @"";
    [self sendFactRequest:_numberTxtFld.text];
    
    return YES;
}

#pragma mark - IBAction methods

/**
 Called when user presses Search button. Starts a request in web service
 */
- (IBAction)searchButtonPressed:(id)sender
{
    [_numberTxtFld resignFirstResponder];
    _factLbl.text = @"";
    [self sendFactRequest:_numberTxtFld.text];
}

/**
 Called when user presses Try Random button. Starts a random request in web service
 */
- (IBAction)tryRandomButtonPressed:(id)sender
{
    [_numberTxtFld resignFirstResponder];
    [_numberTxtFld setText:@""];
    _factLbl.text = @"";
    
    [self sendFactRequest:@"random"];
}

#pragma mark - Private methods

/**
 Sends a request through web services API
 Uses blocks to execute in case of success or error
 @param number number to send in request; if "random", sends a random request to API
 */
- (void)sendFactRequest:(NSString *)number
{
    
    // Configure success block
    void (^successBlock)(NAPNumberFact *);
    successBlock = ^(NAPNumberFact *fact) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _activityView.hidden = YES;
            [_activityView stopAnimating];
            
            // Number found
            if (fact.found) {
                _numberTxtFld.text = [NSString stringWithFormat:@"%ld", (long)fact.number];
                _factLbl.text = fact.text;
                
            // Number not found, show alert
            } else {
                _numberTxtFld.text = @"";
                NSString *message;
                if (fact.number != 0) {
                    message = NSLocalizedString(@"Sorry, there is any interesting fact about that number",
                                                @"Text to show in alert view when the number is not found");;
                } else {
                    message = NSLocalizedString(@"Are you sure this is a number?",
                                                @"Text to show in alert view when the API can't understand the request");
                }
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Number not found!",
                                                                                          @"Title for alert view when API can't found a number")
                                                                message:message
                                                               delegate:self
                                                      cancelButtonTitle:NSLocalizedString(@"OK",
                                                                                          @"Button to dismiss alert view")
                                                      otherButtonTitles:nil];
                [alert show];
            }
        });
    };
 
    // Configure fail block
    void (^failBlock)(NSError *);
    failBlock = ^(NSError *error) {
        
        _activityView.hidden = YES;
        [_activityView stopAnimating];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",
                                                                                  @"Title for alert view when there was an error in web service")
                                                        message:NSLocalizedString(@"There was an error, please try again",
                                                                                  @"Text to show in alert view when there was an error in web service")
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"OK",
                                                                                  @"Button to dismiss alert view")
                                              otherButtonTitles:nil];
        [alert show];
    };
    
    // Show activity view
    _activityView.hidden = NO;
    [_activityView startAnimating];
    
    // Send request through web services
    switch ([_segmentedControl selectedSegmentIndex]) {
        
        // Math category
        case 0:
            [[NAPWebServices sharedInstance] getMathFactWithNumber:number
                                                          onSucces:successBlock
                                                            onFail:failBlock];
            break;
            
        // Date category
        case 1:
            [[NAPWebServices sharedInstance] getDateFactWithNumber:number
                                                          onSucces:successBlock
                                                            onFail:failBlock];
            break;
            
        // Year category
        case 2:
            [[NAPWebServices sharedInstance] getYearFactWithNumber:number
                                                          onSucces:successBlock
                                                            onFail:failBlock];
            break;
            
        // Trivia category
        case 3:
            [[NAPWebServices sharedInstance] getTriviaFactWithNumber:number
                                                            onSucces:successBlock
                                                              onFail:failBlock];
            break;
        default:
            break;
    }
    
    
}

@end
