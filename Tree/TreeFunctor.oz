% declare [QTk]={Module.link ["x-oz://system/wp/QTk.ozf"]}
functor
export
 %Aqui fazemos a exportação dos métodos do functor
   addXY: AddXY
   depthFirst: DepthFirst
define
     %Cria e retorna uma nova arvore baseada na passada como parametro, porem adicionando os campos x e y a todos os nos
     %Ou seja, esta função AddXY retorna uma nova árvore com os dois campos x e y adicionados a todos os nós. Ele usa a função Adjoin que pode adicionar novos campos aos registros e substituir os antigos.
    fun {AddXY Tree}
        case Tree
        of tree(left:L right:R ...) then
            {Adjoin Tree
                tree(x:_ y:_ left:{AddXY L} right:{AddXY R})}
        [] leaf then
            leaf
        end
    end

 %Aqui, utilizamos o método da determinação da ordem das operações para encontrar a ordem de cálculo correta em tempo de execução. Cada cálculo
    % que pode bloquear é feito em um thread próprio.8 O resultado do algoritmo é o
    % o mesmo de antes.
 %Ou seja, nessa parte do código,o algoritmo recebe uma árvore e calcula as posições
    % de todos os nós da árvore para que a árvore possa ser desenhada 
    % então o DepthFirst "atravessa" a árvore em duas direções: primeiro da raiz para
    % as folhas e depois das folhas de volta à raiz.
    proc {DepthFirst Tree Level LeftLim ?RootX ?RightLim} % Level e LeftLim são entradas (eles se propagam em direção às folhas)
        case Tree
        of tree(x:X y:Y left:leaf right:leaf ...) then
        X=LeftLim
        RootX=X
        RightLim=X
        thread Y=50*Level end
            [] tree(x:X y:Y left:L right:leaf ...) then
            X=RootX
            thread Y=50*Level end
            {DepthFirst L Level+1 LeftLim RootX RightLim}
            [] tree(x:X y:Y left:leaf right:R ...) then
            X=RootX
            thread Y=50*Level end
            {DepthFirst R Level+1 LeftLim RootX RightLim}
            [] tree(x:X y:Y left:L right:R ...) then
            LRootX LRightLim RRootX RLeftLim
            in
            RootX=X
        thread X=(LRootX+RRootX) div 2 end
        thread Y=50*Level end
        thread RLeftLim=LRightLim+50 end
        {DepthFirst L Level+1 LeftLim LRootX LRightLim}
        {DepthFirst R Level+1 RLeftLim RRootX RightLim}
        end
    end
end

% Tentativa de usar o QTk para printar
% local   C   Desc=canvas(handle:C width:200 height:200) in   
%    {{QTk.build td(Desc)} show}   
%    {C create(rect 10 10 190 190 fill:blue outline:red)}   
%    {C create(text 100 100 text:"Canvas" fill:yellow)}
% end   
%    {C create (line RightLim LeftLim X Y fill:red width:3)}