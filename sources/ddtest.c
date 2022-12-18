/*
 * Playground for messing with new distance/direction
 */
#include <stdio.h>
#include <math.h>

/**
 * This is a direct port of the BASIC code to use as a baseline for
 * comparison.
 *
 * C1 = Row1 (Enterprise)
 * A  = Col1 (Enterprise)
 * W1 = Row2 (Klingon)
 * X  = Col2 (Klingon)
 */
void sstdd(double c1, double a, double w1, double x)
{
    x = x - a;
    a = c1 - w1;

    if (x < 0) goto line_8350;
    if (a < 0) goto line_8410;
    if (x > 0) goto line_8280;

    if (a == 0) {
        c1 = 5;
        goto line_8290;
    }

line_8280:
    c1 = 1;

line_8290:
    if (fabs(a) <= fabs(x)) goto line_8330;
    printf("DIRECTION = %f\n", c1 + (((fabs(a) - fabs(x)) + fabs(a)) / fabs(a)));
    goto line_8460;

line_8330:
    printf("DIRECTION = %f\n", c1 + (fabs(a) / fabs(x)));
    goto line_8460;

line_8350:
    if (a > 0) {
        c1 = 3;
        goto line_8420;
    }

    if (x != 0) {
        c1 = 5;
        goto line_8290;
    }

line_8410:
    c1 = 7;

line_8420:
    if (fabs(a) >= fabs(x)) goto line_8450;
    printf("DIRECTION = %f\n", c1 + (((fabs(x) - fabs(a)) + fabs(x)) / fabs(x)));
    goto line_8460;

line_8450:
    printf("DIRECTION = %f\n", c1 + (fabs(x) / fabs(a)));

line_8460:
    printf("DISTANCE = %f\n", sqrt(x*x + a*a));
}

/**
 * C1 = Row1 (Enterprise)
 * A  = Col1 (Enterprise)
 * W1 = Row2 (Klingon)
 * X  = Col2 (Klingon)
 */
double sstdist(double c1, double a, double w1, double x)
{
    x = x - a;
    a = c1 - w1;

    return sqrt(x*x + a*a);
}

/**
 * C1 = Row1 (Enterprise)
 * A  = Col1 (Enterprise)
 * W1 = Row2 (Klingon)
 * X  = Col2 (Klingon)
 */
double sstdir(double c1, double a, double w1, double x)
{
    x = x - a;
    a = c1 - w1;

    if (x < 0) goto line_8350;
    if (a < 0) goto line_8410;
    if (x > 0) goto line_8280;

    if (a == 0) {
        c1 = 5;
        goto line_8290;
    }

line_8280:
    c1 = 1;

line_8290:
    if (fabs(a) <= fabs(x)) goto line_8330;
    return c1 + (((fabs(a) - fabs(x)) + fabs(a)) / fabs(a));

line_8330:
    return c1 + (fabs(a) / fabs(x));

line_8350:
    if (a > 0) {
        c1 = 3;
        goto line_8420;
    }

    if (x != 0) {
        c1 = 5;
        goto line_8290;
    }

line_8410:
    c1 = 7;

line_8420:
    if (fabs(a) >= fabs(x)) goto line_8450;
    return c1 + (((fabs(x) - fabs(a)) + fabs(x)) / fabs(x));

line_8450:
    return c1 + (fabs(x) / fabs(a));
}

/*
 * Another variant that produces identical results.
 */
double beejdir(double row1, double col1, double row2, double col2)
{
    double dRow = row1 - row2;
    double dCol = col1 - col2;

    double adRow = fabs(dRow);
    double adCol = fabs(dCol);

    if (dRow >= 0) {
        if (dCol >= 0) {
            if (adRow > adCol) {
                return 3 + adCol / adRow;
            } else {
                return 5 - adRow / adCol;
            }
        } else {
            if (adRow > adCol) {
                return 3 - adCol / adRow;
            } else {
                return 1 + adRow / adCol;
            }
        }
    } else {
        if (dCol > 0) {
            if (adRow > adCol) {
                return 7 - adCol / adRow;
            } else {
                return 5 + adRow / adCol;
            }
        } else {
            if (adRow > adCol) {
                return 7 + adCol / adRow;
            } else {
                return 9 - adRow / adCol;
            }
        }
    }
}

/*
 * atan2 solution, produces up to 1.12% error from BASIC solution
 */
double tandir(double row1, double col1, double row2, double col2)
{
    const double PI = 3.14159265358979;

    double dRow = -(row2 - row1);  // Result is flipped over X axis
    double dCol = col2 - col1;

    double a = atan2(dRow, dCol) / (2*PI);

    //printf("%f %f %f\n", dRow, dCol, a);

    while (a < 0) a += 1;

    return a * 8 + 1;
}

int main(void)
{
    //const double PI = 3.14159265358979;
    //printf("%f\n", atan2(0,1) / (2*PI)); // 0.0
    //printf("%f\n", atan2(1,0) / (2*PI)); // 0.25
    //printf("%f\n", atan2(0,-1) / (2*PI)); // 0.5
    //printf("%f\n", atan2(-1,0) / (2*PI) + 1); // 0.75

    double worst_mag_diff = 0;

    // Exhaustively compare all positions
    for (int i = 1; i <= 8; i++) {
        for (int j = 1; j <= 8; j++) {
            for (int k = 1; k <= 8; k++) {
                for (int l = 1; l <= 8; l++) {
                    if (i == k && j == l) continue;

                    double d_sst = sstdir(i, j, k, l);
                    //double d_test = beejdir(i, j, k, l);
                    double d_test = tandir(i, j, k, l);

                    double diff = d_test - d_sst;
                    double mag_diff = fabs(diff);

                    if (mag_diff > 0.001)  {
                        printf("(%d,%d)->(%d,%d): need %.5f, got %.5f, diff %.5f\n", i, j, k, l, d_sst, d_test, diff);
                    }

                    if (mag_diff > worst_mag_diff)
                        worst_mag_diff = mag_diff;

                }
            }
        }
    }

    printf("Worst magnitude difference: %.5f, %.5f turns\n", worst_mag_diff, worst_mag_diff / 8);
}
