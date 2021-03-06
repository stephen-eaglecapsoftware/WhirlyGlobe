/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class com_mousebird_maply_VectorIterator */

#ifndef _Included_com_mousebird_maply_VectorIterator
#define _Included_com_mousebird_maply_VectorIterator
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     com_mousebird_maply_VectorIterator
 * Method:    nativeInit
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_com_mousebird_maply_VectorIterator_nativeInit
  (JNIEnv *, jclass);

/*
 * Class:     com_mousebird_maply_VectorIterator
 * Method:    initialise
 * Signature: (Lcom/mousebird/maply/VectorObject;)V
 */
JNIEXPORT void JNICALL Java_com_mousebird_maply_VectorIterator_initialise
  (JNIEnv *, jobject, jobject);

/*
 * Class:     com_mousebird_maply_VectorIterator
 * Method:    dispose
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_com_mousebird_maply_VectorIterator_dispose
  (JNIEnv *, jobject);

/*
 * Class:     com_mousebird_maply_VectorIterator
 * Method:    hasNext
 * Signature: ()Z
 */
JNIEXPORT jboolean JNICALL Java_com_mousebird_maply_VectorIterator_hasNext
  (JNIEnv *, jobject);

/*
 * Class:     com_mousebird_maply_VectorIterator
 * Method:    next
 * Signature: ()Lcom/mousebird/maply/VectorObject;
 */
JNIEXPORT jobject JNICALL Java_com_mousebird_maply_VectorIterator_next
  (JNIEnv *, jobject);

/*
 * Class:     com_mousebird_maply_VectorIterator
 * Method:    remove
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_com_mousebird_maply_VectorIterator_remove
  (JNIEnv *, jobject);

#ifdef __cplusplus
}
#endif
#endif
