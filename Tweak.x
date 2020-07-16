#include <RemoteLog.h>
@interface SBWiFiManager : NSObject
+ (instancetype)sharedInstance;
- (NSString *)currentNetworkName;
- (BOOL)wiFiEnabled;
@end

NSNetService *netService = nil;
BOOL published = NO;


static void publish(){
    if ([[%c(SBWiFiManager) sharedInstance] wiFiEnabled] && [[%c(SBWiFiManager) sharedInstance] 
            currentNetworkName]) {
        netService =  [[NSNetService alloc] initWithDomain:@"local."
                                                  type:@"_ahoy._tcp."
                                                  name:@"Ahoy" 
                                                  port: 55443];
    
        [netService publish];
    }
    else{
        [netService stop];
    }
}


%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)arg1 {
    %orig;
    publish();
}
%end


%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)publish,
                                    CFSTR("com.apple.system.config.network_change"),
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);}

