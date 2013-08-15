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
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWasShown:)
                                               name:UIKeyboardDidShowNotification object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillBeHidden:)
                                               name:UIKeyboardWillHideNotification object:nil];
  
  
  editedURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"WebGL.html" isDirectory:NO];
  if ([[NSFileManager defaultManager] fileExistsAtPath:editedURL.path isDirectory:NULL]) {
    [editor setFont:[UIFont fontWithName:@"Courier" size:10]];
    [editor setAutocorrectionType:UITextAutocorrectionTypeNo];
    [editor setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    editor.text = [NSString stringWithContentsOfURL:editedURL encoding:NSUTF8StringEncoding error:NULL];
  } else {
    NSURL* defaultURL = [[NSBundle mainBundle] URLForResource:@"WebGL" withExtension:@"html"];
    [editor setFont:[UIFont fontWithName:@"Courier" size:10]];
    [editor setAutocorrectionType:UITextAutocorrectionTypeNo];
    [editor setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    editor.text = [NSString stringWithContentsOfURL:defaultURL encoding:NSUTF8StringEncoding error:NULL];
  }
}

-(void)textViewDidChange:(UITextView *)textView
{
  [textView.text writeToURL:editedURL atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}

- (void)keyboardWasShown:(NSNotification*)notification {
  NSDictionary* info = [notification userInfo];
  CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
  self.editor.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - keyboardSize.height);
}

- (void)keyboardWillBeHidden:(NSNotification*)notification {
  self.editor.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

@end
