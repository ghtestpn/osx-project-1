//
//  main.m
//  testkurs1
//

#import <Foundation/Foundation.h>

@interface Cell: NSObject
@property NSMutableArray *DNA;
-(id)init;
-(int)hammingDistance:(Cell*)cell;
@end

@interface Cell (mutator)
-(void)mutate:(int)proc;
@end

@implementation Cell{
    unsigned char i,j,k;
}

-(id)init{
    _DNA = [[NSMutableArray alloc] initWithCapacity:100];
    NSString *A=@"A", *T=@"T", *G=@"G", *C=@"C";
    self=[super init];
    if(self){
        i=0;
        while(i<100){
            if(SecRandomCopyBytes(kSecRandomDefault,1,&k)==errSecSuccess) _DNA[i]=k==1?A:k==2?T:k==3?G:k==4?C:@"0";
            if(![_DNA[i] isEqual:@"0"])
                i++;
        }
    }
    return self;
}
-(int)hammingDistance:(Cell*)cell{
    int unequal=0;
    [self printDNA];
    [cell printDNA];
    for(i=0;i<100;i++){
        if(cell.DNA[i]!=_DNA[i]) unequal++;
    }
    return unequal;
}
-(void)printDNA{
    NSString *DNAstring=[[NSString alloc] init];
    for(i=0;i<100;i++){
        DNAstring=[DNAstring stringByAppendingString:_DNA[i]];
    }
    NSLog(DNAstring);
}


@end

@implementation Cell(mutator)
-(void)mutate:(int)proc{
    i=0;
    NSString *A=@"A", *T=@"T", *G=@"G", *C=@"C";
    while(i<proc){
        SecRandomCopyBytes(kSecRandomDefault, 1, &k);
        if(k>99||[_DNA[k] isEqual:@"0"]) continue;
        else {_DNA[k]=@"0";i++;}
    }
    i=0;
    while(i<100){
        if(![_DNA[i]isEqual:@"0"]){i++; continue;};
        SecRandomCopyBytes(kSecRandomDefault, 1, &k);
        _DNA[i]=k==1?A:k==2?T:k==3?G:k==4?C:@"0";
    }
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        char unequal;
        // insert code here...
        Cell *c1 =[[Cell alloc] init];
        Cell *c2 =[[Cell alloc] init];
        unequal=[c1 hammingDistance:c2];
        NSLog(@"different: %d",unequal);
        [c1 mutate:1];
        [c2 mutate:1];
        unequal=[c1 hammingDistance:c2];
        NSLog(@"different: %d",unequal);
    }
    return 0;
}
