sig Colaborador{}
sig Gerente extends Colaborador{}

sig Projeto{
	atividades: set Atividade,
	gerente: one Gerente,
	colaboradoresNaoAlocados: set Colaborador
}

sig Atividade{
	colaboradores: set Colaborador
}

pred doisProjetosNaoPossuemAMesmAtividade[p1: Projeto, p2: Projeto]{
	#(p1.atividades & p2.atividades)=0 and not (p1=p2)
}

pred projetoDeveTerPeloMenosUmaAtividade[p: Projeto]{
	not(#(p.atividades) = 0)
}

pred umaAtividadeDeveEstarContidaEmUmProjeto[p: Projeto, a: Atividade]{
	a in p.atividades
}

pred colaboresNaoAlocadosNaoEstaoAssociadosAAtividades[p: Projeto, a: Atividade]{
	#(p.colaboradoresNaoAlocados & a.colaboradores)=0 
}

pred gerenteNaoPodeSerColaboradorNaoAlocado[p: Projeto]{
	not(p.gerente in p.colaboradoresNaoAlocados)
}

pred gerenteDeveSerGerenteDeUmProjeto[g: Gerente, p: Projeto]{
 	p.gerente = g
}
 
fact doisProjetosNaoPossuemAMesmAtividade{
	some p1: Projeto, p2: Projeto | doisProjetosNaoPossuemAMesmAtividade[p1, p2]
}

fact atividadeDeveEstarRelacionadaAUmProjeto{
	all a: Atividade | one p: Projeto | one(p) => umaAtividadeDeveEstarContidaEmUmProjeto[p, a] 
}

fact projetoDeveTerPeloMenosUmaAtividade{
	all p: Projeto | projetoDeveTerPeloMenosUmaAtividade[p]
}

fact gerenteNaoPodeSerUmColaboradorNaoAlocado{
	all p: Projeto | gerenteNaoPodeSerColaboradorNaoAlocado[p]
}

fact colaboresNaoAlocadosNaoPossuemAtividades{
	all p: Projeto | all a: Atividade| a in p.atividades => colaboresNaoAlocadosNaoEstaoAssociadosAAtividades[p, a]
}

fact todoGerenteDeveGerenciarPeloMenosUmProjeto{
	all g: Gerente | some p: Projeto | gerenteDeveSerGerenteDeUmProjeto[g, p]
}

pred show() {}
run show for 3
