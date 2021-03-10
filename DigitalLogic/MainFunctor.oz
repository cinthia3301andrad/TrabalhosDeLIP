functor
import
   Browser
   %aqui importamos o functor DigitalLogic
   DigitalLogicFunctor at 'DigitalLogicFunctor.ozf' %nome do arquivo
define
   A = 0|_
   B = 1|_
   Bin = 1|_

   X=1|1|0|_
   Y=0|1|0|_
   Z=1|1|1|_ C S 

   {DigitalLogicFunctor.somadorCompleto X Y Z C S}
   {Browser.browse inp(X Y Z)#sum(C S)}
   
   %Full Subtractor
   {Browser.browse 'Diferença (A-B), utilizando xorG:'}
   AB = {DigitalLogicFunctor.xorG A B}
   {Browser.browse {DigitalLogicFunctor.xorG AB Bin}}

   {Browser.browse 'Empresta um, utilizando orG, andG e notG  :'}
   {Browser.browse {DigitalLogicFunctor.orG {DigitalLogicFunctor.andG {DigitalLogicFunctor.notG AB} Bin} {DigitalLogicFunctor.andG {DigitalLogicFunctor.notG A} B}}}
end