#import "Core.pbrpc.h"

#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>

@implementation Core

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  return (self = [super initWithHost:host packageName:@"org.dash.platform.dapi" serviceName:@"Core"]);
}

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}


#pragma mark getLastUserStateTransitionHash(LastUserStateTransitionHashRequest) returns (LastUserStateTransitionHashResponse)

- (void)getLastUserStateTransitionHashWithRequest:(LastUserStateTransitionHashRequest *)request handler:(void(^)(LastUserStateTransitionHashResponse *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCTogetLastUserStateTransitionHashWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCTogetLastUserStateTransitionHashWithRequest:(LastUserStateTransitionHashRequest *)request handler:(void(^)(LastUserStateTransitionHashResponse *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"getLastUserStateTransitionHash"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LastUserStateTransitionHashResponse class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark subscribeToBlockHeadersWithChainLocks(BlockHeadersWithChainLocksRequest) returns (stream BlockHeadersWithChainLocksResponse)

- (void)subscribeToBlockHeadersWithChainLocksWithRequest:(BlockHeadersWithChainLocksRequest *)request eventHandler:(void(^)(BOOL done, BlockHeadersWithChainLocksResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCTosubscribeToBlockHeadersWithChainLocksWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCTosubscribeToBlockHeadersWithChainLocksWithRequest:(BlockHeadersWithChainLocksRequest *)request eventHandler:(void(^)(BOOL done, BlockHeadersWithChainLocksResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"subscribeToBlockHeadersWithChainLocks"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BlockHeadersWithChainLocksResponse class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
@end
