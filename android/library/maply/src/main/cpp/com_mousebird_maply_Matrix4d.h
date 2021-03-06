/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class com_mousebird_maply_Matrix4d */

#ifndef _Included_com_mousebird_maply_Matrix4d
#define _Included_com_mousebird_maply_Matrix4d
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     com_mousebird_maply_Matrix4d
 * Method:    nativeInit
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_com_mousebird_maply_Matrix4d_nativeInit
  (JNIEnv *, jclass);

/*
 * Class:     com_mousebird_maply_Matrix4d
 * Method:    initialise
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_com_mousebird_maply_Matrix4d_initialise
  (JNIEnv *, jobject);

/*
 * Class:     com_mousebird_maply_Matrix4d
 * Method:    dispose
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_com_mousebird_maply_Matrix4d_dispose
  (JNIEnv *, jobject);

/*
 * Class:     com_mousebird_maply_Matrix4d
 * Method:    inverse
 * Signature: ()Lcom/mousebird/maply/Matrix4d;
 */
JNIEXPORT jobject JNICALL Java_com_mousebird_maply_Matrix4d_inverse
  (JNIEnv *, jobject);

/*
 * Class:     com_mousebird_maply_Matrix4d
 * Method:    transpose
 * Signature: ()Lcom/mousebird/maply/Matrix4d;
 */
JNIEXPORT jobject JNICALL Java_com_mousebird_maply_Matrix4d_transpose
  (JNIEnv *, jobject);

/*
 * Class:     com_mousebird_maply_Matrix4d
 * Method:    translate
 * Signature: (DDD)Lcom/mousebird/maply/Matrix4d;
 */
JNIEXPORT jobject JNICALL Java_com_mousebird_maply_Matrix4d_translate
  (JNIEnv *, jclass, jdouble, jdouble, jdouble);

/*
 * Class:     com_mousebird_maply_Matrix4d
 * Method:    scale
 * Signature: (DDD)Lcom/mousebird/maply/Matrix4d;
 */
JNIEXPORT jobject JNICALL Java_com_mousebird_maply_Matrix4d_scale
  (JNIEnv *, jclass, jdouble, jdouble, jdouble);

/*
 * Class:     com_mousebird_maply_Matrix4d
 * Method:    multiply
 * Signature: (Lcom/mousebird/maply/Point4d;)Lcom/mousebird/maply/Point4d;
 */
JNIEXPORT jobject JNICALL Java_com_mousebird_maply_Matrix4d_multiply
  (JNIEnv *, jobject, jobject);

#ifdef __cplusplus
}
#endif
#endif
