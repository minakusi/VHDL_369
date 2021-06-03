/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/seoye/Xilinx/final_project/totalgame.vhd";
extern char *IEEE_P_3620187407;



static void work_a_0873618069_3212880686_p_0(char *t0)
{
    char t10[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    int t11;
    unsigned int t12;
    int t13;
    char *t14;
    unsigned char t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;

LAB0:    xsi_set_current_line(119, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(123, ng0);
    t1 = (t0 + 5672U);
    t2 = *((char **)t1);
    t1 = (t0 + 12216U);
    t5 = (t0 + 12288);
    t7 = (t10 + 0U);
    t8 = (t7 + 0U);
    *((int *)t8) = 0;
    t8 = (t7 + 4U);
    *((int *)t8) = 1;
    t8 = (t7 + 8U);
    *((int *)t8) = 1;
    t11 = (1 - 0);
    t12 = (t11 * 1);
    t12 = (t12 + 1);
    t8 = (t7 + 12U);
    *((unsigned int *)t8) = t12;
    t3 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t5, t10);
    if (t3 != 0)
        goto LAB5;

LAB7:    t1 = (t0 + 5672U);
    t2 = *((char **)t1);
    t1 = (t0 + 12216U);
    t5 = (t0 + 12296);
    t7 = (t10 + 0U);
    t8 = (t7 + 0U);
    *((int *)t8) = 0;
    t8 = (t7 + 4U);
    *((int *)t8) = 1;
    t8 = (t7 + 8U);
    *((int *)t8) = 1;
    t11 = (1 - 0);
    t12 = (t11 * 1);
    t12 = (t12 + 1);
    t8 = (t7 + 12U);
    *((unsigned int *)t8) = t12;
    t3 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t5, t10);
    if (t3 != 0)
        goto LAB32;

LAB33:
LAB6:    xsi_set_current_line(150, ng0);
    t1 = (t0 + 4392U);
    t2 = *((char **)t1);
    t11 = *((int *)t2);
    t1 = (t0 + 7360);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = t11;
    xsi_driver_first_trans_fast(t1);

LAB3:    t1 = (t0 + 7152);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(120, ng0);
    t1 = (t0 + 7232);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = 2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(121, ng0);
    t1 = (t0 + 12286);
    t5 = (t0 + 7296);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 2U);
    xsi_driver_first_trans_fast(t5);
    goto LAB3;

LAB5:    xsi_set_current_line(124, ng0);
    t8 = (t0 + 4712U);
    t9 = *((char **)t8);
    t13 = *((int *)t9);
    t4 = (t13 == 2);
    if (t4 != 0)
        goto LAB8;

LAB10:    t1 = (t0 + 4712U);
    t2 = *((char **)t1);
    t11 = *((int *)t2);
    t3 = (t11 == 3);
    if (t3 != 0)
        goto LAB16;

LAB17:    t1 = (t0 + 4712U);
    t2 = *((char **)t1);
    t11 = *((int *)t2);
    t3 = (t11 == 4);
    if (t3 != 0)
        goto LAB25;

LAB26:
LAB9:    goto LAB6;

LAB8:    xsi_set_current_line(125, ng0);
    t8 = (t0 + 1672U);
    t14 = *((char **)t8);
    t15 = *((unsigned char *)t14);
    t16 = (t15 == (unsigned char)2);
    if (t16 != 0)
        goto LAB11;

LAB13:    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB14;

LAB15:
LAB12:    goto LAB9;

LAB11:    xsi_set_current_line(126, ng0);
    t8 = (t0 + 12290);
    t18 = (t0 + 7296);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t8, 2U);
    xsi_driver_first_trans_fast(t18);
    goto LAB12;

LAB14:    xsi_set_current_line(128, ng0);
    t1 = (t0 + 7232);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = 3;
    xsi_driver_first_trans_fast(t1);
    goto LAB12;

LAB16:    xsi_set_current_line(131, ng0);
    t1 = (t0 + 1672U);
    t5 = *((char **)t1);
    t4 = *((unsigned char *)t5);
    t15 = (t4 == (unsigned char)2);
    if (t15 != 0)
        goto LAB18;

LAB20:    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB21;

LAB22:    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB23;

LAB24:
LAB19:    goto LAB9;

LAB18:    xsi_set_current_line(132, ng0);
    t1 = (t0 + 12292);
    t7 = (t0 + 7296);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t14 = (t9 + 56U);
    t17 = *((char **)t14);
    memcpy(t17, t1, 2U);
    xsi_driver_first_trans_fast(t7);
    goto LAB19;

LAB21:    xsi_set_current_line(134, ng0);
    t1 = (t0 + 7232);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = 4;
    xsi_driver_first_trans_fast(t1);
    goto LAB19;

LAB23:    xsi_set_current_line(136, ng0);
    t1 = (t0 + 7232);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = 2;
    xsi_driver_first_trans_fast(t1);
    goto LAB19;

LAB25:    xsi_set_current_line(139, ng0);
    t1 = (t0 + 1672U);
    t5 = *((char **)t1);
    t4 = *((unsigned char *)t5);
    t15 = (t4 == (unsigned char)2);
    if (t15 != 0)
        goto LAB27;

LAB29:    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB30;

LAB31:
LAB28:    goto LAB9;

LAB27:    xsi_set_current_line(140, ng0);
    t1 = (t0 + 12294);
    t7 = (t0 + 7296);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t14 = (t9 + 56U);
    t17 = *((char **)t14);
    memcpy(t17, t1, 2U);
    xsi_driver_first_trans_fast(t7);
    goto LAB28;

LAB30:    xsi_set_current_line(142, ng0);
    t1 = (t0 + 7232);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = 3;
    xsi_driver_first_trans_fast(t1);
    goto LAB28;

LAB32:    xsi_set_current_line(146, ng0);
    t8 = (t0 + 4072U);
    t9 = *((char **)t8);
    t13 = *((int *)t9);
    t4 = (t13 == 100);
    if (t4 != 0)
        goto LAB34;

LAB36:
LAB35:    goto LAB6;

LAB34:    xsi_set_current_line(147, ng0);
    t8 = (t0 + 12298);
    t17 = (t0 + 7296);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t8, 2U);
    xsi_driver_first_trans_fast(t17);
    goto LAB35;

}


extern void work_a_0873618069_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0873618069_3212880686_p_0};
	xsi_register_didat("work_a_0873618069_3212880686", "isim/totalgame_TB_isim_beh.exe.sim/work/a_0873618069_3212880686.didat");
	xsi_register_executes(pe);
}
