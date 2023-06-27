<cfif structKeyExists(url,'delete') and url.delete GT 0>
    <cfquery name="procuraUsuarios" datasource="teste_ipdv">
        select id_departamento from Usuario where id_departamento = #url.id#;
    </cfquery>
    <cfif procuraUsuarios.getRecordCount() GT 0>
        <cflocation url="/departamento/departamento.cfm?warning=impossível deletar departamento, existem usuários associados!">
    <Cfelse>
        <cfquery name="departamento" datasource="teste_ipdv">
            DELETE FROM Departamento WHERE id = #url.id#;
        </cfquery>
        <cflocation url="/departamento/departamento.cfm?msg=Departamento deletado com sucesso!">
    </cfif>
<cfelseif structKeyExists(url,'excluirTodos') and url.excluirTodos GT 0>
    <cfquery name="DeleteDepartamentos" datasource="teste_ipdv">
        DELETE FROM Departamento
            Where Departamento.departamento IN(
                select D.departamento
                from Usuario As U 
                right JOIN Departamento as D on U.id_departamento = D.id
                where U.id_departamento IS null
            )
    </cfquery>
    <cflocation url="/departamento/departamento.cfm?msg=Todos os Departamentos <b>sem usuários</b> foram excluídos com sucesso!">
<cfelseif IsDefined("form.id") AND LEN(Trim(form.id))>
    <cftry>
        <cfoutput>
            <cfquery name="updateDepartamento" datasource="teste_ipdv">
                UPDATE
                    Departamento
                SET
                    departamento = '#form.departamento#'
                WHERE
                  id = #form.id#
            </cfquery>
        </cfoutput>
        <cfcatch type="any"> 
            <cflocation url="/departamento/departamento.cfm?error=Houve um erro ao editar o departamento. Verifique os dados inseridos e tente novamente!">
        </cfcatch>
        <cflocation url="/departamento/departamento.cfm?msg=Departamento alterado com sucesso!">
    </cftry>
<cfelseif IsDefined("form.departamento") AND LEN(Trim(form.departamento))>
    <cftry>
        <cfoutput>
            <cfquery name="departamento" datasource="teste_ipdv">
                INSERT INTO Departamento (departamento)
                VALUES ('#form.departamento#');
            </cfquery>
        </cfoutput>
        <cfcatch type="any">
            <cflocation url="/departamento/departamento.cfm?error=Houve um erro ao criar o departamento. Verifique os dados inseridos e tente novamente!">
        </cfcatch>
        <cflocation url="/departamento/departamento.cfm?msg=Departamento criado com sucesso!">
    </cftry>
</cfif>
                
<cfinclude template="../header.cfm">
<cfoutput>
    <cfset id = replace("#cgi.query_string#","id=","","all")>
    <cfif IsDefined("id") AND LEN(Trim(id))>
        <cfquery name="editarDepartamento" datasource="teste_ipdv">
            select id, departamento 
            from Departamento where id = #id#
        </cfquery>
        <cfif editarDepartamento.getRecordCount() GT 0>
            <div>
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ModalLabel">Editar Departamento</h5>
                        </div>
                        <div class="modal-body">
                            <cfform name="form" action="crudDepartamento.cfm">
                                <input name="id" type="hidden" value="#editarDepartamento.id#">
                                <div class="form-group">
                                    <label>Departamento</label>
                                    <input type="text" name="departamento" maxLength="50" value="#editarDepartamento.departamento#" class="form-control">
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