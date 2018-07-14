sig Colaborador{}
sig Gerente extends Colaborador{}

sig Projeto{
	atividades: set Atividade,
	gerente: one Gerente
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

fact doisProjetosNaoPossuemAMesmAtividade{
	some p1: Projeto, p2: Projeto | doisProjetosNaoPossuemAMesmAtividade[p1, p2]
}

fact atividadeDeveEstarRelacionadaAUmProjeto{
	no a: Atividade | some p: Projeto | not(a in p.atividades)  
}

fact projetoDeveTerPeloMenosUmaAtividade{
	all p: Projeto | projetoDeveTerPeloMenosUmaAtividade[p]
}


pred show() {}
run show for 3
