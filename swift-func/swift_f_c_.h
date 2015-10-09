/*
 * NAME swift_f_c_.h - swift func header for c
 *
 * DESC
 *   - struct type swift_func_t to get func addr value by .func
 *   - start from swift 2.1: OK
 *
 * V
 *   -1.0.0.0_201510091403560800
 */


#if !defined(SWIFT_F_C__H__)
#define SWIFT_F_C__H__ (1)


/* type swift_func_t */
#pragma pack (1)
typedef struct _swift_func_t {
	long int func;
	long int ____;
} swift_func_t;
#pragma pack ()


#endif
