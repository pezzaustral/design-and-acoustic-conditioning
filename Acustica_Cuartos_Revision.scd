//=====@@@@@=====@@@@@======@@@@@======@@@@@
/*
Tiempo de Reverberacion en bandas de 125 a 2000Hz

La formula de Tiempo de Reverberacion Sabine TR60 requiere:
>Volumen total del cuarto * 0.161(constante)
>Superficie de la sala * los coeficientes de absorción del material solicitado
*/

(
//===========Funciones==========================================================

(//==Volumen de un cuarto
~volTot= {|larg, anch, alt|
	var vol;
	vol = larg * anch * alt;
	vol.("Volumen_Total_Cuarto".postln);
});
(//==Superficie de un cuarto
~supTot= {|larg, anch, alt|
	var sup;
	sup = (2 * larg * anch) + (2 * anch * alt) + (2 * larg * alt);
	sup.("Superficie_Total".postln);
});
(//==Superficie de un cuarto == Arreglo
~supTotal= {|larg, anch, alt|
	var sup;
	sup= [(larg * anch), (anch * larg), 2 * ((anch * alt) + (larg * alt))];
	sup.("Superficie_Total_Arreglo".postln);
});
//=================================================================================
(//======Absorción considerando usar listas de areas y de coeficientes de absorción
~supAbs = {|listAreas, listCoef|
	var res;
	if(listAreas.size == listCoef.size,{
		//Calcular producto
		res = (listAreas * listCoef).sum;
		res.("Absorción".postln);
	},{
		"Error de dimensiones".postln;
	});
});
//========================================================
(//====Coeficiente promedio de absorción
~coefsProm = {|supAbs, supTot|
	var resCoef;
	resCoef = supAbs / supTot;
	resCoef.("Coeficiente_Promedio_Absorcion".postln);
});
//=========================================================
(//======TR60 Sabine

~reverbTime = {|supAbs, volTot|
	var resRverb;

	resRverb = (0.161 * volTot) / supAbs;
	resRverb.("Reverb_Time".postln);
});
)

//==========================================================
/*
Considerando el cuarto tiene Revestimiento de madera en toda su superficie (techo,piso,pared)
utilizamos el ejemplo:
(==245 Revestimiento de madera 53mm, -dens, 125_0.25,250_0.34, 500_0.18, 1000_0.10, 2000_0.10, 4000_0.06, NRC_0.18==)
http://www.fadu.edu.uy/acondicionamiento-acustico/wp-content/blogs.dir/27/files/2012/02/Tablas-de-Absorcion.pdf
*/

//Resultados
//volume total del cuarto
~volu = ~volTot.value(50, 60, 10);
//superficie total
~sTot = ~supTot.value(50, 60, 10);
//superficie ((piso, techo, pared))
~areas = ~supTotal.value(50, 60, 10).("Areas".postln);

//Ingresamos los coeficientes por bandas
~coefs125 = [0.25, 0.25, 0.25].("coeficiente125".postln);
~coefs250 = [0.34, 0.34, 0.34].("coeficiente250".postln);
~coefs500 = [0.18, 0.18, 0.18].("coeficiente500".postln);
~coefs1000 = [0.10, 0.10, 0.10].("coeficiente1000".postln);
~coefs2000 = [0.10, 0.10, 0.10].("coeficiente2000".postln);

//Obtenemos resultados de absorción a distintas bandas

~sA125 = ~supAbs.value(~areas,~coefs125).("Banda125Hz".postln);
~sA250 = ~supAbs.value(~areas,~coefs250).("Banda250Hz".postln);
~sA500 = ~supAbs.value(~areas,~coefs500).("Banda500Hz".postln);
~sA1000 = ~supAbs.value(~areas,~coefs1000).("Banda1000Hz".postln);
~sA2000= ~supAbs.value(~areas,~coefs2000).("Banda2000Hz".postln);

//Obtenemos ss coeficientes promedios a varias bandas

~coefsProm.value(~sA125,~sTot).("Banda125".postln);
~coefsProm.value(~sA250,~sTot).("Banda250".postln);
~coefsProm.value(~sA500,~sTot).("Banda500".postln);
~coefsProm.value(~sA1000,~sTot).("Banda1000".postln);
~coefsProm.value(~sA2000,~sTot).("Banda2000".postln);

//Obetenemos el tiempo de reverberación SabineTR60
~reverbTime.value(~sA125,~volu).("tRBanda_125".postln);
~reverbTime.value(~sA250,~volu).("tRBanda_250".postln);
~reverbTime.value(~sA500,~volu).("tRBanda_500".postln);
~reverbTime.value(~sA1000,~volu).("tRBanda_1000".postln);
~reverbTime.value(~sA2000,~volu).("tRBanda_2000".postln);




