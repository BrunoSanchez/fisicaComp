cd ./2
gfortran -o lab1_2.o lab1_2.f90 prec_mod.f90 -O3
./lab1_2.o

cd ../3
gfortran -o lab1_3_a.o lab1_3_a.f90 prec_mod.f90 -O3
./lab1_3_a.o
gfortran -o lab1_3_b.o lab1_3_b.f90 prec_mod.f90 -O3
./lab1_3_b.o

cd ../6
gfortran -o ej6_a.o ej6_a.f90 prec_mod.f90 -O3
gfortran -o ej6_b.o ej6_b.f90 prec_mod.f90 -O3
gfortran -o ej6_c.o ej6_c.f90 prec_mod.f90 -O3
./ej6_a.o
./ej6_b.o
./ej6_c.o

cd ../5
gfortran -o ej5_a.o ej5_a.f90 prec_mod.f90 -O3
gfortran -o ej5_b.o ej5_b.f90 prec_mod.f90 -O3
gfortran -o ej5_c.o ej5_c.f90 prec_mod.f90 -O3
./ej5_a.o
./ej5_b.o
./ej5_c.o

cd ../graficos
ipython graficos_lab1.py

cd ..
