<cfinclude template="../header.cfm">
<cfoutput>
    <cfset id = replace("#cgi.query_string#","id=","","all")>
    <cfif IsDefined("id") AND LEN(Trim(id))>
        <cfquery name="readUsuario" datasource="teste_ipdv">
            select U.id, nome_completo, data_nascimento, cidade, salario, C.cargo, D.departamento
            from Usuario As U 
            INNER JOIN Cargo as C on U.id_cargo = C.id
            INNER JOIN Departamento as D on U.id_departamento = D.id
            where U.id = #id#
        </cfquery>
        <cfif readUsuario.getRecordCount() GT 0>
            <div>
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ModalLabel">Visualizar Usuário</h5>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label class="label-negrito">Nome Completo</label>
                                <p>#readUsuario.nome_completo#</p>
                            </div>
                            <hr>
                            <div class="form-group">
                                <label class="label-negrito">Cargo</label>
                                <p>#readUsuario.cargo#</p>
                            </div>
                            <hr>
                            <div class="form-group">
                                <label class="label-negrito">Departamento</label>
                                <p>#readUsuario.departamento#</p>
                            </div>
                            <hr>
                            <div class="form-group">
                                <label class="label-negrito">Data de Nascimento</label>
                                <p><cfif len(readUsuario.data_nascimento) GT 0>#readUsuario.data_nascimento.dateFormat('dd/mm/yyyy')#
                                <cfelse>
                                    __/__/____
                                </cfif></p>
                            </div>
                            <hr>
                            <div class="form-group">
                                <label class="label-negrito">Cidade</label>
                                <p>#readUsuario.cidade#</p>
                            </div>
                            <hr>
                            <div class="form-group">
                                <label class="label-negrito">Salário</label>
                                <p>#LSCurrencyFormat(readUsuario.salario, 'local', 'pt_BR')#</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </cfif>
    </cfif>
</cfoutput>
<cfinclude template="../footer.cfm">