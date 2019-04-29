//
//  main.m
//  testkurs1
//

#import <Foundation/Foundation.h>

@interface Cell: NSObject
@property NSMutableArray *DNA;
@property (readonly) NSArray *nucleotides;
-(id)init;
-(int)hammingDistance:(Cell*)cell;
@end

@interface Cell (mutator)
-(void)mutate:(int)proc;
@end

@implementation Cell
@synthesize DNA;
-(id)init{
    self=[super init]; if(self){
        _nucleotides=[[NSArray alloc] initWithObjects:@"A", @"T", @"G", @"C", nil];
        DNA = [[NSMutableArray alloc] initWithCapacity:100];
        while([DNA count]<100) [DNA addObject:[_nucleotides objectAtIndex:arc4random() %4]];
/*        NSString *A=@"A", *T=@"T", *G=@"G", *C=@"C";
            while(i<100){
                if(SecRandomCopyBytes(kSecRandomDefault,1,&k)==errSecSuccess) DNA[i]=k==1?A:k==2?T:k==3?G:k==4?C:@"0";
                if(![[DNA objectAtIndex:i] isEqual:@"0"]) i++;
            }
*/    }
    return self;
}
-(int)hammingDistance:(Cell*)cell{
    int unequal=0;
    [self printDNA];
    [cell printDNA];
    NSEnumerator *selfenum=[DNA objectEnumerator];
    NSEnumerator *cellenum=[[cell DNA] objectEnumerator];
    id DNAObject;
    while(DNAObject = [selfenum nextObject]) if(DNAObject!=[cellenum nextObject]) unequal++;
    return unequal;
}
-(void)printDNA{
    NSLog(@"%@", [DNA componentsJoinedByString:[[NSString alloc] init]]);
//    NSLog(@"%@",DNA);
}


@end

@implementation Cell(mutator)
-(void)mutate:(int)proc{
    NSArray *listReplaced = [[NSArray alloc] init];
    while([listReplaced count]<proc){
        NSNumber *k=[[NSNumber alloc] initWithUnsignedChar:(arc4random() % 99)];
        if(![listReplaced containsObject:k]){
            [DNA replaceObjectAtIndex:[k intValue] withObject:[_nucleotides objectAtIndex:arc4random() %4]];
            listReplaced=[listReplaced arrayByAddingObject:k];
        }
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
        [c1 mutate:30];
        [c2 mutate:30];
        unequal=[c1 hammingDistance:c2];
        NSLog(@"different: %d",unequal);
    }
    return 0;
}
