#ifndef	_SCD_WRAPPER_H
#define _SCD_WRAPPER_H	1
/************************************************************************
 *									*
 * This class is a wrapper for the Matlabe cyclo-stationary library.	*
 *									*
 * File:SCDWrapper.h							*
 *									*
 * Revision history:							*
 *  1. 07/18/05 - Started						*
 ************************************************************************/

class	Complex;

//! SCDWrapper Class
/*!
   This class is used as a wrapper for Matlab cyclic spectral density
   analysis programs.
*/

class SCDWrapper					//!< SCDWrapper class
{
protected:

public:
//
// Public methods, not normally called by users of SCDWrapper
//

//
// Public methods:
//
/*********************************
 * Constructors, destructors:    *
 *********************************/
//! Class constructor, the size is the precision in bits (including sign bit)
  SCDWrapper();
//! Destructor
  ~SCDWrapper();

/********************************
 * The following functions	*
 * set parameters.		*
 ********************************/

/********************************
 * The following functions	*
 * get parameters.		*
 ********************************/

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