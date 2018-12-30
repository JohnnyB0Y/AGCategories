//
//  ViewController.m
//  AGCategories
//
//  Created by JohnnyB0Y on 2018/12/6.
//  Copyright © 2018 JohnnyB0Y. All rights reserved.
//

#import "ViewController.h"
#import "../Demo/TestUIImage/TestUIImageViewController.h"
#import "../Demo/TestNSDate/TestNSDateViewController.h"
#import "../Demo/TestNSString/TestNSStringViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSArray *_items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"点击测试";
    
    _items = @[@"UIImage", @"NSDate", @"NSBundle", @"NSString"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSString *title = _items[indexPath.row];
    [cell.textLabel setText:title];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIViewController *vc;
    
    
    if ( indexPath.row == 0 ) {
        vc = [TestUIImageViewController testUIImageViewController];
    }
    else if ( indexPath.row == 1 ) {
        vc = [TestNSDateViewController testNSDateViewController];
    }
    else if ( indexPath.row == 3 ) {
        vc = [TestNSStringViewController testNSStringViewController];
    }
    
    if ( vc ) {
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
