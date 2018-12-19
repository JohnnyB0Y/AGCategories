//
//  TestUIImageViewController.m
//  AGCategories
//
//  Created by JohnnyB0Y on 2018/12/19.
//  Copyright © 2018 JohnnyB0Y. All rights reserved.
//

#import "TestUIImageViewController.h"
#import "../../AGCategories/Categories/UIImage/UIImage+AGTransform.h"
#import "../../AGCategories/Categories/UIImage/UIImage+AGGenerate.h"

@interface TestUIImageViewController ()

/** img view */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)leftRotate:(id)sender;
- (IBAction)rightRotate:(id)sender;
- (IBAction)flipVertical:(id)sender;
- (IBAction)flipHorizontal:(id)sender;

- (IBAction)zoom:(id)sender;
- (IBAction)magnify:(id)sender;

- (IBAction)blur:(id)sender;
- (IBAction)corner:(id)sender;
- (IBAction)circle:(id)sender;
- (IBAction)origin:(id)sender;


@end

@implementation TestUIImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.imageView];
    
    // 加载原图
    [self origin:nil];
}

+ (instancetype)testUIImageViewController
{
    TestUIImageViewController *vc = [[TestUIImageViewController alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
    return vc;
}

- (IBAction)leftRotate:(id)sender {
    
    UIImage *image = self.imageView.image;
    
    image = [image ag_imageRotate:UIImageOrientationLeft];
    
    [self.imageView setImage:image];
}

- (IBAction)rightRotate:(id)sender {
    UIImage *image = self.imageView.image;
    
    image = [image ag_imageRotate:UIImageOrientationRight];
    
    [self.imageView setImage:image];
}

- (IBAction)flipVertical:(id)sender {
    UIImage *image = self.imageView.image;
    
    image = [image ag_imageFlipVertical];
    
    [self.imageView setImage:image];
}

- (IBAction)flipHorizontal:(id)sender {
    UIImage *image = self.imageView.image;
    
    image = [image ag_imageFlipHorizontal];
    
    [self.imageView setImage:image];
}

- (IBAction)zoom:(id)sender {
    UIImage *image = self.imageView.image;
    
    image = [image ag_imageScale:0.8];
    NSLog(@"缩小尺寸 %@", image);
    [self.imageView setImage:image];
}

- (IBAction)magnify:(id)sender {
    UIImage *image = self.imageView.image;
    
    image = [image ag_imageScale:1.2];
    NSLog(@"增大尺寸 %@", image);
    [self.imageView setImage:image];
}

- (IBAction)blur:(id)sender {
    UIImage *image = self.imageView.image;
    image = [image ag_imageByGaussianBlur:10.];
    [self.imageView setImage:image];
}

- (IBAction)corner:(id)sender {
    UIImage *image = [UIImage imageNamed:@"caiyan"];
    UIRectCorner cornerOpt = UIRectCornerTopLeft| UIRectCornerTopRight| UIRectCornerBottomRight;
    image = [image ag_imageByClipCorner:cornerOpt radius:134 * [UIScreen mainScreen].scale];
    [self.imageView setImage:image];
}

- (IBAction)circle:(id)sender {
    UIImage *image = [UIImage imageNamed:@"caiyan"];
    image = [image ag_imageByClipCircle];
    [self.imageView setImage:image];
}

- (IBAction)origin:(id)sender {
    UIImage *image = [UIImage imageNamed:@"caiyan"];
    NSLog(@"原图 %@", image);
    [self.imageView setImage:image];
}

@end
