%let pgm=utl-using-sas-multi-level-formats-to-count-ages-in-overlapping-categories;

%stop_submission;

Using sas multi level formats to count ages in overlapping categories

github
https://tinyurl.com/453pcexp
https://github.com/rogerjdeangelis/utl-using-sas-multi-level-formats-to-count-ages-in-overlapping-categories

related to
https://tinyurl.com/2k46nhf2
https://communities.sas.com/t5/Statistical-Procedures/adding-variables-in-proc-summary/m-p/839944#M41626

 /**************************************************************************************************************************/
 /* INPUT                           |     PROCESS (DATA DOES NOT HAVE TO BE SORTED)    |            OUTPUT                 */
 /* =====                           |     ========================================     |            ======                 */
 /*                                 |                                                  |                                   */
 /*  AGE                            |                         AGE                      |        AGE             COUNT      */
 /*                                 |                                                  |                                   */
 /*   0                             |                       -  0                       |    1 Infant Todler       5*       */
 /*   2                             |                       |  2                       |    2 Child               5        */
 /*   3                             |       1 Infant Todler |  3                       |    3 Teenager            4        */
 /*   4                             |                       |  4                       |    4 Adult               7        */
 /*   5                             |              *count=5 -  5                       |    5 Senior              6        */
 /*   6                             |                       -  6                       |                                   */
 /*   8                             |                       |  8                       |    Overlapping ranges             */
 /*   9                             |               2 Child |  9 -                     |                                   */
 /*  11                             |                       | 11 |                     |    6 Junveinile          6**      */
 /*  12                             |                       - 12 |                     |    7 Legal Adult        14        */
 /*  13                             |                       - 13 | Juvennile           |                                   */
 /*  15                             |                       | 15 |                     |                                   */
 /*  18                             |           3 Teenanger | 18 - count=6**           |                                   */
 /*  19                             |                       - 19 -                     |                                   */
 /*  22                             |                       - 20 |                     |                                   */
 /*  31                             |                       | 22 |                     |                                   */
 /*  44                             |                       | 31 |                     |                                   */
 /*  51                             |               4 Adult | 44 | Legal Adult         |                                   */
 /*  60                             |                       | 51 |                     |                                   */
 /*  64                             |                       | 60 |                     |                                   */
 /*  65                             |                       - 64 |                     |                                   */
 /*  68                             |                            |                     |                                   */
 /*  69                             |                       - 65 |                     |                                   */
 /*  71                             |                       | 68 |                     |                                   */
 /*  81                             |                       | 69 |                     |                                   */
 /*  93                             |              5 Senior | 71 |                     |                                   */
 /*                                 |                       | 81 |                     |                                   */
 /*                                 |                       - 93 -                     |                                   */
 /*                                 |                       high                       |                                   */
 /* options validvarname=upcase;    |                                                  |                                   */
 /* libname sd1 "d:/sd1";           |                                                  |                                   */
 /* data sd1.have;                  |    proc format;                                  |                                   */
 /* input age @@;                   |      value agegrp (multilabel notsorted)         |                                   */
 /* cards4;                         |          0-5     = '1 Infant Todler'             |                                   */
 /* 0 2 3 4 5                       |          6-12    = '2 Child'                     |                                   */
 /* 6 8 9 11 12                     |          13-19   = '3 Teenager'                  |                                   */
 /* 13 15 17 19                     |          20-64   = '4 Adult'                     |                                   */
 /* 20 22 31 44 51 60 64            |          65-high = '5 Senior'                    |                                   */
 /* 65 68 69 71 81 93               |          9-18    = '6 Junveinile'                |                                   */
 /* ;;;;                            |          19-high = '7 Legal Adult';              |                                   */
 /* run;quit;                       |    run;quit;                                     |                                   */
 /*                                 |                                                  |                                   */
 /*                                 |    proc summary data=sd1.have nway;              |                                   */
 /*                                 |     class age / mlf;                             |                                   */
 /*                                 |     format age agegrp.;                          |                                   */
 /*                                 |     var age;                                     |                                   */
 /*                                 |     output out=want (drop=_:) n=Count;           |                                   */
 /*                                 |    run;quit;                                     |                                   */
 /**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
input age @@;
cards4;
0 2 3 4 5
6 8 9 11 12
13 15 17 19
20 22 31 44 51 60 64
65 68 69 71 81 93
;;;;
run;quit;

/**************************************************************************************************************************/
/* Obs    AGE                                                                                                             */
/*                                                                                                                        */
/*   1      0                                                                                                             */
/*   2      2                                                                                                             */
/*   3      3                                                                                                             */
/*   4      4                                                                                                             */
/*   5      5                                                                                                             */
/*   6      6                                                                                                             */
/*   7      8                                                                                                             */
/*   8      9                                                                                                             */
/*   9     11                                                                                                             */
/*  10     12                                                                                                             */
/*  11     13                                                                                                             */
/*  12     15                                                                                                             */
/*  13     17                                                                                                             */
/*  14     19                                                                                                             */
/*  15     20                                                                                                             */
/*  16     22                                                                                                             */
/*  17     31                                                                                                             */
/*  18     44                                                                                                             */
/*  19     51                                                                                                             */
/*  20     60                                                                                                             */
/*  21     64                                                                                                             */
/*  22     65                                                                                                             */
/*  23     68                                                                                                             */
/*  24     69                                                                                                             */
/*  25     71                                                                                                             */
/*  26     81                                                                                                             */
/*  27     93                                                                                                             */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

proc format;
  value agegrp (multilabel notsorted)
      0-5     = '1 Infant Todler'
      6-12    = '2 Child'
      13-19   = '3 Teenager'
      20-64   = '4 Adult'
      65-high = '5 Senior'
      9-18    = '6 Junveinile'
      19-high = '7 Legal Adult';
run;quit;

proc summary data=sd1.have nway;
 class age / mlf;
 format age agegrp.;
 var age;
 output out=want (drop=_:) n=Count;
run;quit;

/**************************************************************************************************************************/
/*  AGE                COUNT                                                                                              */
/*                                                                                                                        */
/*  1 Infant Todler       5                                                                                               */
/*  2 Child               5                                                                                               */
/*  3 Teenager            4                                                                                               */
/*  4 Adult               7                                                                                               */
/*  5 Senior              6                                                                                               */
/*  6 Junveinile          6                                                                                               */
/*  7 Legal Adult        14                                                                                               */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
