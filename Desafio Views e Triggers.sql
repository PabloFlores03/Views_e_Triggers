-- DESAFIO VIEWS E TRIGGER's --
-- Criar view de número de empregados por departamento e localidade --  
Create View view_numero_emprego_departamento_localidade as 
			Select Fname, Dno, Dlocation, Dname
				From employee as e
					inner join departament as d
						on d.Dnumber = e.Dno
					inner join dept_locations as l
						on d.Dnumber = l.Dnumber;
Select * from view_numero_emprego_departamento_localidade;

-- Lista de departamento e seus gerentes -- 
Create View view_gerente_departamento as 
			Select e.Fname, d.Dname
				From employee as e
					inner join departament as d
						on d.Mgr_ssn = e.Ssn;
Select * from view_gerente_departamento;
   
-- Projetos com maior número de empregados -- 
Create View view_projeto_empregados as 
   Select e.Fname, p.Pname, p.Pnumber
				From employee as e
					inner join Project as p
						on p.Dnum = e.Dno
                        order by Pnumber;
Select * from view_projeto_empregados; 

-- Lista de projetos, departamentos e gerentes
Create View view_projetos_departamentos_gerentes as 
Select e.Fname, d.Dname, w.Pno, p.Pname
				From employee as e
					inner join departament as d
						on d.Mgr_ssn = e.Ssn
                    inner join works_on as w
                        on w.Essn = e.Ssn
                    inner join Project as p
                        on p.Pnumber = w.Pno;
Select * from view_projetos_departamentos_gerentes;

-- Quais empregados possuem dependentes e se são gerentes
Create View view_gerentes_com_dependentes as 
Select e.Fname, d.Dname, f.Dependent_name
				From employee as e
					inner join departament as d
						on d.Mgr_ssn = e.Ssn
                    inner join dependent as f   
                        on e.Ssn = f.Essn;
Select * from view_gerentes_com_dependentes;    

-- Criando usuário -- 
Create user 'Jennifer'@localhost identified by '987654321';
grant all privileges on employee . * to 'Jennifer'@localhost;
grant all privileges on departament . * to 'Jennifer'@localhost;

-- TRIGGER 1 --
DELIMITER \\
CREATE TRIGGER trigger_apaga_projeto
    BEFORE DELETE
    ON Project FOR EACH ROW
BEGIN
   DELETE FROM Project WHERE Pnumber = '30';
END \\    

DELIMITER ;

-- TRIGGER 2 --
DELIMITER \\
CREATE TRIGGER trigger_update_projeto
    BEFORE update
    ON Project FOR EACH ROW
BEGIN
   UPDATE Project
SET Pname = 'ProjectSecret', Pnumber = '999', Plocation = 'Secret'
WHERE Dnum = '5';
END \\    

DELIMITER ;