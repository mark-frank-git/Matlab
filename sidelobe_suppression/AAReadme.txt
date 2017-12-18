This directory contains routines for calculating and plotting mismatched
filters for reducing sidelobes in received waveforms.  The routines for
calculating the mismatched filters are,

* optimalSidelobeSuppression: It takes as input a code (as a complex number),
  a weighting vector, and the mismatch filter length.


As an example of using this routine,
> code_length = 16
> filter_length = 32
> code = exp(i*frank_code(16,1))       % length 16 Frank code complex
> weight_type = 0                      % narrow main lobe
> [filter isl snr_loss] = optimalSidelobeSuppression(code, 0, 32)

  This routine calls: generateLambda and calcISLdB


* optimalSidelobeSuppressionDoppler: Similar to the above routine, except
  that this routine takes an array of Doppler values at which to also try
  to minimize the sidelobe levels.

  This routine calls: generateLambda and calcISLdB
