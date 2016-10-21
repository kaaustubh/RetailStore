//
//  ProductDetailViewController.m
//  RetailStore
//
//  Created by Kaustubh on 21/10/16.
//  Copyright © 2016 Kaustubh. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "Utils.h"
#import "ProductManager.h"

@interface ProductDetailViewController ()

@property (nonatomic, weak) IBOutlet UILabel *productTitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *productImageView;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UIButton *cartButton;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateView];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // Do any additional setup after loading the view.
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


-(void)updateView
{
    _productTitleLabel.text = _product.name;
    _priceLabel.text = [Utils getLocalCurrencyForPrice:_product.price];
    [self toggleCartProduct];
    _productImageView.image = [UIImage imageNamed:_product.image];
}

-(IBAction)cartButonTapped:(id)sender
{
    [self toggleCartProduct];
}

-(void)toggleCartProduct
{
    if(_cartButton.tag)
    {
        [[ProductManager sharedInstance] addProductToCart:_product];
        _cartButton.tag=1;
        [_cartButton setTitle:@"Remove from Cart" forState:UIControlStateNormal];
    }
    else
    {
        [[ProductManager sharedInstance] removeProductToCart:_product];
        [_cartButton setTitle:@"Add to Cart" forState:UIControlStateNormal];
        _cartButton.tag=0;
    }
}

@end
