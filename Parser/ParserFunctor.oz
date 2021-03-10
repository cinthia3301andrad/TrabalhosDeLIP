functor
export %exportação das funções do functor
   programaPrincipal:Prog
   stat:Stat
   sequence:Sequence
   comp:Comp
   expr:Expr
   term:Term
   cpo:COP
   eop:EOP
   top:TOP
   fact:Fact
   isint:IsInt
   isident:IsIdent
define

%As declarações são analisadas com Stat, da seguiinte forma:
   fun{Stat S1 Sn}
      T|S2=S1 in
      case T
      of begin then
	 {Sequence Stat fun {$ X} X==';' end S2 'end'|Sn}
      [] 'if' then C X1 X2 S3 S4 S5 S6 in
	 C={Comp S2 S3}
	 S3='then'|S4
	 X1={Stat S4 S5}
	 S5='else'|S6
	 X2={Stat S6 Sn}
	 'if'(C X1 X2)
      [] while then C X S3 S4 in
	 C={Comp S2 S3}
	 S3='do'|S4
	 X={Stat S4 Sn}
	 while(C X)
      [] read then I in
	 I={Id S2 Sn}
	 read(I)
      [] write then E in
	 E={Expr S2 Sn}
	 write(E)
      elseif {IsIdent T} then E S3 in
	 S2=':='|S3
	 E={Expr S3 Sn}
	 assign(T E)
      else
	 S1=Sn
	 raise error(S1) end
      end
   end

   %Sequence é um procedimento genérico que
   %também lida com sequências de comparação, sequências de expressão e sequências de termos
   fun{Sequence NonTerm Sep S1 Sn}
      fun{SequenceLoop Prefix S2 Sn}
	 case S2 of T|S3 andthen {Sep T} then Next S4 in
	    Next={NonTerm S3 S4}
	    {SequenceLoop T(Prefix Next) S4 Sn}
	 else
	    Sn=S2 Prefix
	 end
      end
      First S2
   in
      First={NonTerm S1 S2}
      {SequenceLoop First S2 Sn}
   end

   %Comparações, expressões, e os termos são analisados da seguinte forma com Sequência:
   fun{Comp S1 Sn} {Sequence Expr COP S1 Sn} end
   fun{Expr S1 Sn} {Sequence Term EOP S1 Sn} end
   fun{Term S1 Sn} {Sequence Fact TOP S1 Sn} end

%Depois disso, temos que cada uma dessas três funções acima  tem sua função correspondente para detectar separadores:
   fun{COP Y}
      Y=='<' orelse Y=='>' orelse Y=='=<' orelse Y=='>=' orelse Y=='==' orelse Y=='!='
   end
   fun{EOP Y} Y=='+' orelse Y=='-' end
   fun{TOP Y} Y=='*' orelse Y=='/' end

%Depois disso, os Finalmente, os fatores e identificadores são analisados da seguinte forma:
   fun {Fact S1 Sn}
      T|S2=S1 in
      if {IsInt T} orelse {IsIdent T} then
	 S2=Sn
	 T
      else E S2 S3 in
	 S1='('|S2
	 E={Expr S2 S3}
	 S3=')'|Sn
	 E
      end
   end

   fun{Id S1 Sn} X in S1=X|Sn true={IsIdent X} X end
   fun{IsIdent X} {IsAtom X} end
% %A principal chamada do programa principal é essa função {Prog S1 Sn}, onde S1 é uma lista de entrada de
%    % tokens e Sn é o resto da lista após a análise. Esta chamada retorna o analisado
%    % resultado.A principal chamada do analisador é a função {Prog S1 Sn}, onde S1 é uma lista de entrada de
%    % tokens e Sn é o resto da lista após a análise. Esta chamada retorna o analisado
   fun{Prog S1 Sn}
      Y Z S2 S3 S4 S5
   in
      S1=program|S2
      Y={Id S2 S3}
      S3=';'|S4
      Z={Stat S4 S5}
      S5='end'|Sn
      prog(Y Z)
   end
end