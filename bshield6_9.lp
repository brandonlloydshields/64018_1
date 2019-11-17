// Objective function
max: 3x13 + 5x12 + 3x35 + 2x25 + 4x24 + 2x58 + 6x57 + 4x47 + x46 + 7x89 + 4x79 + 5x69;

// Constraints
Start: x13 + x12 = 1;
ME_Excl_1: x25 + x24 <= 1;
ME_Excl_2: x58 + x57 <= 1;
ME_Excl_3: x47 + x46 <= 1;
Cont_1: -x13 + x35 <= 0;
Cont_2: -x12 + x25 <= 0;
Cont_3: -x12 + x24 <= 0;
Cont_4: -x24 + x47 <= 0;
Cont_5: -x24 + x46 <= 0;
Cont_6: -x25 + -x35 + x58 <= 0;
Cont_7: -x25 + -x35 + x57 <= 0;
Cont_8: -x58 + x89 <= 0;
Cont_9: -x57 + -x47 + x79 <= 0;
Cont_10: -x46 + x69 <= 0;


bin x13, x12, x35, x25, x24, x58, x57, x47, x46, x89, x79, x69;