<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    {{ get_title() }}</title>

    <!-- Bootstrap Core CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/lumen/bootstrap.min.css" rel="stylesheet" integrity="sha256-QSktus/KATft+5BD6tKvAwzSxP75hHX0SrIjYto471M= sha512-787L1W8XyGQkqtvQigyUGnPxsRudYU2fEunzUP5c59Z3m4pKl1YaBGTcdhfxOfBvqTmJFmb6GDgm0iQRVWOvLQ==" crossorigin="anonymous">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <!-- Custom CSS -->
    <link href="{{ static_url( "css/app.css" ) }}" rel="stylesheet">
    <!-- JQuery -->
    <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <!-- DataTables -->
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.10/css/dataTables.bootstrap.min.css">
    <script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.10/js/dataTables.bootstrap.min.js"></script>
    <!-- Bootstrap Editable -->
    <link href="//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet"/>
    <script src="//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/js/bootstrap-editable.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $('.dataTable').each(function () {
            var source = $(this).attr("data-source");
            var state = $(this).attr("data-state");
            $(this).DataTable({
                serverSide: true,
                ajax: {
                    url: source,
                    method: 'POST'
                },
                search: {
                    smart: true
                },
                stateSave: true,
                pagingType: "simple_numbers",
                columns: [
                {data: "customerCode", searchable: true,
                "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                    $(nTd).html("<a href='{{ url('customers/view/') }}"+oData.customerCode+"'>"+oData.customerCode+"</a>");
                }},
                {data: "customerName", searchable: true},
                {data: "customerPhone", searchable: true,
                "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                    $(nTd).html("<a href='tel:"+oData.customerPhone+"')>"+oData.customerPhone+"</a>");
                }},
                {data: "customerFax", searchable: false, class: "hidden-xs"},
                {data: "name", searchable: true, class: "hidden-xs",
                "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
                    $(nTd).html("<span class='label label-"+oData.style+"'>"+oData.name+"</span>");
                }},
                ],
            });
            });
        $('div.dataTables_filter input').select();
        $('#enable').click(function() {
            $('.editable').editable('toggleDisabled');
        });   
        $.fn.editable.defaults.mode = 'inline';    
        $('.generaledit').editable();
        $('.editable').editable('toggleDisabled');

        });
    </script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
  </head>
  <body>