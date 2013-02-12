//
//  RomboViewController.m
//  OpenGLES_Texture1
//
//  Created by Antonio Trejo on 2/12/13.
//  Copyright (c) 2013 Antonio Trejo. All rights reserved.
//

#import "RomboViewController.h"
#import "AGLKVertexAttribArrayBuffer.h"
#import "AGLKContext.h"

typedef struct{
    GLKVector3 positionCoords;
    GLKVector2 textureCoords;
} SceneVertex;

static const SceneVertex vertices[] = {
    {{-0.5, 0.0, 0.0}, {0.0, 0.0}},
    {{ 0.0,-0.5, 0.0}, {1.0, 0.0}},
    {{ 0.5, 0.0, 0.0}, {0.0, 0.0}},
    {{ 0.5, 0.0, 0.0}, {0.0, 0.0}},
    {{ 0.0, 0.5, 0.0}, {0.0, 1.0}},
    {{-0.5, 0.0, 0.0}, {0.0, 0.0}}
};

@interface RomboViewController ()

@end

@implementation RomboViewController

@synthesize baseEffect;
@synthesize vertexBuffer;

- (void)viewDidLoad
{
    [super viewDidLoad];

    GLKView *view = (GLKView *) self.view;
    NSAssert([view isKindOfClass:[GLKView class]], @"View controller's view is not a GLView");
    
    view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    [AGLKContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f,
                                                   1.0f,
                                                   1.0f,
                                                   1.0f);
    
    ((AGLKContext *) view.context).clearColor = GLKVector4Make(0.0f,
                                                               0.0f,
                                                               0.0f,
                                                               1.0f);
    
    
    self.vertexBuffer = [[AGLKVertexAttribArrayBuffer alloc]
                         initWithAttribStride:sizeof(SceneVertex)
                         numberOfVertices:sizeof(vertices) / sizeof(SceneVertex)
                         bytes:vertices
                         usage:GL_STATIC_DRAW];
    
    
    
    CGImageRef imageRef = [UIImage imageNamed:@"texture.jpg"].CGImage;
    
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithCGImage:imageRef
                                                               options:nil
                                                                 error:NULL];
    
    self.baseEffect.texture2d0.name = textureInfo.name;
    self.baseEffect.texture2d0.target = textureInfo.target;
    
    
}

- (void) glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [self.baseEffect prepareToDraw];
    
    [(AGLKContext *) view.context clear:GL_COLOR_BUFFER_BIT];
    
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
                           numberOfCoordinates:3
                                  attribOffset:offsetof(SceneVertex, positionCoords)
                                  shouldEnable:YES];
    
    [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribTexCoord0
                           numberOfCoordinates:2
                                  attribOffset:offsetof(SceneVertex, textureCoords)
                                  shouldEnable:YES];
    
    [self.vertexBuffer drawArrayWithMode:GL_TRIANGLES
                        startVertexIndex:0
                        numberOfVertices:sizeof(vertices) / sizeof(SceneVertex)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
