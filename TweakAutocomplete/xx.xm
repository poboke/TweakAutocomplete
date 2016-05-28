
// This file just for debuging

@interface SpringBoard : UIApplication
- (void)applicationDidFinishLaunching:(UIApplication *)application;
@end


%group iOS9Group

%hook SpringBoard

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    %log(@"application:", application);
    %orig;
}

%end // end hook

%end // end group


%ctor {
    %init(iOS9Group);
}
