functor

export
   %exportacao dos metodos do functor
   notGWT:NotGate %notGate without thread
   notG:NotG %notGate with thread
   andG:AndG
   orG:OrG
   nandG:NandG
   norG:NorG
   xorG:XorG
   somadorCompleto: SomadorCompleto
   
define
  %Aqui no SomadorCompleto vou usar a notação procedural (proc) porque ele possui duas saidas.
  % Nela, vamos ter um somador completo, que adiciona três números de um bit, dando um resultado de dois bits. 
  % Adicionadores completos podem ser
  % encadeados para formar somadores de qualquer número de bits. Um somador completo tem três
  % entradas, x, y, z e duas saídas c e s.
   proc {SomadorCompleto X Y Z ?C ?S}
      K L M
      in
      K={AndG X Y}
      L={AndG Y Z}
      M={AndG X Z}
      C={OrG K {OrG L M}}
      S={XorG Z {XorG X Y}}
      %Ele satisfaz a equação x + y + z = (cs)
   end
   %NotGate, nesse método temos a porta ou exclusivo, que é geralmente chamado de Xor. 
   % Suas saídas são funções booleanas de suas entradas, e são totalmente
   % dependente das entradas.
   % Cada porta tem uma ou mais
   % entradas e uma saída. O mais simples é a porta Not, cuja saída é simplesmente a
   % negação da entrada. Em termos de streams, nós o definimos esse método assim:
   fun {NotGate Xs}
      case Xs of X|Xr then (1-X)|{NotGate Xr} end
   end

   %NotG with thread, aqui fazemos a conexão de várias portas juntas;
%    Nosso stream de saída de uma porta pode ser conectado diretamente ao stream de entrada de outro. 
   % Como todas as portas podem ser executadas simultaneamente, cada porta precisa executar
   % dentro de seu próprio segmento. 
   local
      fun {NotLoop Xs}
	 case Xs of X|Xr then (1-X)|{NotLoop Xr} end
      end
   in
   % Sendo assim podemos definir NotG, assim:
      fun {NotG Xs}
	 thread {NotLoop Xs} end
      end
   end
   %Podemos observar que chamar a função NotG, cria uma nova porta Not em seu próprio segmento

   %GateMaker, nessa função vamos poder criar qualquer porta com duas entradas
   fun {GateMaker F}
      fun {$ Xs Ys}
	 fun {GateLoop Xs Ys}
	    case Xs#Ys of (X|Xr)#(Y|Yr) then
	       {F X Y}|{GateLoop Xr Yr}
	    end
	 end
      in
	 thread {GateLoop Xs Ys} end
      end
   end

   %Alguns exemplos de portas com a função GateMaker
   
   AndG ={GateMaker fun {$ X Y} X*Y end}
   OrG ={GateMaker fun {$ X Y} X+Y-X*Y end}
   NandG={GateMaker fun {$ X Y} 1-X*Y end}
   NorG ={GateMaker fun {$ X Y} 1-X-Y+X*Y end}
   XorG ={GateMaker fun {$ X Y} X+Y-2*X*Y end}

end   