//
//  RestifyTMDbConfig.m
//  RestifyTMDb
//
//  Created by siva lingam on 13/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#import     "RestifyTMDbConfig.h"
#include    "Encryption.h"
#import     "Constants.h"

@implementation RestifyTMDbConfig

+(BOOL)configureWithKey:(NSString *)apiKey {
    @try {
        char *cString = strdup([apiKey cStringUsingEncoding:NSUTF8StringEncoding]);
        char *encryptedCString = encryptData(cString);
        NSString *encryptedString = [NSString stringWithCString:encryptedCString encoding:NSUTF8StringEncoding];
        if (encryptedString == nil) {
            return false;
        }
        [[NSUserDefaults standardUserDefaults] setObject:encryptedString forKey:kTMDbAPIKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } @catch (NSException *exception) {
        return false;
    }
    return true;
}

+(NSString*) apiKey {
    NSString *encryptedString = [[NSUserDefaults standardUserDefaults] objectForKey:kTMDbAPIKey];
    if (encryptedString.length == 0) {
        return nil;
    }
    char *cString = strdup([encryptedString cStringUsingEncoding:NSUTF8StringEncoding]);
    NSString *decryptedString = [NSString stringWithCString:decryptData(cString) encoding:NSUTF8StringEncoding];
    return decryptedString;
}


@end
