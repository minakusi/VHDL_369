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
static const char *ng0 = "C:/Users/seoye/Xilinx/final_project/game_369.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_0462229765_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    char *t4;
    unsigned char t5;
    int t6;
    int t7;
    char *t8;
    char *t9;
    char *t10;

LAB0:    xsi_set_current_line(37, ng0);
    t1 = (t0 + 2928U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(38, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t1 = (t0 + 3048U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t3;
    xsi_set_current_line(39, ng0);

LAB2:    t1 = (t0 + 3048U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t5 = (t3 >= 10);
    if (t5 != 0)
        goto LAB3;

LAB5:    xsi_set_current_line(43, ng0);
    t1 = (t0 + 2928U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t1 = (t0 + 4960);
    t4 = (t1 + 56U);
    t8 = *((char **)t4);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = t3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(44, ng0);
    t1 = (t0 + 3048U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t1 = (t0 + 5024);
    t4 = (t1 + 56U);
    t8 = *((char **)t4);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((int *)t10) = t3;
    xsi_driver_first_trans_fast(t1);
    t1 = (t0 + 4848);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(40, ng0);
    t1 = (t0 + 2928U);
    t4 = *((char **)t1);
    t6 = *((int *)t4);
    t7 = (t6 + 1);
    t1 = (t0 + 2928U);
    t8 = *((char **)t1);
    t1 = (t8 + 0);
    *((int *)t1) = t7;
    xsi_set_current_line(41, ng0);
    t1 = (t0 + 3048U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t6 = (t3 - 10);
    t1 = (t0 + 3048U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t6;
    goto LAB2;

LAB4:;
}

static void work_a_0462229765_3212880686_p_1(char *t0)
{
    char t9[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    int t11;
    unsigned int t12;
    unsigned char t13;
    unsigned char t14;
    unsigned char t15;
    unsigned char t16;
    char *t17;
    int t18;
    unsigned char t19;
    char *t20;
    int t21;
    unsigned char t22;
    char *t23;
    int t24;
    unsigned char t25;
    unsigned char t26;
    unsigned char t27;
    char *t28;
    int t29;
    unsigned char t30;
    char *t31;
    int t32;
    unsigned char t33;
    char *t34;
    int t35;
    unsigned char t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;

LAB0:    xsi_set_current_line(51, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1152U);
    t4 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t4 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 4864);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(52, ng0);
    t1 = (t0 + 5088);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(55, ng0);
    t10 = (t0 + 2632U);
    t17 = *((char **)t10);
    t18 = *((int *)t17);
    t19 = (t18 == 3);
    if (t19 == 1)
        goto LAB19;

LAB20:    t10 = (t0 + 2632U);
    t20 = *((char **)t10);
    t21 = *((int *)t20);
    t22 = (t21 == 6);
    t16 = t22;

LAB21:    if (t16 == 1)
        goto LAB16;

LAB17:    t10 = (t0 + 2632U);
    t23 = *((char **)t10);
    t24 = *((int *)t23);
    t25 = (t24 == 9);
    t15 = t25;

LAB18:    if (t15 == 1)
        goto LAB13;

LAB14:    t10 = (t0 + 2472U);
    t28 = *((char **)t10);
    t29 = *((int *)t28);
    t30 = (t29 == 3);
    if (t30 == 1)
        goto LAB25;

LAB26:    t10 = (t0 + 2472U);
    t31 = *((char **)t10);
    t32 = *((int *)t31);
    t33 = (t32 == 6);
    t27 = t33;

LAB27:    if (t27 == 1)
        goto LAB22;

LAB23:    t10 = (t0 + 2472U);
    t34 = *((char **)t10);
    t35 = *((int *)t34);
    t36 = (t35 == 9);
    t26 = t36;

LAB24:    t14 = t26;

LAB15:    if (t14 != 0)
        goto LAB10;

LAB12:    xsi_set_current_line(58, ng0);
    t1 = (t0 + 5088);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);

LAB11:    xsi_set_current_line(61, ng0);
    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB28;

LAB30:    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB34;

LAB35:    xsi_set_current_line(76, ng0);
    t1 = (t0 + 5152);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);

LAB29:    goto LAB3;

LAB7:    t2 = (t0 + 1672U);
    t5 = *((char **)t2);
    t2 = (t0 + 7688U);
    t6 = (t0 + 7760);
    t8 = (t9 + 0U);
    t10 = (t8 + 0U);
    *((int *)t10) = 0;
    t10 = (t8 + 4U);
    *((int *)t10) = 1;
    t10 = (t8 + 8U);
    *((int *)t10) = 1;
    t11 = (1 - 0);
    t12 = (t11 * 1);
    t12 = (t12 + 1);
    t10 = (t8 + 12U);
    *((unsigned int *)t10) = t12;
    t13 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t5, t2, t6, t9);
    t3 = t13;
    goto LAB9;

LAB10:    xsi_set_current_line(56, ng0);
    t10 = (t0 + 5088);
    t37 = (t10 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    *((unsigned char *)t40) = (unsigned char)2;
    xsi_driver_first_trans_fast(t10);
    goto LAB11;

LAB13:    t14 = (unsigned char)1;
    goto LAB15;

LAB16:    t15 = (unsigned char)1;
    goto LAB18;

LAB19:    t16 = (unsigned char)1;
    goto LAB21;

LAB22:    t26 = (unsigned char)1;
    goto LAB24;

LAB25:    t27 = (unsigned char)1;
    goto LAB27;

LAB28:    xsi_set_current_line(62, ng0);
    t1 = (t0 + 2152U);
    t5 = *((char **)t1);
    t13 = *((unsigned char *)t5);
    t14 = (t13 == (unsigned char)2);
    if (t14 != 0)
        goto LAB31;

LAB33:    xsi_set_current_line(65, ng0);
    t1 = (t0 + 5152);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);

LAB32:    goto LAB29;

LAB31:    xsi_set_current_line(63, ng0);
    t1 = (t0 + 5152);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB32;

LAB34:    xsi_set_current_line(69, ng0);
    t1 = (t0 + 2152U);
    t5 = *((char **)t1);
    t13 = *((unsigned char *)t5);
    t14 = (t13 == (unsigned char)2);
    if (t14 != 0)
        goto LAB36;

LAB38:    xsi_set_current_line(72, ng0);
    t1 = (t0 + 5152);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);

LAB37:    goto LAB29;

LAB36:    xsi_set_current_line(70, ng0);
    t1 = (t0 + 5152);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t10 = *((char **)t8);
    *((unsigned char *)t10) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

}

static void work_a_0462229765_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(80, ng0);

LAB3:    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 5216);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 4880);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_0462229765_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0462229765_3212880686_p_0,(void *)work_a_0462229765_3212880686_p_1,(void *)work_a_0462229765_3212880686_p_2};
	xsi_register_didat("work_a_0462229765_3212880686", "isim/totalgame_TB_isim_beh.exe.sim/work/a_0462229765_3212880686.didat");
	xsi_register_executes(pe);
}
