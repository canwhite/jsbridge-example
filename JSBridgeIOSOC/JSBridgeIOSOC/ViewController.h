//
//  ViewController.h
//  JSBridgeIOSOC
//
//  Created by BeiChen.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"

@interface ViewController : UIViewController

@property WKWebView *webView;
@property NSUserDefaults *defaults;
@property WebViewJavascriptBridge *bridge;
@property WKWebViewConfiguration *webConfig;


//几个输入框，当然对应有改变值的button
@property(strong,nonatomic) UITextField * nameText;
@property(strong,nonatomic) UITextField * cookieText;
@property(strong,nonatomic) UILabel * userLabel;



- (void)setWebConfig;
- (void)initView;
- (void)registerHandlers;


- (void)syncCookie:(NSString *)cookie;
+ (BOOL)judgeIsEmptyWithString:(NSString *)string;
+ (void)addToastWithString:(NSString *)string inView:(UIView *)view;
+ (void) removeToastWithView:(NSTimer *)timer;

@end

