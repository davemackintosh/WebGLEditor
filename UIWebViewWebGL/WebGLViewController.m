//
//  WebGLViewController.m
//  UIWebViewWebGL
//
//  Created by Dave Mackintosh on 15/08/2013.
//  Copyright (c) 2013 Nathan de Vries. All rights reserved.
//

#import "WebGLViewController.h"

@protocol WebGLEnablement <NSObject>

-(void)_setWebGLEnabled:(BOOL)enabled;

@end

@interface WebGLViewController ()
@property(readwrite,nonatomic,weak)IBOutlet UIWebView *webView;
@end

@implementation WebGLViewController
@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    id webDocumentView = [webView performSelector:@selector(_browserView)];
    id backingWebView = [webDocumentView performSelector:@selector(webView)];
    [backingWebView _setWebGLEnabled:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  NSURL *editedURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"WebGL.html" isDirectory:NO];
  NSURLRequest* request;
  if ([[NSFileManager defaultManager] fileExistsAtPath:editedURL.path isDirectory:NULL])
    request = [NSURLRequest requestWithURL:editedURL];
  else
  {
    NSURL* defaultURL = [[NSBundle mainBundle] URLForResource:@"WebGL" withExtension:@"html"];
    request = [NSURLRequest requestWithURL:defaultURL];
  }
  [webView loadRequest:request];
}

-(void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
}

@end
