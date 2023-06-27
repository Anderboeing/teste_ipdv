<cfif structKeyExists(url,'delete') and url.delete GT 0>
    <cfquery name="deleteUsuario" datasource="teste_ipdv">
        DELETE FROM Usuario WHERE id = #url.id#;
    </cfquery>
    <cflocation url="/usuario/usuario.cfm?msg=Usuário deletado com sucesso!">
<cfelseif structKeyExists(url,'excluirTodos') and url.excluirTodos GT 0>
    <cfquery name="deletarUsuarios" datasource="teste_ipdv">
        DELETE FROM Usuario
    </cfquery>
    <cflocation url="/usuario/usuario.cfm?msg=Todos os Usuários foram excluídos com sucesso!">
<cfelseif IsDefined("form.id") AND LEN(Trim(form.id))>
    <cftry>
        <cfoutput>
            <cfquery name="updateUsuario" datasource="teste_ipdv">
                UPDATE
                    Usuario
                SET
                    nome_completo = '#form.nome_completo#',
                    <cfif len(form.data_nascimento) EQ 0>
                        data_nascimento = NULL
                    <Cfelse>
                        data_nascimento = '#form.data_nascimento#'
                    </cfif>,
                    cidade = '#form.cidade#',
                    salario = '#form.salario#'
                WHERE
                  id = #form.id#
            </cfquery>
        </cfoutput>
        <cfcatch type="any"> 
            <cflocation url="/usuario/usuario.cfm?error=Houve um erro ao editar o usuário. Verifique os dados inseridos e tente novamente!">
        </cfcatch>
        <cflocation url="/usuario/usuario.cfm?msg=Usuário atualizado com sucesso!">
    </cftry>
<cfelseif IsDefined("form.nome_completo") AND LEN(Trim(form.nome_completo))>
    <cftry>
        <cfoutput>
            <cfquery name="criaUsuario" datasource="teste_ipdv">
                INSERT INTO Usuario (nome_completo, 
                                    salario, 
                                    data_nascimento, 
                                    cidade, 
                                    id_cargo, 
                                    id_departamento)
                VALUES ('#form.nome_completo#', 
                        '#form.salario#',
                        <cfif len(form.data_nascimento) EQ 0>
                            NULL
                        <Cfelse>
                            #form.data_nascimento#
                        </cfif>,
                        '#form.cidade#', 
                        '#form.id_cargo#', 
                        '#form.id_departamento#');
            </cfquery>
        </cfoutput>
        <cfcatch type="any">
            <cflocation url="/usuario/usuario.cfm?error=Houve um erro ao criar o usuário. Verifique os dados inseridos e tente novamente!">
        </cfcatch>
        <cflocation url="/usuario/usuario.cfm?msg=Usuário cadastrado com sucesso!">
    </cftry>       
</cfif>
                
<cfinclude template="../header.cfm">
<cfoutput>
    <cfset id = replace("#cgi.query_string#","id=","","all")>
    <cfif IsDefined("id") AND LEN(Trim(id))>
        <cfquery name="editaUsuario" datasource="teste_ipdv">
            select id, nome_completo, data_nascimento, cidade, salario, id_cargo, id_departamento 
            from Usuario where id = #id#
        </cfquery>

        <cfquery name="cargos" datasource="teste_ipdv">
            select id, cargo from Cargo
        </cfquery>
        <cfquery name="departamentos" datasource="teste_ipdv">
            select id, departamento from Departamento
        </cfquery>
        <cfif editaUsuario.getRecordCount() GT 0>
            <div>
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ModalLabel">Editar Usuário</h5>
                        </div>
                        <div class="modal-body">
                            <cfform name="form" action="crudUsuario.cfm">
                                <input name="id" type="hidden" value="#editaUsuario.id#">
                                <div class="form-group">
                                    <label>Nome Completo</label>
                                    <input type="text" name="nome_completo" maxLength="50" class="form-control" value="#editaUsuario.nome_completo#">
                                </div>
                                <div class="form-group">
                                    <label>Cargo</label>
                                    <select name="id_cargo" class="form-control">
                                        <cfloop query="cargos">
                                            <cfif id eq editaUsuario.id_cargo>
                                                <option selected value="#cargos.id#">#cargos.cargo#</option>
                                            <cfelse>
                                                <option value="#cargos.id#">#cargos.cargo#</option>
                                            </cfif>
                                        </cfloop>
                                      </select>
                                </div>
                                <div class="form-group">
                                    <label>Departamento</label>
                                    <select name="id_departamento" class="form-control">
                                        <cfloop query="departamentos">
                                            <cfif id eq editaUsuario.id_departamento>
                                                <option selected value="#departamentos.id#">#departamentos.departamento#</option>
                                            <cfelse>    
                                                <option value="#departamentos.id#">#departamentos.departamento#</option>
                                            </cfif>
                                        </cfloop>
                                      </select>
                                </div>
                                <div class="form-group">
                                    <label>Data de Nascimento</label>
                                    <cfif len(editaUsuario.data_nascimento) GT 0>
                                        <cfset data_nascimento = editaUsuario.data_nascimento.dateFormat('yyyy-mm-dd')>
                                    <cfelse>
                                        <cfset data_nascimento = ''>
                                    </cfif>
                                    <input type="date" name="data_nascimento" class="form-control" value="#data_nascimento#">
                                </div>
                                <div class="form-group">
                                    <label>Cidade</label>
                                    <input type="text" name="cidade" maxLength="50" class="form-control" value="#editaUsuario.cidade#">
                                </div>
                                <div class="form-group">
                                    <label>Salário</label>
                                    <input type="number" name="salario" max="9999999999" min="1" class="form-control" value="#editaUsuario.salario#" required="required">
                                </div>
                                <div class="modal-footer">
                                    <button type="submit"  id="saveModalButton" class="btn btn-primary" data-dismiss="modal">Salvar</button>
                                </div>
                            </cfform>
                        </div>
                    </div>
                </div>
            </div>
        </cfif>
    </cfif>
</cfoutput>
<cfinclude template="../footer.cfm">