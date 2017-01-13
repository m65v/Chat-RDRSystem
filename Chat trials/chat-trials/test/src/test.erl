-module(test).
-export([select_furn/1]).
select_furn(L)->[{furn,Type,Color}||
			   {furn, Type, Weight,Color}<-L, Type=table, Weight<10] 
  ++ [{furn, Type, Color}||{furn,Type,Weight,Color}<-L, Type=chair,Weight<10].
