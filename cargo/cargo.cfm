<cfoutput>
    <cfquery name="cargo" datasource="teste_ipdv">
        select id, cargo from Cargo
    </cfquery>
    <cfinclude template="../header.cfm">
    <div class="container-xl">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Cargo</h2>
                        </div>
                        <div class="col-sm-6">
                            <a href="##addCargo" class="btn btn-success" data-toggle="modal">
                                <span>Adicionar Cargo</span>
                            </a>
                            <a href="crudCargo.cfm?excluirTodos=true" class="btn btn-Danger">
                                <span>Deletar todos</span>
                            </a>
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Cargo</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="cargo">
                            <tr>
                                <td>#cargo.cargo#</td>
                                <td>
                                    <a href="crudCargo.cfm?id=#cargo.id#" class="edit verticalAlign">
                                        <i class="fa fa-edit" data-toggle="tooltip" title="" data-original-title="Edit"></i>
                                    </a>
                                    <a href="/cargo/read.cfm?id=#cargo.id#" class="book verticalAlign">
                                        <i class="fa fa-book" data-toggle="tooltip" title="" data-original-title="read"></i>
                                    </a>
                                    <button class="btn delete" data-href="crudCargo.cfm?id=#cargo.id#&delete=S" data-toggle="modal" data-target="##confirm-delete">
                                        <i class="fa fa-trash-o" data-toggle="tooltip" title="" data-original-title="Delete"></i>
                                    </button>
                                </td>
                            </tr>
                        </cfloop>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- criar Modal HTML -->
    <div id="addCargo" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <cfform name="form" action="crudCargo.cfm">
                    <div class="modal-header">
                        <h4 class="modal-title">Adicionar Cargo</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Cargo</label>
                            <input type="text" name="cargo" maxLength="50" class="form-control">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancelar">
                        <input type="submit" class="btn btn-success" value="Criar">
                    </div>
                </cfform>
            </div>
        </div>
    </div>
    
    <!-- Deletar Modal HTML -->
    <div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Deletar Cargo</h4>
                </div>
                <div class="modal-body">
                    <p>Você tem certeza que quer deletar este Cargo?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-danger btn-ok">Delete</a>
                </div>
            </div>
        </div>
    </div>
    
    <script type="application/javascript">
        $('##confirm-delete').on('show.bs.modal', function(e) {
            $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
        });
    </script>
</cfoutput>
<cfinclude template="../footer.cfm">