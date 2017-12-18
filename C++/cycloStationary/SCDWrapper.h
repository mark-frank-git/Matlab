#ifndef	_SCD_WRAPPER_H
#define _SCD_WRAPPER_H	1
/************************************************************************
 *									*
 * This function is a wrapper for the Matlab cyclo-stationary library.	*
 *									*
 * File:SCDWrapper.h							*
 *									*
 * Revision history:							*
 *  1. 07/18/05 - Started						*
 ************************************************************************/


/********************************
 * The following functions call	*
 * Matlab m files.		*
 ********************************/
//! scdFor () calculates the spectral correlation density for the input array
/**
  * a normal member taking two arguments with no return value.
  * @param x the input complex array
  * @param length the length of the input array
  * @see scdOutput() to get the result
  * @return void
  */
  void		scdFor(const Complex *x, int length);


};

#endif