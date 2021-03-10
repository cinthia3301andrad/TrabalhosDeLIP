functor
import
Browser
   %aqui importamos o functor encapsulado do arquivo TreeFunctor.oz
   TreeOperations at 'TreeFunctor.ozf' %Aqui colocamo o nome ou caminho do arquivo
   
define
   %Criação da árvore inicial
   %É aqui que colocamos as restrições da árvore em termos das coordenadas de cada nó,
   %obs: baseado no código do livro;
   ArvoreInitial=tree(key:a val:111
	       left:tree(key:b val:55
			 left:tree(key:x val:100
				   left:tree(key:z val:56 left:leaf right:leaf)
				   right:tree(key:w val:23 left:leaf right:leaf))
			 right:tree(key:y val:105 left:leaf
				    right:tree(key:r val:77 left:leaf right:leaf)))
	       right:tree(key:c val:123
			  left:tree(key:d val:119
				    left:tree(key:g val:44 left:leaf right:leaf)
				    right:tree(key:h val:50
					       left:tree(key:i val:5 left:leaf right:leaf)
					       right:tree(key:j val:6 left:leaf right:leaf)))
			  right:tree(key:e val:133 left:leaf right:leaf)))
   
   %Criação da árvore com a adicao dos campos x e y
   Arvore={TreeOperations.addXY ArvoreInitial}

   % %print da arvore inicial
   % {Browser.browse 'Print da Arvore 1'}
   % {Browser.browse ArvoreInitial}

   % %print da arvore com os campos x e y
   {TreeOperations.depthFirst Arvore 1 50 _ _}
   {Browser.browse Arvore}
end