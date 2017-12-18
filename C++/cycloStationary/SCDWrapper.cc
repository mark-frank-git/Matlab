/************************************************************************
 *									*
 * This class is a wrapper for the Matlab cyclo-stationary library.	*
 *									*
 * File:SCDWrapper.h							*
 *									*
 * Revision history:							*
 *  1. 07/18/05 - Started						*
 ************************************************************************/

#include <stdio.h>
#include <string.h>
#include "SCDWrapper.h"						// Class prototypes
#include "scdlib.h"						// routines for Matlab calls


#define MAX(a,b)  ( ((a)<(b)) ? (b) : (a) )
#define MIN(a,b)  ( ((a)>(b)) ? (b) : (a) )
#define ABS(a)    (  (a) >= 0 ? (a) : (-a))

// ############################# Class Constructor ###############################
// Class Constructor -- Constructor for the SCDWrapper class.
// Input:			None
//			
// Output:			None
//
// Notes:
// ############################# Class Constructor ###############################
SCDWrapper::SCDWrapper()
{
// initialize MATLAB environment:
  libscdInitialize();
  return;
}

// ############################# Class Destructor ###############################
// Class Destructor -- Destructor for the SCDWrapper class.
//
// Input:						None
//
// Output:						None
//
// Notes:
// ############################# Class Destructor ###############################
SCDWrapper::~SCDWrapper()
{
// terminate MATLAB environment:
  libscdTerminate();
  return;
}

// ############################# Public Method ###############################
// scdFor: Finds and plots the spectral correlation density for the input
//         complex array.
// Input:	x:		input Array
//		length:		length of array
//			
// Output:			None
//
// Notes:
// 1. See scdOutput() to get the result.
// ############################# Public Method ###############################
void SCDWrapper::scdFor(const Complex *x, int length)
{
  return;
}
