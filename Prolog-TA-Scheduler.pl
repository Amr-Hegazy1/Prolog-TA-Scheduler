%%%%%% Part a

week_schedule([],_,_,[]).
week_schedule([WeekSlot|WeekSlots],TAs,DayMax,[Assignment|WeekSched]) :-

	day_schedule(WeekSlot,TAs,RemTAs,Assignment),
	max_slots_per_day(Assignment,DayMax),
	week_schedule(WeekSlots,RemTAs,DayMax,WeekSched).





%%%%%% Part b


day_schedule([],TAs,TAs,[]).
day_schedule([DaySlot|DaySlots],TAs,RemTAs,Assignment) :- 

	slot_assignment(DaySlot,TAs,RemTAs1,Assignment1),

	day_schedule(DaySlots,RemTAs1,RemTAs,Assignment2),

	Assignment = [Assignment1 | Assignment2].
	
	

	






%%%%%% Part c

max_slots_per_day(DaySched,Max) :-

	flatten(DaySched, DaySchedFlattened),
	list_to_set(DaySchedFlattened,DaySchedSet),
	check_occurunce(DaySchedFlattened,DaySchedSet,Max).


check_occurunce(_,[],_).
check_occurunce(List,[HS|TS],Max) :-

	count(HS,List,C),
	C =< Max,
	check_occurunce(List,TS,Max).



count(_,[],0).
count(X,[X|T],C) :-
	count(X,T,C1),
	C is 1 + C1.

count(X,[H|T],C) :-

	X \= H,
	count(X,T,C).

						





%%%%%%%% Part d

slot_assignment(0,TAs,TAs,[]).

slot_assignment(LabsNum,[TA|TAs],RemTAs,[Name|AT]) :-

	LabsNum > 0, 
	TA = ta(Name,_),
	LabsNum1 is LabsNum-1,

	
	ta_slot_assignment([TA|TAs],[H1|T1],Name),

	
	slot_assignment(LabsNum1,T1,RemTAs1,AT),
	append([H1],RemTAs1,RemTAs).
	
slot_assignment(LabsNum,[TA|TAs],RemTAs,Assignment) :-	
	LabsNum > 0,
	
	slot_assignment(LabsNum,TAs,RemTAs1,Assignment),
	append([TA],RemTAs1,RemTAs).
	
	





%%%%%%%% Part e


ta_slot_assignment([],[],_).


ta_slot_assignment([TA|TAs],[TA|RemTAs],Name) :-
	
	TA = ta(N,_),
	N \= Name,
	ta_slot_assignment(TAs,RemTAs,Name).
	
	
ta_slot_assignment([TA|TAs],[TA1|TAs],Name) :-
	
	TA = ta(Name,S),
	S > 0,
	S1 is S-1,
	TA1 = ta(Name,S1).
	

%%%%%%%%% PREDICATES FOR TESTING ONLY 

%helper_ass(LabsNum,TAs,RemTAs,Assignment) :-

%	slot_assignment(LabsNum,TAs,RemTAs1,Assignment1),

%	permutation(RemTAs1,RemTAs),
%	permutation(Assignment1,Assignment).

count_sched(WeekSlots,TAs,DayMax,WeekSched,N) :-

	bagof(WeekSched,week_schedule(WeekSlots,TAs,DayMax,WeekSched),S),
	length(S,N).

