//
//  OpenFLParse.h
//  OpenFLParse
//
//  Created by thomas baudon on 20/03/2015.
//
//

#ifndef OpenFLParse_OpenFLParse_h
#define OpenFLParse_OpenFLParse_h

#include <hx/CFFI.h>

#include "ParseWrapper.h"

namespace parse {
    
    ParseWrapper* wrapper;
    
    AutoGCRoot* eval_RegisterSucces = 0;
    AutoGCRoot* eval_RegisterFail = 0;
        
    static void initialize(value appId, value clientKey);
    
    static void subscribe(value onRegister, value onRegisterFail);
    
    void registerSuccess(const char * installId);
    
    void registerFail();
    
}


#endif
