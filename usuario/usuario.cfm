<cfoutput>
    <cfquery name="usuario" datasource="teste_ipdv">
        select U.id, nome_completo, data_nascimento, cidade, salario, C.cargo, D.departamento
            from Usuario As U 
            INNER JOIN Cargo as C on U.id_cargo = C.id
            INNER JOIN Departamento as D on U.id_departamento = D.id
    </cfquery>

    <cfquery name="cargos" datasource="teste_ipdv">
        select id, cargo from Cargo
    </cfquery>
    <cfquery name="departamentos" datasource="teste_ipdv">
        select id, departamento from Departamento
    </cfquery>
    <cfinclude template="../header.cfm">
    <div class="container-xl">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Usuários</h2>
                        </div>
                        <div class="col-sm-6">
                            <a href="##criarUsuario" class="btn btn-success" data-toggle="modal">
                                <span>Adicionar Usuário</span>
                            </a>
                            <a href="importarDados.cfm" class="btn btn-primary">Importar</a>
                            <a href="crudUsuario.cfm?excluirTodos=true" class="btn btn-Danger">
                                <span>Deletar todos</span>
                            </a>
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Nome completo</th>
                            <th>Cargo</th>
                            <th>Departamento</th>
                            <th>Data nascimento</th>
                            <th>Cidade</th>
                            <th>Salário</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="usuario">
                            <tr>
                                <td>#usuario.nome_completo#</td>
                                <td>#usuario.cargo#</td>
                                <td>#usuario.departamento#</td>
                                <td><cfif len(usuario.data_nascimento) GT 0>#usuario.data_nascimento.dateFormat('dd/mm/yyyy')#</cfif></td>
                                <td>#usuario.cidade#</td>
                                <td>#LSCurrencyFormat(usuario.salario, 'local', 'pt_BR')#</td>
                                <td>
                                    <a href="CrudUsuario.cfm?id=#usuario.id#" class="edit verticalAlign">
                                        <i class="fa fa-edit" data-toggle="tooltip" title="" data-original-title="Edit"></i>
                                    </a>
                                    <a href="/usuario/read.cfm?id=#usuario.id#" class="book verticalAlign">
                                        <i class="fa fa-book" data-toggle="tooltip" title="" data-original-title="read"></i>
                                    </a>
                                    <button class="btn delete" data-href="CrudUsuario.cfm?id=#usuario.id#&delete=S" data-toggle="modal" data-target="##confirm-delete">
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

    <div id="criarUsuario" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <cfform name="form" action="/usuario/crudUsuario.cfm">
                    <div class="modal-header">
                        <h4 class="modal-title">Criar usuário</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Nome Completo</label>
                            <input type="text" name="nome_completo" maxLength="50" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Cargo</label>
                            <select name="id_cargo" class="form-control" required>
                                <option disabled selected value></option>
                                <cfloop query="cargos">
                                    <option value="#cargos.id#">#cargos.cargo#</option>
                                </cfloop>
                              </select>
                        </div>
                        <div class="form-group">
                            <label>Departamento</label>
                            <select name="id_departamento" class="form-control" required>
                                <option disabled selected value></option>
                                <cfloop query="departamentos">
                                    <option value="#departamentos.id#">#departamentos.departamento#</option>
                                </cfloop>
                              </select>
                        </div>
                        <div class="form-group">
                            <label>Data de Nascimento</label>
                            <input type="date" name="data_nascimento" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Cidade</label>
                            <input type="text" name="cidade" maxLength="50" class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Salário</label>
                            <input type="number" name="salario" max="9999999999" class="form-control" required>
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
                    <h4 class="modal-title">Excluir usuário</h4>
                </div>
                <div class="modal-body">
                    <p>Você tem certeza que quer deletar este usuário?</p>
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