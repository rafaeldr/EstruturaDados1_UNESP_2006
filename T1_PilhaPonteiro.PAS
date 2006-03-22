{Nome: Rafael Delalibera Rodrigues  ----------------  Data: 22 de Março de 2006}
{Curso: Bacharelado em Ciências da Computação – Integral - 2005}
{Matéria: Estrutura de Dados 1}
{Professor: Carlos Fisher}
{Compilador: Borland Turbo Pascal v7.0}
{Computador: AMD K6-II 550Mhz, 64 Mb RAM}

{Programa que implementa a estrutura Pilha usando ponteiros}

Program PilhaPont;
uses crt;
type tipo = integer;
     ponteiro = ^pilha;
     pilha = record
                   info:tipo;
                   prox:ponteiro;
             end;
var inicio:ponteiro;
    a:tipo;
    select:integer;
    ask:char;
procedure EsvPil(var inicio:ponteiro); {Esvazia a Pilha, mas não}
     begin                             {dá dispose nos dados anteriores}
     inicio:=nil;
     end;

function PilVaz(inicio:ponteiro):boolean; {Verifica se a Pilha está vazia}
     begin                                {Resultando em True no caso afirmativo}
     Pilvaz:=(inicio=nil);
     end;

function Topo(inicio:ponteiro):tipo; {Retorna o elemento no topo da pilha}
     begin
     if Pilvaz(inicio)
        then writeln('A Pilha est  vazia!')
        else topo:=inicio^.info;
     end;

procedure Pop(var inicio:ponteiro); {Retira o elemento do topo da pilha}
     var aux:ponteiro;
     begin
     if Pilvaz(inicio)
        then writeln('A Pilha est  vazia!')
        else
            begin
            aux:=inicio;
            inicio:=inicio^.prox;
            dispose(aux);
            writeln('Elemento Retirado com sucesso!');
            end
      end;

procedure Push(var inicio:ponteiro;x:tipo); {Adiciona um elemento na pilha}
     var p:ponteiro;
     begin
     new(p);
     p^.info:=x;
     p^.prox:=inicio;
     inicio:=p;
     end;

begin
while upcase(ask)<>'N' do
     begin
     clrscr;
     writeln('Digite o n£mero da op‡Æo desejada');
     writeln('1 - Esvaziar a Pilha');
     writeln('2 - Verificar se a Pilha est  Vazia');
     writeln('3 - Receber o topo da Pilha');
     writeln('4 - Retirar um elemento da Pilha');
     writeln('5 - Adicionar um elemento a Pilha');
     write('Escolha: ');
     readln(select);
     case select of
          1:  begin
              EsvPil(inicio);
              writeln('Pilha Esvaziada!');
              readln;
              end;
          2:  begin
              writeln('A Pilha est  vazia: ',Pilvaz(inicio));
              readln;
              end;
          3:  begin
              writeln('Elemento do Topo: ',topo(inicio));
              readln;
              end;
          4:  begin
              Pop(inicio);
              readln;
              end;
          5:  Begin
              write('Digite o valor a ser inserido: ');
              readln(a);
              Push(inicio,a);
              writeln('Elemento ',a,' adicionado!');
              readln;
              End;
          End;
     write('Deseja continuar executando o programa?(S/N) ');
     readln(ask);
     end;
end.