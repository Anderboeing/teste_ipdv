<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<cfinclude template="header.cfm">
<!--Load the AJAX API-->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<cfquery name="usuariosPorDepartamento" datasource="teste_ipdv">
    select D.departamento, 
        (SELECT count(nome_completo)
        FROM Usuario AS U
        WHERE D.id = U.id_departamento) AS quantidade
    from Departamento AS D
</cfquery>

<cfquery name="usuariosPorCargo" datasource="teste_ipdv">
    select C.cargo, 
        (SELECT count(nome_completo)
        FROM Usuario AS U
        WHERE C.id = U.id_cargo) AS quantidade
    from Cargo AS C
</cfquery>

<cfquery name="graficoSalario" datasource="teste_ipdv">
    select D.departamento, 
        (SELECT ISNULL(SUM(salario), 0)
        FROM Usuario AS U
        WHERE D.id = U.id_departamento) AS salarioDepartamento
    from Departamento AS D
    order by salarioDepartamento DESC
</cfquery>

<script type="text/javascript">
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawStuff);

    function drawStuff() {
        var data = new google.visualization.arrayToDataTable([
        ['Departamento', 'Usuários'],
        <cfoutput>
            <cfloop query="#usuariosPorDepartamento#">
                <cfif quantidade GT 0>
                    ['#departamento#', #quantidade#],
                </cfif>
            </cfloop>
        </cfoutput>
        ]);

        var options = {
        width: 400,
        chart: {
            title: 'Quantidade de Usuários por Departamento'},
        bar: { groupWidth: "90%" }
        };

        var chart = new google.charts.Bar(document.getElementById('departamento'));
        chart.draw(data, google.charts.Bar.convertOptions(options));
    };
    //==============================================================================================
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawStuffCargo);

    function drawStuffCargo() {
        var data = new google.visualization.arrayToDataTable([
        ['Cargo', 'Usuários'],
        <cfoutput>
            <cfloop query="#usuariosPorCargo#">
                <cfif quantidade GT 0>
                    ['#cargo#', #quantidade#],
                </cfif>
            </cfloop>
        </cfoutput>
        ]);

        var options = {
        width: 400,
        chart: {
            title: 'Quantidade de Usuários por Cargo'},
        bar: { groupWidth: "90%" }
        };

        var chart = new google.charts.Bar(document.getElementById('cargo'));
        chart.draw(data, google.charts.Bar.convertOptions(options));
    };

    //==============================================================================================
    // Gráfico salário
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Departamentos');
        data.addColumn('number', 'Salários');
        data.addRows([
            <cfoutput>
                <cfloop query="#graficoSalario#">
                    <cfif salarioDepartamento GT 0>
                        ['#departamento#', #salarioDepartamento#],
                    </cfif>
                </cfloop>
            </cfoutput>
        ]);

        // Set chart options
        var options = {'title':'Salários por Departamento',
                        'width':600,
                        'height':400};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.BarChart(document.getElementById('salario'));
        chart.draw(data, options);
    }
</script>
<div class="graficos">
    <div id="departamento" style="width: 400px; height: 400px;"></div>
    <div id="cargo" style="width: 400px; height: 400px;"></div>
    <div id="salario"></div>
</div>
<cfinclude template="footer.cfm">