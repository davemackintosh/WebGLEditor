//
//  EditTheFuckerViewController.m
//  UIWebViewWebGL
//
//  Created by Dave Mackintosh on 15/08/2013.
//  Copyright (c) 2013 Nathan de Vries. All rights reserved.
//

#import "EditTheFuckerViewController.h"

@interface EditTheFuckerViewController () <UITextViewDelegate>

@property(readwrite,nonatomic,weak)IBOutlet UITextView *editor;

@end

@implementation EditTheFuckerViewController
{
  NSURL *editedURL;
}
@synthesize editor;

- (void)viewDidLoad
{
    [super viewDidLoad];
  editedURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"WebGL.html" isDirectory:NO];
  if ([[NSFileManager defaultManager] fileExistsAtPath:editedURL.path isDirectory:NULL])
    editor.text = [NSString stringWithContentsOfURL:editedURL encoding:NSUTF8StringEncoding error:NULL];
  else
  {
    NSURL* defaultURL = [[NSBundle mainBundle] URLForResource:@"WebGL" withExtension:@"html"];
    editor.text = [NSString stringWithContentsOfURL:defaultURL encoding:NSUTF8StringEncoding error:NULL];
  }
}

-(void)textViewDidChange:(UITextView *)textView
{
  [textView.text writeToURL:editedURL atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}

@end
