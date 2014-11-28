//
//  SMS.m
//  BanTrashSMS_iOS
//
//  Created by BlueCocoa on 14/11/28.
//
//

#import "SMS.h"
#import <fcntl.h>
#import <unistd.h>
#import <map>
#import <string>
#import <vector>
#import <sys/types.h>
#import "scws/scws.h"

using namespace std;

typedef pair<string, int> PAIR;

map<string,int> record;

struct cmpByTimes {
    bool operator()(const PAIR& a, const PAIR& b){
        return (a.second > b.second);
    }
};

static SMS * sharedInstance = nil;

@interface SMS()

@property (nonatomic, strong) NSDictionary * trashData;

@end

@implementation SMS

@synthesize trashData;

+ (instancetype)sharedInstance{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (void)loadTrashData:(NSString *)path{
    self.trashData = [NSDictionary dictionaryWithContentsOfFile:path];
}

#ifdef DEVELOPMENT

- (void)trainWithTextsPath:(NSString *)path{
    NSEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:path];
    NSString * filename;
    while ((filename = [enumerator nextObject]))
    {
        FILE *file = fopen([[path stringByAppendingString:filename] UTF8String], "r");
        long fileSizeBytes = 0;
        if(file > 0){
            fseek(file, 0, SEEK_END);
            fileSizeBytes = ftell(file);
            fseek(file, 0, SEEK_SET);
            char * trash = (char *)malloc(fileSizeBytes);
            fread(trash, fileSizeBytes, 1, file);
            
            scws_t s = scws_new();
            scws_set_charset(s, "utf8");
            scws_add_dict(s,"/usr/bin/dict.utf8.xdb",SCWS_XDICT_XDB|SCWS_XDICT_MEM);
            scws_set_rule(s,"/usr/bin/rules.utf8.ini");
            scws_set_duality(s,true);
            scws_set_ignore(s,true);
            scws_send_text(s,trash,(int)strlen(trash));
            
            struct scws_topword * top = scws_get_tops(s, 50000, (char *)"nr,vn,v,r,h,n,vd,a,ns,p,t,m,ns,vg,vd,an,mt,ng,uj,k,q,nz,ag,b,s,d");
            while (top != NULL)
            {
                record[top->word] += top->times;
                top = top->next;
            }
            scws_free_tops(top);
            scws_free(s);
            free(trash);
        }
    }
    vector<PAIR> trash_freq(record.begin(),record.end());
    sort(trash_freq.begin(), trash_freq.end(), cmpByTimes());
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:trash_freq.size()];
    
    for ( int i = 0; i != trash_freq.size(); i++ ){
        [dict setValue:@(trash_freq[i].second) forKey:[NSString stringWithUTF8String:trash_freq[i].first.c_str()]];
    }
    self.trashData = [NSDictionary dictionaryWithDictionary:dict];
    
    [dict writeToFile:TrashDataFile atomically:YES];
}

#endif

- (NSDictionary *)isTrashSMS:(NSString *)sms{
    if (self.trashData == nil) {
        return nil;
    }
    const char * trash = [sms UTF8String];
    scws_t s = scws_new();
    scws_set_charset(s, "utf8");
    scws_add_dict(s,"/usr/bin/dict.utf8.xdb",SCWS_XDICT_XDB);
    scws_set_rule(s,"/usr/bin/rules.utf8.ini");
    scws_set_duality(s,true);
    scws_set_ignore(s,true);
    scws_send_text(s,trash,(int)strlen(trash));
    
    double score = 0;
    scws_res_t res, cur;
    while ((res = cur = scws_get_result(s)))
    {
        while (cur != NULL)
        {
            char * word = (char *)malloc(sizeof(char *));
            sprintf(word, "%.*s",cur->len, trash+cur->off);
            if (strlen(word) > 0) {
                NSString * weight = [self.trashData valueForKey:[NSString stringWithUTF8String:word]];
                if (weight != nil) {
                    score += [weight intValue];
                }
            }
            
            cur = cur->next;
        }
        scws_free_result(res);
    }
    scws_free(s);
    return @{@"Trash":@(score/sms.length > TrashSMSThreshold),@"Score":@(score),@"Threshold":@(TrashSMSThreshold)};
}

@end
