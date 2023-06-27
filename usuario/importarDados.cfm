<cfif IsDefined("form.planilha") AND LEN(Trim(form.planilha))>
    <cfspreadsheet action="read" src="#form.planilha#" sheet="1" query="planilha">
    <cfset colunasCertas = false>
    <cfoutput>
        <cfloop query="#planilha#" maxrows="1">
            <cfif 
                planilha.COL_1 EQ 'Nome_Completo' AND 
                planilha.COL_2 EQ 'Cargo' AND 
                planilha.COL_3 EQ 'Departamento' AND 
                planilha.COL_4 EQ 'Salario' AND
                planilha.COL_5 EQ 'data_nascimento' AND 
                planilha.COL_6 EQ 'cidade'>
                <cfset colunasCertas = true>
            </cfif>
        </cfloop>

        <cfif colunasCertas>
            <cfset msgErro = ''>
            <cfset msgSucesso = ''>
            <cfloop query="#planilha#" startrow="2">
                <cfquery name="verificaUsuario" datasource="teste_ipdv">
                    select nome_completo 
                    from Usuario where nome_completo = '#LCase(planilha.COL_1)#'
                </cfquery>
                
                <cfif verificaUsuario.recordCount() EQ 0>
                    <!--- RegEx --->
                    <cfset salario = replace(planilha.COL_4,"R$ ","","all")>
                    <Cfset validaNome = reFind("[0-9]", planilha.COL_1) + reFind("(?=.*[}{,.^?~=+\-_\/!@##$%¨&<>ºª°:;¹²³£¢¬§*\-+.\|])", planilha.COL_1)>
                    <Cfset validaCargo = reFind("(?=.*[}{,.^?~=+\-_\/!@##$%¨&<>ºª°:;¹²³£¢¬§*\-+.\|])", planilha.COL_2)>
                    <Cfset validaDepartamento = reFind("(?=.*[}{,.^?~=+\-_\/!@##$%¨&<>ºª°:;¹²³£¢¬§*\-+.\|])", planilha.COL_3)>
                    <Cfset validaCidade = reFind("[0-9]", planilha.COL_6) + reFind("(?=.*[}{,.^?~=+\-_\/!@##$%¨&<>ºª°:;¹²³£¢¬§*\-+.\|])", planilha.COL_6)>
                    <cfif Len(planilha.COL_5) GT 0 AND IsDate(planilha.COL_5)>
                        <cfset planilha.COL_5 = #DateFormat(Trim(planilha.COL_5), "yyyy-mm-dd")# />
                    </cfif>
                    <!--- Validação dos dados --->
                    <cfif Len(planilha.COL_1) GT 50 OR Len(planilha.COL_1) EQ 0>
                        <cfset msgErro = msgErro & "Nome do Usuário <b>" & #planilha.COL_1# & "</b> é muito grande ou está vazio. <br>">
                    <cfelseif validaNome GT 0>
                        <cfset msgErro = msgErro & "Nome do Usuário <b>" & #planilha.COL_1# & "</b> possui números ou caracteres especiais. <br>">
                    <cfelseif Len(planilha.COL_2) GT 50 OR Len(planilha.COL_2) EQ 0>
                        <cfset msgErro = msgErro & "Cargo <b>" & #planilha.COL_2# & "</b> do usuário <b>" & #planilha.COL_1# & "</b> é muito grande ou está vazio. <br>">
                    <cfelseif validaCargo GT 0>
                        <cfset msgErro = msgErro & "Cargo <b>" & #planilha.COL_2# & "</b> possui caracteres especiais. <br>">
                    <cfelseif Len(planilha.COL_3) GT 50 OR Len(planilha.COL_3) EQ 0>
                        <cfset msgErro = msgErro & "Departamento <b>" & #planilha.COL_3# & "</b> do usuário <b>" & #planilha.COL_1# & "</b> é muito grande ou está vazio. <br>">
                    <cfelseif validaDepartamento GT 0>
                        <cfset msgErro = msgErro & "Departamento <b>" & #planilha.COL_3# & "</b> possui caracteres especiais. <br>">
                     <cfelseif Len(salario) GT 10 OR Len(salario) EQ 0 OR !isValid("integer",salario) OR !isNumeric(salario)>
                        <cfset msgErro = msgErro & "Salário do Usuário <b>" & #planilha.COL_1# & "</b> está incorreto. <br>">
                    <cfelseif Len(planilha.COL_6) GT 50>
                        <cfset msgErro = msgErro & "Nome da Cidade <b>" & #planilha.COL_6# & "</b> do usuário <b>" & #planilha.COL_1# & "</b> é muito grande. <br>">
                    <cfelseif validaCidade GT 0>
                        <cfset msgErro = msgErro & "Cidade <b>" & #planilha.COL_6# & "</b> do usuário <b>" & #planilha.COL_1# & "</b> possui números ou caracteres especiais. <br>">
                    <cfelseif len(planilha.COL_5) GT 0 AND !IsDate(planilha.COL_5) >
                        <cfset msgErro = msgErro & "Data de nascimento do usuário <b>" & #planilha.COL_1# & "</b> não é uma data válida. <br>">
                    <cfelse>
                        <!--- Verifica e insere cargo --->
                        <cfquery name="verificaCargo" datasource="teste_ipdv">
                            select id, cargo 
                            from Cargo where cargo = '#LCase(planilha.COL_2)#'
                        </cfquery>
                        <cfif verificaCargo.recordCount() EQ 0>
                            <cfquery name="insereCargo" datasource="teste_ipdv">
                                INSERT INTO Cargo (cargo)
                                VALUES ('#planilha.COL_2#');
                            </cfquery>
                        </cfif>
                        <!--- Verifica e insere departamento --->
                        <cfquery name="verificaDepartamento" datasource="teste_ipdv">
                            select id, departamento 
                            from Departamento where departamento = '#LCase(planilha.COL_3)#'
                        </cfquery>
                        <cfif verificaDepartamento.recordCount() EQ 0>
                            <cfquery name="insereDepartamento" datasource="teste_ipdv">
                                INSERT INTO Departamento (departamento)
                                VALUES ('#planilha.COL_3#');
                            </cfquery>
                        </cfif>

                        <cfquery name="SelecionaCargo" datasource="teste_ipdv">
                            select id, cargo 
                            from Cargo where cargo = '#LCase(planilha.COL_2)#'
                        </cfquery>
                        <cfquery name="SelecionaDepartamento" datasource="teste_ipdv">
                            select id, departamento 
                            from Departamento where departamento = '#LCase(planilha.COL_3)#'
                        </cfquery>
                        <!--- Insere Usuário --->
                        <cfquery name="criaUsuario" datasource="teste_ipdv">
                            INSERT INTO Usuario (nome_completo, 
                                                salario, 
                                                data_nascimento, 
                                                cidade, 
                                                id_cargo, 
                                                id_departamento)
                            VALUES ('#planilha.COL_1#', 
                                    #salario#,
                                    <cfif len(planilha.COL_5) EQ 0>
                                        NULL
                                    <Cfelse>
                                        '#planilha.COL_5#'
                                    </cfif>,
                                    '#planilha.COL_6#', 
                                    #SelecionaCargo.id#, 
                                    #SelecionaDepartamento.id#);
                        </cfquery>
                        <cfset msgSucesso = msgSucesso & "Usuário <b>" & #planilha.COL_1# & "</b> Inserido com sucesso. <br>">
                    </cfif> 
                <cfelse>
                    <cfset msgErro = msgErro & "Usuário <b>" & #planilha.COL_1# & "</b> já existe. <br>">
                </cfif>
            </cfloop>

            <cfif len(msgSucesso) GT 0>
                <div class="success">#msgSucesso#</div>
            </cfif>
            <cfif len(msgErro) GT 0>
                <div class="error">#msgErro#</div>
            </cfif>
        <cfelse>
            <cflocation url="importarDados.cfm?warning=As colunas da tabela importada não estão no padrão esperado. Baixe o arquivo <b>Modelo-importação.xlsx</b> abaixo e tente novamente!">
        </cfif>
    </cfoutput>
</cfif>

<cfinclude template="../header.cfm">
<div class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6">
                        <h2>Importar usuários de planilha</h2>
                    </div>
                </div>
            </div>
            <label>Baixe o modelo de arquivo excel para incluir dados da importação</label>
            <a href="Modelo-importacao.xlsx">Modelo-importação.xlsx</a>
            <hr>
            <label>Ou Baixe este arquivo excel já preenchido (20 registros):</label>
            <a href="Modelo-preenchido.xlsx">Modelo-preenchido.xlsx</a>
            <hr>
            <cfform name="form" action="importarDados.cfm" enctype="multipart/form-data">
                <input type="file" name="planilha" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
                <div class="modal-footer">
                    <button type="submit"  id="saveModalButton" class="btn btn-primary" data-dismiss="modal">Importar</button>
                </div>
            </cfform>
        </div>
    </div>        
</div>
<cfinclude template="../footer.cfm">