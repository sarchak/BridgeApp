//
//  PriceViewController.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/7/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "PriceViewController.h"
#import "Constants.h"

@interface PriceViewController ()
@property (weak, nonatomic) IBOutlet UITextField *price;

@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target:self action:@selector(donePressed)];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)];
    
}


-(void) donePressed {
    self.job.price = [NSNumber numberWithInt:[self.price.text intValue]];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) cancelPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
//    self.job.price = [NSNumber numberWithInt:[self.price.text intValue]];
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
