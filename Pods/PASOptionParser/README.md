#PASOptionParser

I didn't really like the interfaces of the existing libs and I had an evening to kill.

This is almost certainly not the right pod for you and I would recommend shopping around before even looking here - you've been warned :).

---

Having said that I do need a gentle reminder of how to use this thing myself.

Example usages

```
int main(int argc, const char * argv[]) {
  @autoreleasepool {
    PASOptionParser *optionParser = [[PASOptionParser alloc] init]; {
      
      /*
       * Execute the block when the flag `-a` or `--text` is passed
       * The argument will be @YES
       *
       * Either `--no-a` or `--no-text` can be passed to invoke the block with the argument @NO
       */
      optionParser.onOption(@"-a/--text", ^(PASOption *option, id argument){
        
      });
      
      /*
       * Execute the block when the flag `-B` is passed with a required argument
       * The argument will be the value passed
       *
       * This handles `-B=7` and `-B 7` notation. The argument is required
       */
      optionParser.onOption(@"-B NUMBER", ^(PASOption *option, id argument){
        
      });
    }
    
    NSArray *arguments = [optionParser parseWithArgumentCount:argc arguments:argv];
		
    NSLog(@"%@", arguments);
  }
  return 0;
}
```