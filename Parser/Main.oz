declare Parser in
functor
import
   Browser
   Parser at 'ParserFunctor.oza'
define A  in

   A={Parser.programaPrincipal
      [program foo ';' while a '+' 3 '<' b 'do' b ':=' b '+' 1 'end']
      nil}
   {Browser.browse A}
end