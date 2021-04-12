/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_MASK_H
#define _FXTRAN_MASK_H


enum
{
   FXTRAN_NON = '\0',
   FXTRAN_NAM = 'n', /* name */
   FXTRAN_OPR = '+', /* ops */
   FXTRAN_LIT = '8', /* litteral */
   FXTRAN_BOZ = 'Z', /* boz */
   FXTRAN_CPT = '%', /* component */
   FXTRAN_KWD = '_', /* keyword */
   
   FXTRAN_STR = '"', /* string */
   FXTRAN_OPT = '@',
   FXTRAN_COM = '!', /* comment */
   FXTRAN_LAB = 'L', /* label */
   FXTRAN_CPP = '#', /* cpp stuff */
   FXTRAN_COD = 'x', /* code */
   FXTRAN_SMC = ';', /* semi-column */
   FXTRAN_SPC = ' ', /* space */
   FXTRAN_CO2 = '>', /* cont at bol */
   FXTRAN_OMD = '$', /* openmp directive sentinel */
   FXTRAN_ACC = 'A', /* openmp directive sentinel */
   FXTRAN_DDD = 'D', 
   FXTRAN_OMC = '~', /* openmp code sentinel */
   FXTRAN_MAR = 'R', /* right margin */

/* free format specific */
   FXTRAN_CO1 = '&', /* cont at eol */

/* fixed format specific */
   FXTRAN_MAL = 'M', /* left margin */
   FXTRAN_ZER = '0'  /* zero */
};

#endif
