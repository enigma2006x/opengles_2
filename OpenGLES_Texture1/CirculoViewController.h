//
//  CirculoViewController.h
//  OpenGLES_Texture1
//
//  Created by Antonio Trejo on 2/12/13.
//  Copyright (c) 2013 Antonio Trejo. All rights reserved.
//

#import <GLKit/GLKit.h>
//http://en.wikipedia.org/wiki/Unit_circle
@class AGLKVertexAttribArrayBuffer;

@interface CirculoViewController : GLKViewController

@property (nonatomic, strong) GLKBaseEffect *baseEffect;
@property (nonatomic, strong) AGLKVertexAttribArrayBuffer *vertexBuffer;

@end
