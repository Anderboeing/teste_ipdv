<cfinclude template="../header.cfm">
<cfoutput>
    <cfset id = replace("#cgi.query_string#","id=","","all")>
    <cfif IsDefined("id") AND LEN(Trim(id))>
        <cfquery name="readDepartamento" datasource="teste_ipdv">
            select departamento
            from Departamento
            where id = #id#
        </cfquery>
        <cfif readDepartamento.getRecordCount() GT 0>
            <div>
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ModalLabel">Visualizar Departamento</h5>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Departamento</label>
                                <p>#readDepartamento.departamento#</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </cfif>
    </cfif>
</cfoutput>
<cfinclude template="../footer.cfm">