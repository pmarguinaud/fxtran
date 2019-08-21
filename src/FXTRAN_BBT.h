/*
 * FXTRAN -- Philippe Marguinaud -- pmarguinaud@hotmail.com
 * Distributed under the GNU General Public License
 */
#ifndef _FXTRAN_BBT
#define _FXTRAN_BBT

#define BBT_HEADER(self) int priority; struct self *left, *right;

void FXTRAN_insert_bbt (void *, void *, int (*)());
void FXTRAN_delete_bbt (void *, void *, int (*)());

#endif
