-module (test).
-export ([select_fun/1]).
select_fun(L)=[{furn,Type,Color}||
			   {furn, Type, Weight,Color}<-L, Type==table, Weight<=10] 
  ++ [{furn,Type,Weight,Color}<-L, Type == chair,Weight=<10].