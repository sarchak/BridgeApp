//
//  CreateJobScene2ViewController.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "CreateJobScene2ViewController.h"
#import "TitleSubtitleCell.h"
#import "TextViewController.h"
#import "Constants.h"
#import "THDatePickerViewController.h"
#import "PriceViewController.h"
#import "ParseClient.h"
#import "Parse/Parse.h"

@interface CreateJobScene2ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) THDatePickerViewController * datePicker;
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
@end

@implementation CreateJobScene2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleSubtitleCell" bundle:nil] forCellReuseIdentifier:@"TitleSubtitleCell"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.job = [[Job alloc] init];
    self.job.category = self.category;
    self.job.owner = [User currentUser];
    self.job.status = JobStatusPendingAssignment;
    NSLog(@"Dictionary : %@", self.job);
    
    /* Configure date picker */
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"dd/MM/yyyy --- HH:mm"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TextViewController *tvc = [[TextViewController alloc] init];
    tvc.job = self.job;
    if(indexPath.row == 0){
        tvc.isTitle = YES;
        [self.navigationController pushViewController:tvc animated:YES];
    } else if(indexPath.row == 1) {
        tvc.isTitle = NO;
        [self.navigationController pushViewController:tvc animated:YES];
    } else if(indexPath.row == 3){
        PriceViewController *pvc = [[PriceViewController alloc] init];
        pvc.job = self.job;
        [self.navigationController pushViewController:pvc animated:YES];
    }

}

-(void)viewWillAppear:(BOOL)animated{
    [self displayJob];
}

-(void) titleSubtitleCell:(TitleSubtitleCell *)cell iconTapped:(BOOL)tapped{
    NSLog(@"Calendar icon tapped");
    [self showCalendarView];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TitleSubtitleCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TitleSubtitleCell"];

    switch (indexPath.row) {
        case 0: cell.titleLabel.text =@"Write Title";
                cell.subTitleLabel.text = @"Give your job a descriptive headline.";
                break;
        case 1: cell.titleLabel.text =@"Write Summary";
            cell.subTitleLabel.text = @"Summarize the highlights of your job.";
            break;
        case 2: cell.titleLabel.text =@"Select a due date";
            cell.subTitleLabel.text = @"When do you want the job to be completed by.";
            break;
        case 3: cell.titleLabel.text =@"Set Price";
            cell.subTitleLabel.text = @"Price you are willing to pay for this job.";
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

#pragma DatePicker

-(void) showCalendarView{
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    self.datePicker.date = self.curDate;
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:NO];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
    [self.datePicker setDisableHistorySelection:YES];
    [self.datePicker setDisableFutureSelection:NO];
    //[self.datePicker setAutoCloseCancelDelay:5.0];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColorSelected:[UIColor yellowColor]];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        return (tmp % 5 == 0);
    }];
    [self presentSemiViewController:self.datePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(0.2),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];
}


- (IBAction)createJob:(id)sender {
    PFObject *jobObject = [PFObject objectWithClassName:@"Jobs"];
    jobObject[TITLE] = self.job.title;
    jobObject[SUMMARY] = self.job.jobDescription;
    jobObject[DUE_DATE] = self.job.dueDate;
    jobObject[PRICE] = self.job.price;
    jobObject[CATEGORY] = self.category;
    jobObject[OWNER] = [PFUser currentUser];
    jobObject[JOBSTATUS] = [NSNumber numberWithInt:self.job.status];
    
//    [jobObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if(error == nil){
//            NSLog(@"Job created");
//        } else {
//            NSLog(@"Job creation failed :%@", error);
//        }
//
//    }];
    
    [self.job saveWithCompletion:^(NSError *error) {
        NSLog(@"Save with completion : %@", error);
    }];
}


- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker {
    self.curDate = datePicker.date;
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}


- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker {
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

- (void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate {
    NSLog(@"Date selected: %@",[_formatter stringFromDate:selectedDate]);
    self.job.dueDate = selectedDate;
}

-(void) displayJob{
    NSLog(@"Title : %@", self.job.title);
    NSLog(@"Summary : %@", self.job.jobDescription);
    NSLog(@"Due Date : %@", self.job.dueDate);
    NSLog(@"Price : %@", self.job.price);
}

@end
