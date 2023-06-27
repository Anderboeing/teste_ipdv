<cfoutput>
    <cfquery name="departamento" datasource="teste_ipdv">
        select id, departamento from Departamento
    </cfquery>
    <cfinclude template="../header.cfm">
    <div class="container-xl">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Departamento</h2>
                        </div>
                        <div class="col-sm-6">
                            <a href="##addDepartamento" class="btn btn-success" data-toggle="modal">
                                <span>Adicionar Departamento</span>
                            </a>
                            <a href="crudDepartamento.cfm?excluirTodos=true" class="btn btn-Danger">
                                <span>Deletar todos</span>
                            </a>
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Departamento</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="departamento">
                            <tr>
                                <td>#departamento.departamento#</td>
                                <td>
                                    <a href="crudDepartamento.cfm?id=#departamento.id#" class="edit verticalAlign">
                                        <i class="fa fa-edit" data-toggle="tooltip" title="" data-original-title="Edit"></i>
                                    </a>
                                    <a href="/departamento/read.cfm?id=#departamento.id#" class="book verticalAlign">
                                        <i class="fa fa-book" data-toggle="tooltip" title="" data-original-title="read"></i>
                                    </a>
                                    <button class="btn delete" data-href="crudDepartamento.cfm?id=#departamento.id#&delete=S" data-toggle="modal" data-target="##confirm-delete">
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
    <div id="addDepartamento" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <cfform name="form" action="crudDepartamento.cfm">
                    <div class="modal-header">
                        <h4 class="modal-title">Adicionar Departamento</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Departamento</label>
                            <input type="text" name="departamento" maxLength="50" class="form-control">
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
                    <h4 class="modal-title">Deletar Departamento</h4>
                </div>
                <div class="modal-body">
                    <p>Você tem certeza que quer deletar este Departamento?</p>
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