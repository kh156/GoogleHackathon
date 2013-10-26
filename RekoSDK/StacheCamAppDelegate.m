#import "StacheCamAppDelegate.h"
#import "RootViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import <DropboxImageLoader.h>

@implementation StacheCamAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString* appKey = @"wiri5m6stfn92ub";
	NSString* appSecret = @"z9hs5opxm68foaz";
	NSString *root = kDBRootDropbox;

    DBSession* dbSession =
    [[DBSession alloc] initWithAppKey:appKey appSecret:appSecret root:root];
    [DBSession setSharedSession:dbSession];
    
    
    RootViewController *controller = [[RootViewController alloc] init];
    [self.window addSubview:controller.view];
    [self.window makeKeyAndVisible];

    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([[DBSession sharedSession] handleOpenURL:url]) {
        if ([[DBSession sharedSession] isLinked]) {
            NSLog(@"App linked successfully!");
            // At this point you can start making API calls
        }
        return YES;
    }
    // Add whatever other url handling code your app requires here
    return NO;
}


@end
