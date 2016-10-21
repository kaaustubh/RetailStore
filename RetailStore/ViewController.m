//
//  ViewController.m
//  RetailStore
//
//  Created by Kaustubh on 21/10/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

#import "ViewController.h"
#import "Utils.h"
#import "ProductManager.h"
#import "ProductDetailViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) Product *selectedProduct;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Show Cart" style:UIBarButtonItemStylePlain target:self action:@selector(showCartButtonTapped:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(IBAction)showCartButtonTapped:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *productsForThisCategory = [[ProductManager sharedInstance] getProductsForCategory:[[[ProductManager sharedInstance] getAllCategories] objectAtIndex:section]];
    return [productsForThisCategory count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpletableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    NSMutableArray *productsForThisCategory = [[ProductManager sharedInstance] getProductsForCategory:[[[ProductManager sharedInstance] getAllCategories] objectAtIndex:indexPath.section]];
    
    Product *product = [productsForThisCategory objectAtIndex:indexPath.row];
    cell.textLabel.text = product.name;
    cell.detailTextLabel.text = [Utils getLocalCurrencyForPrice:product.price];
    return cell;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[ProductManager sharedInstance] getAllCategories] objectAtIndex:section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[ProductManager sharedInstance] getAllCategories] count];
}

#pragma UItableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *productsForThisCategory = [[ProductManager sharedInstance] getProductsForCategory:[[[ProductManager sharedInstance] getAllCategories] objectAtIndex:indexPath.section]];
    
    Product *product = [productsForThisCategory objectAtIndex:indexPath.row];
    _selectedProduct = product;
    [self performSegueWithIdentifier:@"ProductDetailSegueId" sender:self];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier caseInsensitiveCompare:@"ProductDetailSegueId"] == NSOrderedSame)
    {
        ProductDetailViewController *destinationViewController = (ProductDetailViewController*) segue.destinationViewController;
        destinationViewController.product = _selectedProduct;
    }
}

@end
