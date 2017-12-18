/************************************************************************
 *									*
 * This file is a wrapper for the Matlab cyclo-stationary library.	*
 *									*
 * File:SCDWrapper.c							*
 *									*
 * Revision history:							*
 *  1. 07/18/05 - Started						*
 ************************************************************************/

#include "SCDWrapper.h"				// Class prototypes
#define linux		1			// For mclmcr.h
#include "scdlib.h"				// routines for Matlab calls
#include "C:\Applications\Matlab\extern\include\matrix.h"


// ############################# Public Method ###############################
// scdFor: Finds and plots the spectral correlation density for the input
//         complex array.
// Input:	xReal:		real part of input array
//		xImag		imag part of input array
//		length:		length of array
//			
// Output:			None
//
// Notes:
// 1. See scdOutput() to get the result.
// ############################# Public Method ###############################
void scdFor(const double *xReal, const double *xImag, int length)
{
  mxArray	*pmxA;
  mclInitializeApplication(NULL, 0);
  _scdlibInitialize();
  printf("calling create double\n");
  pmxA	= mxCreateDoubleScalar(2.);
  printf("calling create double matrix\n");
  pmxA		= mxCreateDoubleMatrix(1, 1, mxREAL);
printf("ending create double\n");
  _mlfPlotscd();  
printf("ending call plot scd\n");
  
  _scdlibTerminate();
  return;
}
