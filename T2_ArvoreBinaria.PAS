{Aluno: Rafael Delalibera Rodrigues - RA: 207000519              }
{Professor Carlos Fisher - Estrutura de Dados 1                  }
{UNESP Rio Claro - Ci�ncias da Computa��o                        }
{Compilador: Borland Turbo Pascal Vers�o 7.0                     }
{Computador: AMD K6II 550 Mhz; 64 Mb RAM                         }
{Programa que implementa opera��es em uma �rvore bin�ria com     }
{destaque para o procedimento de busca e retirada de elementos   }
{18 de Abril de 2006                                             }
Program trab_arv;
uses crt;
type pont=^no;
     no=record info:integer;      {n� da �rvore}
               esq,dir:pont;
               end;

var y,opt:integer;
    ask:char;
    tree:pont; {�nica �rvore a ser tratada pelo programa principal}
    t:pont;
function constr(x:integer):pont;    {Constr�i um n� e retorna seu endere�o}
    var aux:pont;
    begin
     new(aux);
     aux^.info:=x;
     aux^.esq:=nil;
     aux^.dir:=nil;
     constr:=aux;
    end;

procedure iesq(var p:pont;x:integer);   {Insere um n� � esquerda}
    begin
     if p^.esq<>nil
        then write('Opera��o Ilegal')
        else p^.esq:=constr(x)
    end;

procedure idir(var p:pont;x:integer);   {Insere um n� � direita}
    begin
     if p^.dir<>nil
        then write('Opera��o Ilegal')
        else p^.dir:=constr(x)
    end;

procedure preperc(p:pont);              {Percorre a �rvore em Pr�-Ordem}
    begin
     if p<>nil
        then begin
              writeln(p^.info);
              preperc(p^.esq);
              preperc(p^.dir)
             end
    end;

procedure posperc(p:pont);              {Percorre a �rvore em P�s-Ordem}
    begin
     if p<>nil
        then begin
              posperc(p^.esq);
              posperc(p^.dir);
              writeln(p^.info)
             end
     end;

procedure inperc(p:pont);              {Percorre a �rvore em In-Ordem}
    begin
     if p<>nil
        then begin
              inperc(p^.esq);
              writeln(p^.info);
              inperc(p^.dir)
             end
     end;


function busca(raiz:pont;x:integer;select:integer):pont; {Busca elemento x na �rvore}
    var encontrado:boolean;               {Select=1 : retorna o endere�o do pai de x}
        aux,father:pont;
    begin
     father:=nil;
     encontrado:=false;
     aux:=raiz;
     while (aux<>nil) and (not encontrado) do
        if x=aux^.info
           then encontrado:=true
           else begin
                 father:=aux;
                 if x<aux^.info
                    then aux:=aux^.esq
                    else aux:=aux^.dir
                end;
     if encontrado=true
        then busca:=aux
        else busca:=nil;
     if select=1 then busca:=father
    end;

procedure insert(var raiz:pont;x:integer); {Insere um elemento com crit�rio:}
    var t,p:pont;                          {� esqueda os valores menores que}
    begin                                  {a raiz e � direita os maiores}
     t:=raiz;
     if raiz=nil
        then raiz:=constr(x)               {�rvore vazia}
        else begin
              while (t<>nil) and (x<>t^.info) do
               begin
                p:=t;
                if x<t^.info then t:=t^.esq
                             else t:=t^.dir
               end;
              if p^.info<>x then if x<p^.info then p^.esq:=constr(x)
                                              else p^.dir:=constr(x)
             end
    end;

function filhos(p:pont):integer;        {Retorna o n�mero de filhos de um n�}
    var k:integer;
    begin
     k:=0;
     if p^.esq<>nil then k:=k+1;
     if p^.dir<>nil then k:=k+1;
     filhos:=k;
    end;

function ant_in(p:pont):pont;    {Retorna o endere�o do elemento que ser� colocado}
    begin                        {no lugar do elemento a ser retirado}
     if p^.esq<>nil then ant_in:=ant_in(p^.esq)
                    else ant_in:=p
    end;

procedure b_ret(var raiz:pont;x:integer); {Busca e retira o elemento x, se existente}
    var aux,pai,filho,ant,p_ant:pont; {elemento,pai,filho,anterior,pai do anterior}
    begin
     aux:=busca(raiz,x,0);   {Elemento procurado}
     pai:=busca(raiz,x,1);   {Pai do elemento procurado}
     if aux=nil
        then writeln('O Elemento Procurado N�o Existe')
        else case filhos(aux) of
             0: begin
                 if pai=nil then raiz:=nil
                            else if pai^.dir=aux
                                    then pai^.dir:=nil
                                    else pai^.esq:=nil;
                 dispose(aux);
                end;
             1: begin
                 if pai=nil then if aux^.dir<>nil
                                     then raiz:=aux^.dir
                                     else raiz:=aux^.esq
                             else if pai^.dir=aux
                                     then if aux^.dir<>nil
                                             then pai^.dir:=aux^.dir
                                             else pai^.dir:=aux^.esq
                                     else if aux^.dir<>nil
                                             then pai^.esq:=aux^.dir
                                             else pai^.esq:=aux^.esq;
                 dispose(aux);
                end;
             2: begin
                 filho:=aux^.dir; {Filho � direita do elemento a ser retirado}
                 if pai=nil then begin  {If 1}
                                  ant:=ant_in(filho);
                                  p_ant:=busca(raiz,ant^.info,1);
                                  if p_ant<>aux then begin  {If 2}
                                                      p_ant^.esq:=ant^.dir;
                                                      ant^.esq:=aux^.esq;
                                                      ant^.dir:=p_ant;
                                                      raiz:=ant;
                                                      dispose(aux)
                                                     end
                                                else begin
                                                      ant^.esq:=aux^.esq;
                                                      raiz:=ant;
                                                      dispose(aux)
                                                     end    {Fim:If 2}
                                 end    {End:Then:If 1}
                            else begin  {Else If 1}
                                  ant:=ant_in(filho);
                                  p_ant:=busca(raiz,ant^.info,1);
                                  if p_ant<>aux then begin  {If 3}
                                                        p_ant^.dir:=ant^.dir;
                                                        ant^.esq:=aux^.esq;
                                                        ant^.dir:=p_ant;
                                                        if aux^.info<pai^.info then pai^.esq:=ant
                                                                               else pai^.dir:=ant;
                                                        dispose(aux)
                                                       end
                                                  else begin
                                                        ant^.esq:=aux^.esq;
                                                        if aux^.info<pai^.info then pai^.esq:=ant
                                                                               else pai^.dir:=ant;
                                                        dispose(aux)
                                                       end  {Fim:If 3}
                                 end    {Fim:Else:If 1}
                end {Case :2}
             end  {End do Case}
    end; {Fim do Procedimento b_ret}

Begin {Inicio do Programa Principal}
 tree:=nil;
 while upcase(ask)<>'N' do
  begin
   clrscr;
   writeln('Escolha a op��o desejada:');
   writeln('1 - Inserir Elemento na �rvore');
   writeln('2 - Buscar Elemento na �rvore');
   writeln('3 - Buscar e Retirar Elemento da �rvore');
   writeln('4 - Mostrar Elementos da �rvore Pr�-Ordem');
   writeln('5 - Mostrar Elementos da �rvore In-Ordem');
   writeln('6 - Mostrar Elementos da �rvore P�s-Ordem');
   write('Escolha: ');
   readln(opt);
   case opt of
    1: begin
        write('Elemento a ser inserido (inteiro): ');
        readln(y);
        insert(tree,y);
       end;
    2: begin
        write('Elemento a ser buscado (inteiro): ');
        readln(y);
        t:=busca(tree,y,0);
        if t=nil then writeln('Elemento n�o encontrado')
                               else writeln('Elemento Encontrado')
       end;
    3: begin
        write('Elemento a ser buscado/retirado (inteiro): ');
        readln(y);
        b_ret(tree,y);
       end;
    4: preperc(tree);
    5: inperc(tree);
    6: posperc(tree);
    end; {End do Case}
   write('Deseja Continuar Executando o Programa? (S/N): ');
   readln(ask)
  end    {End do While}
End.     {Fim do Programa Principal}