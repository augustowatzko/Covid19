sexo(M).
temp(40).
f_cardiaca(80).
f_respiratoria(40).
pa(80).
sa02(30).
dispneia('S').
idade(30).
comorbidades(1).
febre('true').
tosse('false').
coriza('true').
cefaleia('true').
diarreia('true').
mialgia('false').

%% Verde 	= Sem risco
%% Amarelo 	= Baixo risco
%% Laranja  = Alto risco
%% Vermelho = Altissimo risco

temp_verde(X) :-
    temp(X,Y), Y >=35, Y=<37.

temp_amarelo(X) :-
    temp(X, Y), Y < 35; temp(X, Y), Y > 37, Y =< 39.

temp_laranja(X) :-
    temp(X, Y), Y > 39.

f_cardiaca_verde(X) :-
    f_cardiaca(X, Y), Y < 100.

f_cardiaca_amarela(X) :-
    f_cardiaca(X, Y), Y >= 100.

f_respiratoria_verde(X) :- 
   f_respiratoria(X, Y), Y =< 18.

f_respiratoria_amarela(X) :- 
   f_respiratoria(X, Y), Y >= 19, Y =< 30.

f_respiratoria_vermelha(X) :- 
   f_respiratoria(X, Y), Y > 30.

pa_verde(X) :-
	pa(X,Y), Y > 100. 

pa_laranja(X) :-
	pa(X,Y), Y >= 90, Y =< 100.

pa_vermelha(X) :-
	pa(X,Y), Y < 90.

sa02_verde(X) :-
    sa02(X, Y), Y >= 95.

sa02_vermelha(X) :-
    sa02(X, Y), Y < 95.

dispneia_verde(X) :-
    dispneia(X, Y), Y == 'N'.

dispneia_vermelho(X) :-
    dispneia(X, Y), Y == 'S'.

idade_verde(X) :-
    idade(X, Y), Y < 60.

idade_amarelo(X) :-
    idade(X, Y), Y >= 60, Y =< 79.

idade_laranja(X) :-
    idade(X, Y), Y > 79.

comorbidades_verde(X) :-
    comorbidades(X, Y), Y = 0.

comorbidades_amarelo(X) :-
    comorbidades(X, Y), Y = 1.

comorbidades_laranja(X) :-
    comorbidades(X, Y), Y >= 2.

paciente_risco(X) :-
    paciente_vermelho(X);
    paciente_laranja(X);
    paciente_amarelo(X);
    paciente_verde(X).
    
paciente_verde(X) :-
    temp_verde(X),
    f_cardiaca_verde(X),
    f_respiratoria_verde(X),
    pa_verde(X),
    sa02_verde(X),
    dispneia_verde(X),
    idade_verde(X),
    comorbidades_verde(X),
    write(X),
    write('Leve/Médio(Verde): deve ficar em casa, em observação por 14 dias.').

paciente_amarelo(X) :-
    (
    	temp_amarelo(X);
    	f_cardiaca_amarelo(X);
    	f_respiratoria_amarelo(X);
    	idade_amarelo(X);
    	comorbidades_amarelo(X)
    ),
    write(X),
    write('Leve/Médio(Amarelo): deve ficar em casa, em observação por 14 dias.').

paciente_laranja(X) :-
    (   
    	temp_laranja(X);
    	pa_laranja(X);
    	idade_laranja(X);
    	comorbidades_laranja(X)
    ),
    write(X),
    write('Leve/Médio(Laranja): deve ficar em casa, em observação por 14 dias.').

paciente_vermelha(X) :-
    (   
    	f_respiratoria_vermelha(X);
        pa_vermelha(X);
    	sa02_vermelha(X);
    	dispneia_vermelha(X)
    ),
    write(X),
    write('Grave(Vermelho): deve ser encaminhado para o hospital').

%%Equipe: Augusto Watzko, Alex Nunes

















