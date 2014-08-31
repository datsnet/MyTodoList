//
//  ColorViewController.m
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "ColorViewController.h"

@interface ColorViewController ()

@end

@implementation ColorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _label.text = _text;
    _label.textColor = _color;
}

@end
