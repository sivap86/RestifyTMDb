//
//  Encryption.h
//  RestifyTMDb
//
//  Created by siva lingam on 14/1/19.
//  Copyright © 2019 Gemalto (security to be free). All rights reserved.
//

#ifndef Encryption_h
#define Encryption_h

#include <stdio.h>
/** Encrypt the data using secret key
 param : string to be encrypted
 return encrypted string
 since 1.0
 */
char* encryptData(char* data);

/** Decrypt the data using secret key
 param : string to be decrypted
 return decrypted string
 since 1.0
 */
char *decryptData(char* data);

#endif /* Encryption_h */
