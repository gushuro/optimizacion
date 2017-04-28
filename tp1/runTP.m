% Cargar datos. Esto hay que correrlo antes de los otros.

load('datosHospital.mat');
load('datosTP1-2017.mat');

%% Ejemplo. Generamos una exponencial con ruido y vemos cómo ajustan los métodos.
x = 0.01:0.01:2;
y = 2*exp(-3*x) + 1;
y = y + randn(size(x))/10;

[a,k] = ej1_TP(x',y');
ej2_TP(x',y' , log(a), k, min(y));

%% EJ 1 Y 2 PARA DATOS HOSPITAL

[a,k]=ej1_TP(M(:,1),M(:,2));
ej2_TP(M(:,1), M(:,2), log(a), k, min(M(:,1)));

%% EJ 1 Y 2 PARA DATOS1

[a,k]=ej1_TP(datos1(:,1),datos1(:,2));
ej2_TP(datos1(:,1), datos1(:,2), log(a), k, min(datos1(:,1)));

%% EJ 1 Y 2 PARA DATOS2

[a,k]=ej1_TP(datos2(:,1),datos2(:,2));
ej2_TP(datos2(:,1), datos2(:,2), log(a), k, min(datos2(:,1)));

%% EJ 1 Y 2 PARA DATOS3

[a,k]=ej1_TP(datos3(:,1),datos3(:,2));
ej2_TP(datos3(:,1), datos3(:,2), log(a), k, min(datos3(:,1)));

%% EJ 1 Y 2 PARA DATOS4

[a,k]=ej1_TP(datos4(:,1),datos4(:,2));
ej2_TP(datos4(:,1), datos4(:,2), log(a), k, min(datos4(:,1)));

%% EJ 1 Y 2 PARA DATOS5

[a,k]=ej1_TP(datos5(:,1),datos5(:,2));
ej2_TP(datos5(:,1), datos5(:,2), log(a), k, min(datos5(:,1)));

%% EJ 1 Y 2 PARA DATOS6

[a,k]=ej1_TP(datos6(:,1),datos6(:,2));
ej2_TP(datos6(:,1), datos6(:,2), log(a), k, min(datos6(:,1)));

