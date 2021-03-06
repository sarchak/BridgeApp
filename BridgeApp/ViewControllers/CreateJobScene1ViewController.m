//
//  CreateJobScene1ViewController.m
//  BridgeApp
//
//  Created by Shrikar Archak on 3/4/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "CreateJobScene1ViewController.h"
#import "CreateJobScene2ViewController.h"
#import "CategoryCell.h"
#import "User.h"
#import "ChameleonFramework/Chameleon.h"
@interface CreateJobScene1ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *categories;
@end

@implementation CreateJobScene1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* Setup Delegate Methods */
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.categories = @[@"Graphic Design", @"Social Media Marketing", @"Promotional Material", @"Training/Tutoring", @"Web Development"];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    /* Register the uitableview cell */
    [self.tableView registerNib:[UINib nibWithNibName:@"CategoryCell" bundle:nil] forCellReuseIdentifier:@"CategoryCell"];

    self.view.backgroundColor = TABLEVIEWCELLCOLOR;
//    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.title = @"Create Job";
}

-(void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CreateJobScene2ViewController *cvc = [[CreateJobScene2ViewController alloc] init];
    cvc.category = self.categories[indexPath.row];
    [self.navigationController pushViewController:cvc animated:YES];
    
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    cell.categoryLabel.text = self.categories[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.superview.backgroundColor = [UIColor colorWithRed:247.0/255 green:246.0/255 blue:244.0/255 alpha:1];
    return cell;
}

@end
