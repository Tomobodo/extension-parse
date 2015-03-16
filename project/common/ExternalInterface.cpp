#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include "Utils.h"

using namespace parse;

static void parse_test() {
    test();
}
DEFINE_PRIM(parse_test, 0);

extern "C" void parse_main () {
	
	val_int(0); // Fix Neko init
	
}
DEFINE_ENTRY_POINT (parse_main);



extern "C" int parse_register_prims () { return 0; }