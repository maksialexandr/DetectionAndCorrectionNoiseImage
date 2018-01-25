function [arrayCsv, counter_types] = setResultForCSV(MATRIX, arrayCsv, method, file_name, counter_types, counter_types_method)
    Error1 = MATRIX(method).Values().Error1;
    Error2 = MATRIX(method).Values().Error2;
    T_detect = MATRIX(method).Values().T_detect;
    arrayCsv(file_name-2+counter_types,counter_types_method) = Error1;
    arrayCsv(file_name-2+counter_types,counter_types_method + 1) = Error2;
    arrayCsv(file_name-2+counter_types,counter_types_method + 2) = T_detect;
    counter_types = counter_types + 1;