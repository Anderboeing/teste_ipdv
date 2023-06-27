<cfif structKeyExists(url,'delete') and url.delete GT 0>
    <cfquery name="procuraUsuarios" datasource="teste_ipdv">
        select id_cargo from Usuario where id_cargo = #url.id#;
    </cfquery>
    <cfif procuraUsuarios.getRecordCount() GT 0>
        <cflocation url="/cargo/cargo.cfm?warning=impossível deletar cargo, existem usuários associados!">
    <Cfelse>
        <cfquery name="cargo" datasource="teste_ipdv">
            DELETE FROM Cargo WHERE id = #url.id#;
        </cfquery>
        <cflocation url="/cargo/cargo.cfm?msg=Cargo deletado com sucesso!">
    </cfif>
<cfelseif structKeyExists(url,'excluirTodos') and url.excluirTodos GT 0>
    <cfquery name="DeleteCargos" datasource="teste_ipdv">
        DELETE FROM Cargo
            Where Cargo.cargo IN(
                select C.cargo
                from Usuario As U 
                right JOIN Cargo as C on U.id_cargo = C.id
                where U.id_cargo IS null
            )
    </cfquery>
    <cflocation url="/cargo/cargo.cfm?msg=Todos os Cargos <b>sem usuários</b> foram excluídos com sucesso!">
<cfelseif IsDefined("form.id") AND LEN(Trim(form.id))>
    <cftry>
        <cfoutput>
            <cfquery name="updateCargo" datasource="teste_ipdv">
                UPDATE
                    Cargo
                SET
                    cargo = '#form.cargo#'
                WHERE
                  id = #form.id#
            </cfquery>
        </cfoutput>
        <cfcatch type="any"> 
            <cflocation url="/cargo/cargo.cfm?error=Houve um erro ao editar o cargo. Verifique os dados inseridos e tente novamente!">
        </cfcatch>
        <cflocation url="/cargo/cargo.cfm?msg=Cargo alterado com sucesso!">
    </cftry>
<cfelseif IsDefined("form.cargo") AND LEN(Trim(form.cargo))>
    <cftry>
        <cfoutput>
            <cfquery name="cargo" datasource="teste_ipdv">
                INSERT INTO Cargo (cargo)
                VALUES ('#form.cargo#');
            </cfquery>
        </cfoutput>
        <cfcatch type="any">
            <cflocation url="/cargo/cargo.cfm?error=Houve um erro ao criar o cargo. Verifique os dados inseridos e tente novamente!">
        </cfcatch>
        <cflocation url="/cargo/cargo.cfm?msg=Cargo cadastrado com sucesso!">
    </cftry>
</cfif>
                
<cfinclude template="../header.cfm">
<cfoutput>
    <cfset id = replace("#cgi.query_string#","id=","","all")>
    <cfif IsDefined("id") AND LEN(Trim(id))>
        <cfquery name="editarCargo" datasource="teste_ipdv">
            select id, cargo 
            from Cargo where id = #id#
        </cfquery>
        <cfif #editarCargo.getRecordCount()# GT 0>
            <div>
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ModalLabel">Editar Cargo</h5>
                        </div>
                        <div class="modal-body">
                            <cfform name="form" action="crudCargo.cfm">
                                <input name="id" type="hidden" value="#editarCargo.id#">
                                <div class="form-group">
                                    <label>Cargo</label>
                                    <input type="text" name="cargo" maxLength="50" value="#editarCargo.cargo#" class="form-control">
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
