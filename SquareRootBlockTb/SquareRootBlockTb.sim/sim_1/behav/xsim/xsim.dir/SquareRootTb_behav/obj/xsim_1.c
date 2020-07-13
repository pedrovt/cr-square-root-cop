/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_4842(char*, char *);
extern void execute_4843(char*, char *);
extern void execute_4844(char*, char *);
extern void execute_29(char*, char *);
extern void execute_30(char*, char *);
extern void execute_31(char*, char *);
extern void execute_32(char*, char *);
extern void execute_33(char*, char *);
extern void execute_349(char*, char *);
extern void execute_350(char*, char *);
extern void execute_351(char*, char *);
extern void execute_352(char*, char *);
extern void execute_668(char*, char *);
extern void execute_669(char*, char *);
extern void execute_670(char*, char *);
extern void execute_671(char*, char *);
extern void execute_987(char*, char *);
extern void execute_988(char*, char *);
extern void execute_989(char*, char *);
extern void execute_990(char*, char *);
extern void execute_1306(char*, char *);
extern void execute_1307(char*, char *);
extern void execute_1308(char*, char *);
extern void execute_1309(char*, char *);
extern void execute_1625(char*, char *);
extern void execute_1626(char*, char *);
extern void execute_1627(char*, char *);
extern void execute_1628(char*, char *);
extern void execute_1944(char*, char *);
extern void execute_1945(char*, char *);
extern void execute_1946(char*, char *);
extern void execute_1947(char*, char *);
extern void execute_2263(char*, char *);
extern void execute_2264(char*, char *);
extern void execute_2265(char*, char *);
extern void execute_2266(char*, char *);
extern void execute_2582(char*, char *);
extern void execute_2583(char*, char *);
extern void execute_2584(char*, char *);
extern void execute_2585(char*, char *);
extern void execute_2901(char*, char *);
extern void execute_2902(char*, char *);
extern void execute_2903(char*, char *);
extern void execute_2904(char*, char *);
extern void execute_3220(char*, char *);
extern void execute_3221(char*, char *);
extern void execute_3222(char*, char *);
extern void execute_3223(char*, char *);
extern void execute_3539(char*, char *);
extern void execute_3540(char*, char *);
extern void execute_3541(char*, char *);
extern void execute_3542(char*, char *);
extern void execute_3858(char*, char *);
extern void execute_3859(char*, char *);
extern void execute_3860(char*, char *);
extern void execute_3861(char*, char *);
extern void execute_4177(char*, char *);
extern void execute_4178(char*, char *);
extern void execute_4179(char*, char *);
extern void execute_4180(char*, char *);
extern void execute_4496(char*, char *);
extern void execute_4497(char*, char *);
extern void execute_4498(char*, char *);
extern void execute_4499(char*, char *);
extern void execute_4815(char*, char *);
extern void execute_4816(char*, char *);
extern void execute_4817(char*, char *);
extern void execute_4818(char*, char *);
extern void execute_4837(char*, char *);
extern void execute_4838(char*, char *);
extern void execute_4839(char*, char *);
extern void execute_4840(char*, char *);
extern void execute_43(char*, char *);
extern void execute_44(char*, char *);
extern void execute_45(char*, char *);
extern void execute_46(char*, char *);
extern void execute_47(char*, char *);
extern void execute_48(char*, char *);
extern void execute_49(char*, char *);
extern void execute_50(char*, char *);
extern void execute_38(char*, char *);
extern void execute_40(char*, char *);
extern void execute_55(char*, char *);
extern void transaction_31(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[85] = {(funcp)execute_4842, (funcp)execute_4843, (funcp)execute_4844, (funcp)execute_29, (funcp)execute_30, (funcp)execute_31, (funcp)execute_32, (funcp)execute_33, (funcp)execute_349, (funcp)execute_350, (funcp)execute_351, (funcp)execute_352, (funcp)execute_668, (funcp)execute_669, (funcp)execute_670, (funcp)execute_671, (funcp)execute_987, (funcp)execute_988, (funcp)execute_989, (funcp)execute_990, (funcp)execute_1306, (funcp)execute_1307, (funcp)execute_1308, (funcp)execute_1309, (funcp)execute_1625, (funcp)execute_1626, (funcp)execute_1627, (funcp)execute_1628, (funcp)execute_1944, (funcp)execute_1945, (funcp)execute_1946, (funcp)execute_1947, (funcp)execute_2263, (funcp)execute_2264, (funcp)execute_2265, (funcp)execute_2266, (funcp)execute_2582, (funcp)execute_2583, (funcp)execute_2584, (funcp)execute_2585, (funcp)execute_2901, (funcp)execute_2902, (funcp)execute_2903, (funcp)execute_2904, (funcp)execute_3220, (funcp)execute_3221, (funcp)execute_3222, (funcp)execute_3223, (funcp)execute_3539, (funcp)execute_3540, (funcp)execute_3541, (funcp)execute_3542, (funcp)execute_3858, (funcp)execute_3859, (funcp)execute_3860, (funcp)execute_3861, (funcp)execute_4177, (funcp)execute_4178, (funcp)execute_4179, (funcp)execute_4180, (funcp)execute_4496, (funcp)execute_4497, (funcp)execute_4498, (funcp)execute_4499, (funcp)execute_4815, (funcp)execute_4816, (funcp)execute_4817, (funcp)execute_4818, (funcp)execute_4837, (funcp)execute_4838, (funcp)execute_4839, (funcp)execute_4840, (funcp)execute_43, (funcp)execute_44, (funcp)execute_45, (funcp)execute_46, (funcp)execute_47, (funcp)execute_48, (funcp)execute_49, (funcp)execute_50, (funcp)execute_38, (funcp)execute_40, (funcp)execute_55, (funcp)transaction_31, (funcp)vhdl_transfunc_eventcallback};
const int NumRelocateId= 85;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/SquareRootTb_behav/xsim.reloc",  (void **)funcTab, 85);
	iki_vhdl_file_variable_register(dp + 213112);
	iki_vhdl_file_variable_register(dp + 213168);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/SquareRootTb_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/SquareRootTb_behav/xsim.reloc");

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstantiate();

extern void implicit_HDL_SCcleanup();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/SquareRootTb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/SquareRootTb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/SquareRootTb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
