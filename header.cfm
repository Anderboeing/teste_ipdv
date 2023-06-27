<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Teste IPDV</title>
        <link rel="stylesheet" href="../css/externas/fonte-roboto.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="../css/estilos.css">
        <link rel="stylesheet" href="../css/mensageria.css">
        <link rel="icon" href="/imagens/favicon-96.png" sizes="any">
    </head>
    <body class="d-flex flex-column min-vh-100">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <div class="navbar-nav">
                        <a class="nav-item nav-link" href="/index.cfm" title="Home">Home</a>
                        <a class="nav-item nav-link" href="/usuario/usuario.cfm" title="Usuários">Usuários</a>
                        <a class="nav-item nav-link" href="/cargo/cargo.cfm" title="Cargos">Cargos</a>
                        <a class="nav-item nav-link" href="/departamento/departamento.cfm" title="Departamentos">Departamentos</a>
                    </div>
                </div>
            </div>
        </nav>
        <cfoutput>
            <cfif structKeyExists(url,'msg')>
                <div class="success">#url.msg#</div>
            <cfelseif structKeyExists(url,'error')>
                <div class="error">#url.error#</div>
            <cfelseif structKeyExists(url,'warning')>
                <div class="warning">#url.warning#</div>
            </cfif>
            

        </cfoutput>
