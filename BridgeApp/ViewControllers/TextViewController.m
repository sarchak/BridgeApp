//
//  TextViewController.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *jobTextView;

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.jobTextView becomeFirstResponder];
 
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target:self action:@selector(donePressed)];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)];
    self.view.backgroundColor = TABLEVIEWCELLCOLOR;
    if(self.isTitle){
        self.title = @"Title";
    }else {
        self.title = @"Job Summary";        
    }
}


-(void) donePressed {
    [self.jobTextView resignFirstResponder];
    if(self.isTitle){
        self.job.title = self.jobTextView.text;
    } else {
        self.job.jobDescription = self.jobTextView.text;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) cancelPressed {
    [self.jobTextView resignFirstResponder];    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

-(void) keyBoardWillShow:(NSNotification*) notification{

    NSDictionary *info = notification.userInfo;
    
    CGRect keyboardSize = [info[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat height = keyboardSize.size.height;
    NSLog(@"Keyboard will show %f", height);
    self.heightConstraint.constant = self.view.frame.size.height - height;
}

-(void) keyBoardWillHide:(NSNotification*) notification{
    NSLog(@"Keyboard will hide");
    self.heightConstraint.constant = self.view.frame.size.height;
}

-(void)viewWillDisappear:(BOOL)animated{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
