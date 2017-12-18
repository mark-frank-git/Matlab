/*
 * MATLAB Compiler: 4.1 (R14SP1)
 * Date: Tue Jul 19 14:09:21 2005
 * Arguments: "-B" "macro_default" "-W" "lib:scdlib" "-T" "link:lib"
 * "PlotSCD.m" "dfsm_pace.m" 
 */

#ifndef __scdlib_h
#define __scdlib_h 1

#if defined(__cplusplus) && !defined(mclmcr_h) && defined(__linux__)
#  pragma implementation "mclmcr.h"
#endif
#include "mclmcr.h"
#ifdef __cplusplus
extern "C" {
#endif

extern bool scdlibInitializeWithHandlers(mclOutputHandlerFcn error_handler,
                                         mclOutputHandlerFcn print_handler);
extern bool scdlibInitialize(void);
extern void scdlibTerminate(void);


extern void mlxPlotscd(int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[]);

extern void mlxDfsm_pace(int nlhs, mxArray *plhs[],
                         int nrhs, mxArray *prhs[]);


extern void mlfPlotscd();

extern void mlfDfsm_pace(int nargout, mxArray** S, mxArray** f
                         , mxArray** alfa, mxArray* data
                         , mxArray* fs, mxArray* N, mxArray* L);

#ifdef __cplusplus
}
#endif

#endif
